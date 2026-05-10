vim.pack.add {
  -- deps.
  gh "munifTanjim/nui.nvim",
  gh "rcarriga/nvim-notify", -- optional

  gh "folke/noice.nvim",
}

require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },

  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})
