return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- load immediately
    priority = 1000, -- load early for colorscheme

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

      -- Disable Treesitter for Markdown to allow markdownH1, markdownH2, etc.
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = { "markdown" }, -- fallback to Vim syntax highlighting
        },
      })

      -- Now this will take effect
      vim.api.nvim_set_hl(0, "markdownH1", { fg = "#089e10", bold = true })
      vim.api.nvim_set_hl(0, "markdownH2", { fg = "#611855", bold = true })
    end,
  },
}

