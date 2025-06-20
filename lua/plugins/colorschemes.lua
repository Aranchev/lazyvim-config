return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,  -- load immediately (so colorscheme is available early)
    priority = 1000, -- high priority to load before other plugins

    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- options: latte, frappe, macchiato, mocha
        transparent_background = false,
        styles = {
          comments = { "italic" },
          functions = { "bold" },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = true,
          -- add more integrations as needed
        },
      })
      vim.cmd.colorscheme("catppuccin")
      vim.api.nvim_set_hl(0, "markdownH1", { fg = "#F1FA8C", bold = true })
    end,
  },
}

