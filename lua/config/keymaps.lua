-- run code
vim.keymap.set('n', '<leader>ru', ':w<CR>:RunCode<CR>', { desc = "run code: save current file and run it" })
vim.keymap.set('n', '<leader>pt',
  ':w<CR>:split | terminal cmd /c "set PYTHONPATH=C:\\Users\\Emi Nikolova\\pytest_fundamental && pytest \"%\""<CR>',
  { noremap = true, silent = true, desc = 'run code: run pytest in pytest_fundamental' }
)

-- set dir, go to
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = "set dir: to current file's dir" })
vim.keymap.set('n', '<leader>da', ':lua Snacks.dashboard()<CR>', { desc = "go to: dashboard" })

vim.keymap.set("n", "<leader>d1", function()
  vim.cmd.cd("G:/My Drive/My folder/Obsidian")
end, { desc = "set dir: to Obsidian vault" })

vim.keymap.set("n", "<leader>d2", function()
  vim.cmd.cd("C:/Users/Emi Nikolova/pytest_fundamental")
end, { desc = "set dir: to pytest_fundamental" })

vim.keymap.set("n", "<leader>d3", function()
  vim.cmd.cd("C:/Users/Emi Nikolova/microblog")
end, { desc = "set dir: to microblog" })

vim.keymap.set("n", "<leader>d4", function()
  vim.cmd.cd("C:/Users/Emi Nikolova/AppData/Local/nvim")
end, { desc = "set dir: nvim" })


-- txt formating
vim.keymap.set("v", "<A-h>", function()
  -- Save the visual selection
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  -- Expand selection to include last character
  vim.cmd('normal! `<i==')
  vim.cmd('normal! `>la==')
end, { desc = "text formating: wrap selection with ==", silent = true })

vim.keymap.set("v", "<A-b>", function()
  -- Save the visual selection
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  -- Expand selection to include last character
  vim.cmd('normal! `<i**')
  vim.cmd('normal! `>la**')
end, { desc = "text formating: wrap selection with ** ", silent = true })


-- Obsidian keymaps
vim.keymap.set("n", "<leader>ody", ":ObsidianYesterday<CR>", { desc = "Obsidian: ObsidianYesterday" })
vim.keymap.set("n", "<leader>odt", ":ObsidianToday<CR>", { desc = "Obsidian: ObsidianToday" })
vim.keymap.set("n", "<leader>odm", ":ObsidianTomorrow<CR>", { desc = "Obsidian: ObsidianTomorrow" })
vim.keymap.set("v", "<leader>ol", ":ObsidianLink<Space>", { desc = "Obsidian: Link to Note" })
vim.keymap.set("n", "<leader>oc", ":ObsidianTOC<CR>", { desc = "Obsidian: ObsidianTOC" })
vim.keymap.set("n", "<leader>ol", ":ObsidianLinks<CR>", { desc = "Obsidian: ObsidianLinks" })
vim.keymap.set("n", "<leader>oh", ":ObsidianFollowLink hsplit<CR>", { desc = "Obsidian: Follow Link (hsplit)" })
vim.keymap.set("n", "<leader>ov", ":ObsidianFollowLink vsplit<CR>", { desc = "Obsidian: Follow Link (vsplit)" })
vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian: ObsidianQuickSwitch" })
vim.keymap.set("n", "<leader>or", ":ObsidianRename<CR>", { desc = "Obsidian: ObsidianRename" })
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Obsidian: ObsidianSearch" })
vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>', { silent = true, noremap = true })

vim.keymap.set("n", "<leader>on", function()
  local title = vim.fn.input("Note title: ")
  if title ~= "" then
    vim.cmd("ObsidianNew " .. title)
  end
end, { desc = "Obsidian: New Obsidian note with title" })

-- telescope
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, {
  desc = 'telescope: Browse keymaps',
  noremap = true,
  silent = true,
})


-- open url
vim.keymap.set("n", "<leader>ou", function()
  local line = vim.api.nvim_get_current_line()
  -- Match the reference ID (e.g., [1]) at the end of a link like [text][1]
  local ref = line:match("%[.-%]%[([^%]]+)%]$")
  if ref then
    -- Escape the reference ID for searching (e.g., [1])
    local ref_line = vim.fn.search("\\[" .. vim.fn.escape(ref, "[]") .. "\\]:", "n")
    if ref_line > 0 then
      -- Extract the URL from the reference definition (e.g., [1]: https://...)
      local url = vim.api.nvim_buf_get_lines(0, ref_line - 1, ref_line, false)[1]:match("%[" .. vim.fn.escape(ref, "[]") .. "%]:%s*(.+)")
      if url and url:match("^https?://") then
        -- Use cmd.exe to run the start command
        vim.fn.system({ "cmd.exe", "/c", "start", "", url })
        vim.notify("Opening URL: " .. url, vim.log.levels.INFO)
      else
        vim.notify("No valid URL found in reference", vim.log.levels.ERROR)
      end
    else
      vim.notify("Reference definition not found", vim.log.levels.ERROR)
    end
  else
    vim.notify("No reference link found", vim.log.levels.ERROR)
  end
end, { desc = "Open URL from reference link" })


-- Comment lines with '# '
vim.api.nvim_create_user_command('C', function(opts)
  local start_line = opts.line1
  local end_line = opts.line2

  for lnum = start_line, end_line do
    local line = vim.fn.getline(lnum)
    if not line:match("^%s*#") then
      vim.fn.setline(lnum, '# ' .. line)
    end
  end
end, { range = true })

-- Uncomment lines with '# '
vim.api.nvim_create_user_command('UC', function(opts)
  local start_line = opts.line1
  local end_line = opts.line2

  for lnum = start_line, end_line do
    local line = vim.fn.getline(lnum)
    local uncommented = line:gsub("^%s*#%s?", "", 1)
    vim.fn.setline(lnum, uncommented)
  end
end, { range = true })

