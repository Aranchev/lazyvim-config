return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        filetype = {
          python = [[cmd /C ""C:/Users/Emi Nikolova/AppData/Local/Programs/Python/Python312/python.exe" "$file""]],
        },
        startinsert = false,
        preserve_screen = true,
      })
    end,
  },
}
