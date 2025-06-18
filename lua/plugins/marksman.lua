return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          -- Only enable Marksman for Markdown files
          filetypes = { "markdown" },
        },
      },
    },
  },
}
