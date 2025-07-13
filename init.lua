-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.cursorline = false
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })

-- Debug: print filetype on every buffer window enter

-- Set wrap for preview windows with specific filetype
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.bo.filetype == "snacks_picker_preview" then
      vim.opt_local.wrap = true
    end
  end,
})


