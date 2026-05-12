vim.pack.add {
  -- deps.
  gh "nvim-tree/nvim-web-devicons",

  gh "nvim-lualine/lualine.nvim",
}

require"lualine".setup {
  options = {
    globalstatus = true,
    icons_enabled = false,
    section_separators = "",
    component_separators = "",
  },

  sections = {
    lualine_c = {
      { "filename", path = 1 },
    },
    lualine_x = { "filetype" },
  },
}
