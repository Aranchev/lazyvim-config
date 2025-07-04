vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = "Set cwd to current file's dir" })
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { desc = "Run current file" })
vim.keymap.set('n', '<leader>r', ':LspRestart marksman<CR>', { desc = "Restart marksman LSP" })
vim.keymap.set('n', '<leader>da', ':lua Snacks.dashboard()<CR>', { desc = "Dashboard" })

vim.keymap.set("v", "<A-h>", function()
  -- Save the visual selection
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  -- Expand selection to include last character
  vim.cmd('normal! `<i==')
  vim.cmd('normal! `>la==')
end, { desc = "Wrap selection with ==", silent = true })


vim.keymap.set("v", "<A-b>", function()
  -- Save the visual selection
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  -- Expand selection to include last character
  vim.cmd('normal! `<i**')
  vim.cmd('normal! `>la**')
end, { desc = "Wrap selection with ", silent = true })


-- Obsidian
--
vim.keymap.set("n", "<leader>ody", ":ObsidianYesterday<CR>", { desc = "ObsidianYesterday" })
vim.keymap.set("n", "<leader>odt", ":ObsidianToday<CR>", { desc = "ObsidianToday" })
vim.keymap.set("n", "<leader>odm", ":ObsidianTomorrow<CR>", { desc = "ObsidianTomorrow" })
vim.keymap.set("v", "<leader>ol", ":ObsidianLink<Space>", { desc = "Obsidian: Link to Note" })
vim.keymap.set("n", "<leader>oc", ":ObsidianTOC<CR>", { desc = "ObsidiaTOC" })
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

-- Directory shortcuts

vim.keymap.set("n", "<leader>d1", function()
  vim.cmd.cd("G:/My Drive/My folder/Obsidian")
end, { desc = "Obsidian vault" })

vim.keymap.set("n", "<leader>d2", function()
  vim.cmd.cd("C:/Users/Emi Nikolova/pytest_fundamental")
end, { desc = "pytest_fundamental" })
