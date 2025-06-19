vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = "Set cwd to current file's dir" })
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { desc = "Run current file" })
vim.keymap.set('n', '<leader>r', ':LspRestart marksman<CR>', { desc = "Restart marksman LSP" })

-- Obsidian
vim.keymap.set("v", "<leader>ol", ":ObsidianLink<Space>", { desc = "Obsidian: Link to Note" })
vim.keymap.set("n", "<leader>ot", ":ObsidianTOC<CR>", { desc = "ObsidiaTOC" })
vim.keymap.set("n", "<leader>ol", ":ObsidianLinks<CR>", { desc = "Obsidian Links" })
vim.keymap.set("n", "<leader>oh", ":ObsidianFollowLink hsplit<CR>", { desc = "Obsidian: Follow Link (hsplit)" })
vim.keymap.set("n", "<leader>ov", ":ObsidianFollowLink vsplit<CR>", { desc = "Obsidian: Follow Link (vsplit)" })
vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
vim.keymap.set("n", "<leader>or", ":ObsidianRename<CR>", { desc = "Obsidian Rename Note" })
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Obsidian Search Notes" })
vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>', { silent = true, noremap = true })

vim.keymap.set("n", "<leader>on", function()
  local title = vim.fn.input("Note title: ")
  if title ~= "" then
    vim.cmd("ObsidianNew " .. title)
  end
end, { desc = "New Obsidian note with title" })

