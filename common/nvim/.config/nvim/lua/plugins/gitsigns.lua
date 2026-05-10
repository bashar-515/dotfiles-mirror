vim.pack.add { gh "lewis6991/gitsigns.nvim" }

local map = vim.keymap.set

map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>")
map("n", "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>")
