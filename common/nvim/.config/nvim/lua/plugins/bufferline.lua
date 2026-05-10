vim.pack.add {
  -- deps.
  gh "nvim-tree/nvim-web-devicons",

  gh "akinsho/bufferline.nvim",
 }

require"bufferline".setup {
  options = { mode = "tabs" },
}
