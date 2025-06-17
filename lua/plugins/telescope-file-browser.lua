return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").load_extension("file_browser")

    -- Optional: keymap to open the file browser quickly
    vim.keymap.set("n", "<leader>fb", function()
      require("telescope").extensions.file_browser.file_browser()
    end, { desc = "Open Telescope File Browser" })
  end,
}


