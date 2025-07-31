return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        styles = {
          comments = { "italic" },
          functions = { "bold" },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = true,
        },
      })

      vim.cmd.colorscheme("catppuccin")

      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = { "markdown" },
        },
      })

      vim.api.nvim_set_hl(0, "markdownH1", { fg = "#089e10", bold = true })
      vim.api.nvim_set_hl(0, "markdownH2", { fg = "#611855", bold = true })
    end,
  },
}

