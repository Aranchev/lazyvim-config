
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
    note_id_func = function(title)
      -- Use the title (link text) as filename directly, no ID prefix
      return title
    end,
    debug = true,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
  end,
}
