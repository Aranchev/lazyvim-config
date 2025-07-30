-- Enable Markdown fenced code block syntax highlighting
vim.g.markdown_fenced_languages = {
  "html",
  "python",
  "bash=sh",
  "javascript",
  "json",
  "lua",
  "c",
  "cpp",
  "java",
  "ruby"
}

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.cursorline = false
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })

-- Set wrap for preview windows with specific filetype
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.bo.filetype == "snacks_picker_preview" then
      vim.opt_local.wrap = true
    end
  end,
})

-- Treesitter folding setup
vim.opt.wrap = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    if vim.o.foldmethod == "expr" then
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end
  end,
})
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


