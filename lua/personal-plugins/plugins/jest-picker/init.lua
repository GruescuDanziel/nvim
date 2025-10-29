local M = {}

-- ===============================
-- Terminal helper
-- ===============================
local function run_in_terminal(cmd)
  vim.o.splitright = true
  vim.cmd("vsplit")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
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

-- Parse the file into a proper nested tree
local function parse_test_tree()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  -- The root node now carries the initial scope depth
  local root = { name = "root", type = "root", children = {}, collapsed = false, scope_depth = 0 }
  local stack = { root }
  
  for _, line in ipairs(lines) do
    -- Always update current_scope_depth to the top of the stack's depth
    local current_scope_depth = stack[#stack].scope_depth

    local describe_name = line:match('%f[%w_]describe%s*%(%s*["\'](.-)["\']')
    local test_name = line:match('%f[%w_]it%s*%(%s*["\'](.-)["\']')
                      or line:match('%f[%w_]test%s*%(%s*["\'](.-)["\']')
    
    local open_braces = #line:gsub("[^{]", "")
    local close_braces = #line:gsub("[^}]", "")
    
    local is_root_parent = (stack[#stack].type == "root")
    
    local new_node = nil

    if describe_name then
      new_node = { name = describe_name, type = "describe", children = {}, collapsed = true, scope_depth = 0 }
      
      -- Insert the new node
      if is_root_parent then
        -- REVERSE INSERTION for root children (handles "upside down" file structure)
        table.insert(stack[#stack].children, 1, new_node)
      else
        -- NORMAL APPEND for nested children (maintains written order)
        table.insert(stack[#stack].children, new_node)
      end

      table.insert(stack, new_node) -- push new describe to stack
      
      -- Set the new node's starting scope depth based on braces on the same line
      stack[#stack].scope_depth = open_braces
      
    elseif test_name then
      new_node = { name = test_name, type = "test" }
      
      -- Insert the new node
      if is_root_parent then
        -- REVERSE INSERTION for root children (handles "upside down" file structure)
        table.insert(stack[#stack].children, 1, new_node)
      else
        -- NORMAL APPEND for nested children (maintains written order)
        table.insert(stack[#stack].children, new_node)
      end
      
      -- Process braces: affects the current describe block's scope depth
      stack[#stack].scope_depth = current_scope_depth + open_braces
      
    else
      -- Only process braces on non-describe/test lines, affecting the current block
      stack[#stack].scope_depth = current_scope_depth + open_braces
    end

    -- Decrement depth by counting close braces on the line
    stack[#stack].scope_depth = stack[#stack].scope_depth - close_braces

    -- Pop the describe block ONLY when its scope depth returns to zero (or less)
    if stack[#stack].scope_depth <= 0 and #stack > 1 then
      table.remove(stack)
    end
  end

  return root.children
end

-- Flatten tree preserving hierarchy: describe first, then children
local function flatten_tree(nodes, parent_path, prefix, results)
  results = results or {}
  prefix = prefix or ""
  parent_path = parent_path or ""
  local branch, last_branch = "├─ ", "└─ "
  local folder_icon, test_icon = "📁 ", "🔹 "

  for i, node in ipairs(nodes) do
    local is_last = (i == #nodes)
    local branch_sym = is_last and last_branch or branch

    -- Create the clean path for the ordinal (e.g., "describe A > test 1")
    local current_path = parent_path .. (parent_path == "" and "" or " > ") .. node.name
    node.path = current_path -- Store the path on the node

    local display
    if node.type == "describe" then
      local marker = node.collapsed and "▸ " or "▾ "
      display = prefix .. branch_sym .. marker .. folder_icon .. node.name
      table.insert(results, { display = display, node = node })
      -- Only recurse if expanded
      if not node.collapsed and node.children then
        local next_prefix = prefix .. (is_last and "   " or "│  ")
        -- Pass the new path to the recursive call
        flatten_tree(node.children, current_path, next_prefix, results)
      end
    else
      -- test nodes
      display = prefix .. branch_sym .. test_icon .. node.name
      table.insert(results, { display = display, node = node })
    end
  end

  return results
end

-- ===============================
-- Telescope picker
-- ===============================
function M.pick_and_run_test()
  local ok = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope not found!", vim.log.levels.ERROR)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local tree = parse_test_tree()

  local function make_finder()
    local flat = flatten_tree(tree)
    return finders.new_table({
      results = flat,
      entry_maker = function(entry)
        return {
          value = entry.node,
          display = entry.display,
          -- Use the clean path for ordinal (sorting/filtering)
          ordinal = entry.node.path,
          -- Use the display string for the displayed line
          grep_line = entry.display,
        }
      end,
    })
  end

  local function refresh_picker(picker)
    picker:refresh(make_finder(), { reset_prompt = false })
  end

  pickers.new({}, {
    prompt_title = "🧪 Jest Tests",
    finder = make_finder(),
    -- Sorter is removed, using Telescope's default sorter
    attach_mappings = function(_, map)
      local run_selected = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local node = selection.value
        actions.close(prompt_bufnr)

        local current_file = vim.fn.expand("%")
        if node.type == "test" then
          run_in_terminal({ "npx", "jest", current_file, "-t", node.name })
        elseif node.type == "describe" then
          run_in_terminal({ "npx", "jest", current_file, "-t", node.name })
        end
      end

      local toggle_node = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local node = selection.value
        if node.type == "describe" then
          node.collapsed = not node.collapsed
          refresh_picker(action_state.get_current_picker(prompt_bufnr))
        end
      end

      map("i", "<CR>", run_selected)
      map("n", "<CR>", run_selected)

      map("i", "<Right>", toggle_node)
      map("i", "<Left>", toggle_node)
      map("n", "<Right>", toggle_node)
      map("n", "<Left>", toggle_node)

      return true
    end,
  }):find()
end

function M.run_current_file()
  local current_file = vim.fn.expand("%")
  run_in_terminal({ "npx", "jest", current_file })
end

return M
