return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["q"] = "actions.close",
    },
  },
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      desc = "Open Oil (Parent Directory)",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icons
}


