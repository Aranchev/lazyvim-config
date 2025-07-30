-- ~/.config/nvim/lua/plugins/term.lua
return {
  "akinsho/toggleterm.nvim",
  config = function()
    -- Configure toggleterm with a smaller size
    require("toggleterm").setup {
      size = 10, -- Reduced from 20 to 10 lines for a smaller terminal
      open_mapping = nil,
      direction = "horizontal",
      close_on_exit = false,
      shade_terminals = true,
      start_in_insert = true,
    }

    local Terminal = require("toggleterm.terminal").Terminal
    local file_term = nil

    local function toggle_file_dir_terminal()
      -- Get the directory of the current buffer's file
      local file_dir = vim.fn.expand("%:p:h")
      if file_dir == "" then
        file_dir = vim.fn.getcwd()
        print("No file directory, using cwd: " .. file_dir) -- Debug
      else
        print("Using file directory: " .. file_dir) -- Debug
      end

      -- If terminal is open, close it
      if file_term and file_term:is_open() then
        file_term:toggle()
        return
      end

      -- If terminal exists but directory has changed, recreate it
      if file_term and file_term.dir ~= file_dir then
        file_term:close()
        file_term = nil
      end

      -- Create new terminal if none exists
      if not file_term then
        file_term = Terminal:new({
          dir = file_dir,
          direction = "horizontal",
          close_on_exit = false,
          on_open = function(term)
            vim.api.nvim_buf_call(term.bufnr, function()
              vim.cmd("cd " .. file_dir) -- Ensure shell is in correct dir
            end)
            vim.cmd("startinsert")
          end,
          on_close = function()
            print("Terminal closed") -- Debug
          end,
        })
      end

      -- Toggle the terminal
      file_term:toggle()
    end

    -- Keybinding for both normal and terminal modes
    local toggle_key = "<F1>"

    vim.keymap.set("n", toggle_key, toggle_file_dir_terminal, { desc = "Toggle Terminal (File Dir)", noremap = true, silent = true })
    vim.keymap.set("t", toggle_key, function()
      vim.cmd("stopinsert")
      vim.schedule(toggle_file_dir_terminal)
    end, { desc = "Toggle Terminal (File Dir)", noremap = true, silent = true })
  end,
}
