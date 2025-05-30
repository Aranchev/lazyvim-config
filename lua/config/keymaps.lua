vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = "Set cwd to current file's dir" })
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { desc = "Run current file" })
