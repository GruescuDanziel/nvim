local M = {}

-- Utility to find project root (upwards search for common files)
local function find_root()
  local cwd = vim.loop.cwd()
  local root_marker = { 'package.json', 'Makefile', 'composer.json', '.git' }
  return vim.fs.find(root_marker, { upward = true, stop = vim.env.HOME or '/' })[1]
end

-- ====================================================================
-- 1. Configuration File Parsing
-- ====================================================================

-- Parse scripts from package.json
local function parse_package_json(root_dir)
  local path = root_dir

    vim.notify(path, vim.log.levels.INFO)
  if not vim.loop.fs_stat(path) then
    return {}
  end

  local content = vim.fn.readfile(path)
  local json = vim.fn.json_decode(table.concat(content, '\n'))
  local results = {}

  
  
  -- Handle both 'scripts' and potential other common runner groups if necessary,
  -- but stick to 'scripts' for simplicity and coverage.
  local scripts = json and json.scripts or {}


  for name, command in pairs(scripts) do
    -- Determine whether to use npm or yarn based on a lock file, default to npm
    local runner = vim.loop.fs_stat(root_dir .. '/yarn.lock') and 'yarn run ' or 'npm run '

    table.insert(results, {
      name = name,
      command = runner .. name, 
      source = 'package.json',
      display = string.format('📦 %s: %s', name, command)
    })
  end
  return results
end

-- Parse targets from a Makefile
local function parse_makefile(root_dir)
  local path = root_dir .. '/Makefile'
  if not vim.loop.fs_stat(path) then
    return {}
  end

  local lines = vim.fn.readfile(path)
  local results = {}

  for _, line in ipairs(lines) do
    -- FIX: Use [[...]] for robust pattern matching.
    -- Pattern: starts at the beginning of the line (^), followed by optional whitespace (%s*),
    -- captures a target name (%S+), followed by a colon (:) that isn't immediately followed by an equals sign ([^=]).
    local target = line:match([[^%s*(%S+):[^=]])
    if target and not target:match("^[%.#]") then -- Ignore hidden targets (.PHONY) and comments
      table.insert(results, {
        name = target,
        command = 'make ' .. target,
        source = 'Makefile',
        display = string.format('🔨 %s', target)
      })
    end
  end
  return results
end

-- Combine all parsers
local function get_project_commands()
  local root = find_root()
  if not root then
    vim.notify("Could not find project root marker (e.g., package.json or .git).", vim.log.levels.WARN)
    return {}
  end

  local commands = {}
  
  -- Run parsers
  vim.list_extend(commands, parse_package_json(root))
  vim.list_extend(commands, parse_makefile(root))
  
  return commands
end

-- ====================================================================
-- 2. Command Execution Utility
-- ====================================================================

-- Function to run command in a new terminal
local function run_in_terminal(cmd)
  vim.o.splitright = true
  vim.cmd("vsplit")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  
  -- Switch to the project root directory before running the command
  local root = find_root() or vim.loop.cwd()
  vim.cmd('lcd ' .. root)
  
  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      vim.schedule(function()
        vim.cmd("stopinsert")
        print("Command finished with exit code:", exit_code)
      end)
    end,
  })
  vim.cmd("startinsert")
end


-- ====================================================================
-- 3. Telescope Picker
-- ====================================================================

function M.pick_and_run()
  local ok = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope not found!", vim.log.levels.ERROR)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local commands = get_project_commands()

  if #commands == 0 then
    return
  end

  local function run_selected(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local cmd = selection.value.command
    actions.close(prompt_bufnr)
    run_in_terminal(cmd)
  end

  pickers.new({}, {
    prompt_title = "🛠️ Project Scripts",
    finder = finders.new_table({
      results = commands,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          -- Use a combination of source and name for sorting/filtering
          ordinal = string.format("%s %s", entry.source, entry.name),
        }
      end,
    }),
    attach_mappings = function(_, map)
      map("i", "<CR>", run_selected)
      map("n", "<CR>", run_selected)
      return true
    end,
  }):find()
end

return M
