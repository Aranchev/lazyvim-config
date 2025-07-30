
vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_picker_preview",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})


-- Set wrap for preview windows with specific filetype
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.bo.filetype == "snacks_picker_preview" then
      vim.opt_local.wrap = true
    end
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    if vim.o.foldmethod == "expr" then
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end
  end,
})
