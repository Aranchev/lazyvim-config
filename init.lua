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



