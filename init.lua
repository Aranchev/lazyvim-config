-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.cursorline = false
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })

