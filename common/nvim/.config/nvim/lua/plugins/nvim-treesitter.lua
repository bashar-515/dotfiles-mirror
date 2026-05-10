-- brew install tree-sitter-cli
vim.pack.add {
  {
    src = gh "nvim-treesitter/nvim-treesitter",
    version = "main",
  },
}

require"nvim-treesitter".install { "all" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
