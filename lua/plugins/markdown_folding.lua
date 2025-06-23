local M = {}

-- Fold expression for markdown
function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)
  local heading = line:match("^(#+)%s")
  if heading then
    local level = #heading
    if level == 1 then
      if lnum == 1 then
        return ">1"
      else
        local frontmatter_end = vim.b.frontmatter_end
        if frontmatter_end and (lnum == frontmatter_end + 1) then
          return ">1"
        end
      end
    elseif level >= 2 and level <= 6 then
      return ">" .. level
    end
  end
  return "="
end

-- Setup folding
function M.setup_markdown_folding()
  vim.opt_local.foldmethod = "expr"
  vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
  vim.opt_local.foldlevel = 99

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_first = false
  local frontmatter_end = nil
  for i, line in ipairs(lines) do
    if line == "---" then
      if not found_first then
        found_first = true
      else
        frontmatter_end = i
        break
      end
    end
  end
  vim.b.frontmatter_end = frontmatter_end
end

-- Fold headings of a certain level
local function fold_headings_of_level(level)
  vim.cmd("keepjumps normal! gg")
  local total_lines = vim.fn.line("$")
  for line = 1, total_lines do
    local line_content = vim.fn.getline(line)
    if line_content:match("^" .. string.rep("#", level) .. "%s") then
      vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
      local current_foldlevel = vim.fn.foldlevel(line)
      if current_foldlevel > 0 and vim.fn.foldclosed(line) == -1 then
        vim.cmd("normal! za")
      end
    end
  end
end

-- Fold all levels provided
function M.fold_markdown_headings(levels)
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd("nohlsearch")
  vim.fn.winrestview(saved_view)
end

-- Auto-setup for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = M.setup_markdown_folding,
})

-- Keymaps
vim.keymap.set("n", "zj", function()
  vim.cmd("silent update | edit! | normal! zR")
  M.fold_markdown_headings({6, 5, 4, 3, 2, 1})
  vim.cmd("normal! zz")
end, { desc = "Fold headings level 1+" })

vim.keymap.set("n", "zk", function()
  vim.cmd("silent update | edit! | normal! zR")
  M.fold_markdown_headings({6, 5, 4, 3, 2})
  vim.cmd("normal! zz")
end, { desc = "Fold headings level 2+" })

vim.keymap.set("n", "zl", function()
  vim.cmd("silent update | edit! | normal! zR")
  M.fold_markdown_headings({6, 5, 4, 3})
  vim.cmd("normal! zz")
end, { desc = "Fold headings level 3+" })

vim.keymap.set("n", "z;", function()
  vim.cmd("silent update | edit! | normal! zR")
  M.fold_markdown_headings({6, 5, 4})
  vim.cmd("normal! zz")
end, { desc = "Fold headings level 4+" })

vim.keymap.set("n", "zu", function()
  vim.cmd("silent update | edit! | normal! zR")
  vim.cmd("normal! zz")
end, { desc = "Unfold all headings" })

vim.keymap.set("n", "<CR>", function()
  local line = vim.fn.line(".")
  local foldlevel = vim.fn.foldlevel(line)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.cmd("normal! za")
    vim.cmd("normal! zz")
  end
end, { desc = "Toggle fold" })

vim.keymap.set("n", "zi", function()
  vim.cmd("silent update")
  vim.cmd("normal gk")
  vim.cmd("normal! za")
  vim.cmd("normal! zz")
end, { desc = "Fold heading above" })

return {}

