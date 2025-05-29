
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  cmd = { "ObsidianOpen", "ObsidianQuickSwitch", "ObsidianFollowLink" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "G:/My Drive/My folder/Obsidian/Zettelkasten",
    workspaces = {
      { name = "personal", path = "G:/My Drive/My folder/Obsidian/Zettelkasten" },
    },
    workspace = "personal",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.api.nvim_create_user_command("ZkOpen", function()
      require("obsidian").open(opts.dir)
    end, {})
  end,
}
