
return {
  "epwalsh/obsidian.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "myvault",
        path = "G:/My Drive/My folder/Obsidian",
      },
    },
    debug = true,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
  end,
}
