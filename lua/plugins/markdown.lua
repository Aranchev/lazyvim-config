return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
      require("render-markdown").setup({
        render_modes = { "i", "n" },
        heading = {
          enabled = true,
          border = false,
          border_virtual = false,
        },
        code = {
          enabled = true,
          border = "none", -- Disable delimiters entirely
          sign = false,
          width = "block",
          right_pad = 1,
          left_pad = 1,
        },
      })

      -- Clear existing highlights to avoid conflicts
      vim.cmd [[
        highlight clear RenderMarkdownCode
        highlight clear RenderMarkdownCodeInline
        highlight clear @markup.raw.block.python
        highlight clear RenderMarkdownCodeBorder
        highlight clear markdownCodeDelimiter
        highlight clear RenderMarkdownCodeLanguage
      ]]

      -- Set black background
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#080808", fg = nil })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#080808", fg = nil })
      vim.api.nvim_set_hl(0, "@markup.raw.block.python", { bg = "#080808", fg = nil })

      -- Existing heading highlights
      vim.cmd [[
        highlight RenderMarkdownH6Bg guibg=#0A000A guifg=#91cde1
        highlight RenderMarkdownH3Bg guibg=#0A000A guifg=#4b7be3
        highlight RenderMarkdownH2Bg guibg=#0A000A guifg=#930bca
        highlight RenderMarkdownH4Bg guibg=#0A000A guifg=#16a972
        highlight RenderMarkdownH1Bg guibg=#0A000A guifg=#eaa105
        highlight RenderMarkdownH5Bg guibg=#0A000A guifg=#bc2c2c
      ]]

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "v:lua.vim_markdown_foldexpr()"
          vim.diagnostic.disable(0)
        end,
      })

      function _G.vim_markdown_foldexpr()
        local line = vim.fn.getline(vim.v.lnum)
        local _, _, hashes = string.find(line, "^(#+)%s")
        if hashes then return ">" .. #hashes end
        return "="
      end
    end,
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
