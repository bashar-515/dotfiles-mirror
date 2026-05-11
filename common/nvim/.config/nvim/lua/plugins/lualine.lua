vim.pack.add {
  -- deps.
  gh "nvim-tree/nvim-web-devicons",

  gh "nvim-lualine/lualine.nvim",
}

require"lualine".setup {
  options = { globalstatus = true },

  sections = {
    lualine_c = {
      { "filename", path = 1 },
    },
  },
}
