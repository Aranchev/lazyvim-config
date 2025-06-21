return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      render_modes = { "i", "t" },  -- Render only in Insert & Terminal modes
      heading = {
        position = "none",          -- Disable inline decoration (heading underline)
      },
      -- You can include additional desired opts here…
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      
      -- Folding & diagnostics (as before)
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
  },
}

-- https://chatgpt.com/c/6856b39b-f2e8-800e-a7f8-d77c11cd245e
