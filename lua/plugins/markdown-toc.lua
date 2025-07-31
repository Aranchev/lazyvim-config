return {
  {
    "mzlogin/vim-markdown-toc",
    ft = "markdown",
    config = function()
      -- Plugin settings
      vim.g.vmt_auto_update_on_save = 0 -- Disable auto-update to avoid conflicts
      vim.g.vmt_fence_text = "TOC" -- Opening fence: <!-- TOC -->
      vim.g.vmt_fence_closing_text = "/TOC" -- Closing fence: <!-- /TOC -->
      vim.g.vmt_list_item_char = "-" -- Use '-' for TOC items
      vim.g.vmt_fence_hidden_markdown_style = "GFM" -- Default to GFM

      -- Autocommand for Markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()

          -- Function to initialize or repair TOC under # TOC
          local function init_or_repair_toc()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local yaml_end = nil
            local toc_start = nil
            local toc_end = nil

            -- Find YAML end and TOC markers
            for i, line in ipairs(lines) do
              if line:match("^---$") and i > 1 then
                yaml_end = i
              end
              if line:match("^# TOC$") then
                toc_start = i
              end
              if line:match("^<!%-%- /TOC %-%->$") then
                toc_end = i
              end
            end

            -- If # TOC doesn't exist, create it after YAML or at top
            if not toc_start then
              if yaml_end then
                vim.api.nvim_buf_set_lines(bufnr, yaml_end, yaml_end, false, { "", "# TOC", "" })
                toc_start = yaml_end + 1
              else
                vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "# TOC", "" })
                toc_start = 1
              end
            end

            -- If TOC exists but end fence is missing, repair it
            if toc_start and not toc_end then
              for i = toc_start + 1, #lines do
                if lines[i]:match("^<!%-%- TOC %-%->$") then
                  local last_list_item = i
                  for j = i + 1, #lines do
                    if not lines[j]:match("^[%-%*]%s") and not lines[j]:match("^<!%-%- /TOC %-%->$") then
                      last_list_item = j - 1
                      break
                    end
                  end
                  vim.api.nvim_buf_set_lines(bufnr, last_list_item + 1, last_list_item + 1, false, { "<!-- /TOC -->" })
                  break
                end
              end
            end

            -- Move cursor below # TOC and generate TOC
            vim.api.nvim_win_set_cursor(0, { toc_start + 1, 0 })
            vim.cmd("GenTocGFM")
          end

          -- Function to safely update TOC
          local function safe_update_toc()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local toc_start = nil
            local toc_end = nil

            -- Find TOC markers
            for i, line in ipairs(lines) do
              if line:match("^<!%-%- TOC %-%->$") then
                toc_start = i
              end
              if line:match("^<!%-%- /TOC %-%->$") then
                toc_end = i
              end
            end

            -- If both markers exist, update TOC
            if toc_start and toc_end then
              vim.cmd("UpdateToc")
            else
              -- If markers are missing, regenerate TOC
              vim.notify("TOC markers missing or incomplete. Regenerating TOC...", vim.log.levels.WARN)
              init_or_repair_toc()
            end
          end

          -- Keybindings
          vim.keymap.set("n", "<leader>tg", function()
            init_or_repair_toc()
          end, { buffer = true, desc = "Generate/Repair TOC under # TOC" })
          vim.keymap.set("n", "<leader>tu", function()
            safe_update_toc()
          end, { buffer = true, desc = "Safely Update TOC" })
          vim.keymap.set("n", "<leader>tr", ":RemoveToc<CR>", { buffer = true, desc = "Remove TOC" })
        end,
      })
    end,
  },
}
