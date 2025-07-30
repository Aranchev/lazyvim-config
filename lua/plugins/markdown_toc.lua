-- lua/plugins/markdown_toc.lua

local function update_markdown_toc()
  local path = vim.fn.expand("%") -- Expands the current file name to a full path
  local bufnr = 0 -- The current buffer number, 0 references the current active buffer
  -- Save the current view
  vim.cmd("mkview")
  -- Retrieves all lines from the current buffer
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local frontmatter_end = 0 -- To store the end line number of frontmatter
  local toc_start = -1 -- Line number of <!-- toc -->
  local toc_stop = -1 -- Line number of <!-- tocstop --> (if present)
  local existing_toc_h1 = -1 -- Line number of existing # TOC heading

  -- Check for frontmatter, TOC markers, and existing # TOC heading
  for i, line in ipairs(lines) do
    if i == 1 and line:match("^---$") then
      -- Frontmatter start detected, find the end
      for j = i + 1, #lines do
        if lines[j]:match("^---$") then
          frontmatter_end = j
          break
        end
      end
    end
    -- Check for TOC start
    if line:match("^%s*<!%-%-%s*toc%s*%-%->%s*$") then
      toc_start = i
    end
    -- Check for TOC stop
    if line:match("^%s*<!%-%-%s*tocstop%s*%-%->%s*$") then
      toc_stop = i
    end
    -- Check for existing # TOC heading
    if line:match("^#%s*TOC%s*$") then
      existing_toc_h1 = i
    end
  end

  -- Remove existing TOC (<!-- toc --> to <!-- tocstop --> or next non-TOC content)
  if toc_start > -1 then
    local toc_end = toc_stop > toc_start and toc_stop or toc_start
    -- Find the end of the TOC content (next non-empty, non-TOC line after toc_start)
    for i = toc_start + 1, #lines do
      if i ~= toc_stop and not lines[i]:match("^%s*%-.*%[.*%]%[.*%]") and not lines[i]:match("^%s*$") then
        toc_end = i - 1
        break
      end
    end
    -- Extend deletion to include existing # TOC heading if it exists and is just before toc_start
    if existing_toc_h1 > -1 and existing_toc_h1 == toc_start - 1 then
      toc_start = existing_toc_h1
    end
    vim.api.nvim_buf_set_lines(bufnr, toc_start - 1, toc_end + 1, false, {})
  elseif existing_toc_h1 > -1 then
    -- Remove standalone # TOC heading if it exists without a TOC
    vim.api.nvim_buf_set_lines(bufnr, existing_toc_h1 - 1, existing_toc_h1, false, {})
  end

  -- Insert new TOC with # TOC heading after frontmatter or at the top
  local insertion_line = frontmatter_end > 0 and frontmatter_end + 1 or 1
  vim.api.nvim_buf_set_lines(bufnr, insertion_line - 1, insertion_line - 1, false, { "# TOC", "<!-- toc -->" })

  -- Silently save the file
  vim.cmd("silent write")
  -- Run markdown-toc with bullet option, escaping path for Windows
  local result = vim.fn.system('markdown-toc --bullets "-" -i ' .. vim.fn.shellescape(path))
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to run markdown-toc: " .. result, vim.log.levels.ERROR)
    vim.cmd("loadview")
    return
  end
  vim.cmd("edit!") -- Reloads the file to reflect changes
  vim.cmd("silent write") -- Silently save the file
  vim.notify("TOC updated and file saved", vim.log.levels.INFO)
  -- Restore the saved view (including folds)
  vim.cmd("loadview")
end

return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown", -- Load only for markdown files
    config = function()
      require("mkdnflow").setup({})
    end,
    keys = {
      {
        "<leader>mtt",
        function()
          update_markdown_toc()
        end,
        desc = "[P]Insert/update Markdown TOC",
        ft = "markdown",
      },
    },
  },
}
