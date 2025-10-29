-- Global variable to store the terminal buffer ID dedicated to Jest tests.
local jest_term_buf_id = nil

local function run_in_terminal(cmd)
  local win_id = nil
  local target_buf_id = jest_term_buf_id

  -- 1. Check if the terminal buffer exists and is valid
  if target_buf_id and vim.api.nvim_buf_is_valid(target_buf_id) then
    -- Find a window displaying this buffer in the current tab
    local windows = vim.api.nvim_tabpage_list_wins(0)
    for _, w_id in ipairs(windows) do
      if vim.api.nvim_win_get_buf(w_id) == target_buf_id then
        win_id = w_id
        break
      end
    end

    if win_id then
      -- If the window is found, switch to it
      vim.api.nvim_set_current_win(win_id)
    else
      -- If the buffer exists but its window was closed, split a new one for it
      vim.o.splitright = true
      vim.cmd("vsplit")
      vim.api.nvim_set_current_buf(target_buf_id)
      win_id = vim.api.nvim_get_current_win()
    end

    -- Clear the existing terminal output before rerunning
    -- This sends the terminal-clearing control sequence (Ctrl-L).
    vim.cmd("normal! C-l")
    
    -- *** NEW CRUCIAL FIX HERE ***
    -- Ensure the buffer is not marked as modified before starting a new job.
    -- The previous 'C-l' command can mark it as modified.
    vim.api.nvim_buf_set_option(target_buf_id, "modified", false)

  else
    -- 2. Create a new buffer and split if it doesn't exist
    vim.o.splitright = true
    vim.cmd("vsplit")
    jest_term_buf_id = vim.api.nvim_create_buf(false, true)
    target_buf_id = jest_term_buf_id
    vim.api.nvim_set_current_buf(target_buf_id)
    win_id = vim.api.nvim_get_current_win()
    -- New terminal buffers start unmodified by default, so no need to set 'modified' here.
  end

  -- 3. Open/Re-open the terminal in the active buffer
  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      vim.schedule(function()
        -- FIX: The buffer becomes non-modifiable after job exit,
        -- so we must set it to true to allow 'stopinsert'.
        if vim.api.nvim_buf_is_valid(target_buf_id) then
            vim.api.nvim_buf_set_option(target_buf_id, "modifiable", true)
        end
        
        -- Move focus back to the terminal window if it's still valid
        if win_id and vim.api.nvim_win_is_valid(win_id) then
          vim.api.nvim_set_current_win(win_id)
          
          -- Stop insert mode so you can scroll
          vim.cmd("stopinsert")
        end
        
        -- Print exit code in message area
        print("Command finished with exit code:", exit_code)
      end)
    end,
  })

  -- 4. Ensure the window is focused and start insert mode (for the terminal)
  if win_id and vim.api.nvim_win_is_valid(win_id) then
      vim.api.nvim_set_current_win(win_id)
  end
  vim.cmd("startinsert")
end

-- ---

-- Keymap to run Jest on the current file
vim.keymap.set("n", "<F10>", function()
  local current_file = vim.fn.expand("%:p")
  run_in_terminal({ "npx", "jest", current_file })
end, { desc = "Run Jest on current file" })
