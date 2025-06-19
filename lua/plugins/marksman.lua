return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          filetypes = { "markdown" },
          settings = {
            marksman = {
              diagnostics = {
                enabled = true,
                ambiguousLinks = false,  -- disable ambiguous link warnings
              },
              hover = false,
            },
          },
        },
      },
    },
  },
}

