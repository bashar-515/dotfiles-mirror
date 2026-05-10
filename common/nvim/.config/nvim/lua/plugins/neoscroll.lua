vim.pack.add { gh "karb94/neoscroll.nvim" }

local neoscroll = require"neoscroll"

neoscroll.setup {
  mappings = {},

  respect_scrolloff = false,
  stop_eof = false,
  cursor_scrolls_alone = false,

  pre_hook  = function() vim.wo.scrolloff = 0 end,
  post_hook = function() vim.wo.scrolloff = 10 end,
}

local map = vim.keymap.set

local modes = { "n", "v", "x" }

map(modes, "<C-p>", function() neoscroll.scroll(-0.25, { move_cursor=true; duration = 250 }) end)
map(modes, "<C-n>", function() neoscroll.scroll(0.25, { move_cursor=true; duration = 250 }) end)
