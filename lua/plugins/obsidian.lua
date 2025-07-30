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
        path = "G:/My Drive/My folder/Obsidian", -- full absolute Windows path
      },
    },

    note_id_func = function(title)
      return title
    end,

    debug = true,

    daily_notes = {
      folder = "",                -- folder inside vault for daily notes
      date_format = "%Y-%m-%d",
      template = "daily.md",      -- must be in templates folder
    },

    templates = {
      subdir = "templates",       -- where your templates live
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- ✅ This is your fixed function
    follow_url_func = function(url)
      if vim.fn.has("win32") == 1 then
        vim.fn.jobstart({ "cmd.exe", "/C", "start", "", url }, { detach = true })
      elseif vim.fn.has("mac") == 1 then
        vim.fn.jobstart({ "open", url }, { detach = true })
      elseif vim.fn.has("unix") == 1 then
        vim.fn.jobstart({ "xdg-open", url }, { detach = true })
      else
        print("Cannot open URL: Unsupported system")
      end
    end,
  },
}
