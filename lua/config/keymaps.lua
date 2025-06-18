vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = "Set cwd to current file's dir" })
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { desc = "Run current file" })
vim.keymap.set("n", "<leader>or", ":ObsidianRename<CR>", { desc = "Obsidian Rename Note" })
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Obsidian Search Notes" })

vim.keymap.set("n", "<leader>on", function()
  local title = vim.fn.input("Note title: ")
  if title ~= "" then
    vim.cmd("ObsidianNew " .. title)
  end
end, { desc = "New Obsidian note with title" })

vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>', { silent = true, noremap = true })
