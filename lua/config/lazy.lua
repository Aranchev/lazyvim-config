local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.opt.wrap = true

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Disable gitsigns.nvim (prevents that error)
    {
      "lewis6991/gitsigns.nvim",
      enabled = false,
    },

    { import = "plugins" },  -- or { import = "plugins.code_runner" } if just one file
    -- other plugin specs if any
  },

  -- Default plugin options
  defaults = {
    lazy = false,
    version = false,
  },

  -- Color schemes to install
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },

  -- Plugin update checker options
  checker = {
    enabled = true,
    notify = false,
  },


  -- Performance tweaks (disabling some builtin plugins)
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

