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
      return title
    end,
    debug = true,
    daily_notes = {
      date_format = "%Y-%m-%d",
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Date at 12:00 noon to avoid timezone bugs
    local function get_midday_date(offset_days)
      local now = os.date("*t") -- Local time
      now.day = now.day + offset_days
      now.hour = 12
      now.min = 0
      now.sec = 0
      local ts = os.time(now)
      return os.date("%Y-%m-%d", ts)
    end

    vim.api.nvim_create_user_command("ObsidianTodayFixed", function()
      require("obsidian").open_daily({ date = get_midday_date(0) })
    end, {})

    vim.api.nvim_create_user_command("ObsidianYesterdayFixed", function()
      require("obsidian").open_daily({ date = get_midday_date(-1) })
    end, {})

    vim.api.nvim_create_user_command("ObsidianTomorrowFixed", function()
      require("obsidian").open_daily({ date = get_midday_date(1) })
    end, {})
  end,
}

