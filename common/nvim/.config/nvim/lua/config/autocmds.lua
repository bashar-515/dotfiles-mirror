vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "html",
    "css",
    "json",
  },

  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})
