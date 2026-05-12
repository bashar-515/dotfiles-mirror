local map = vim.keymap.set

map("i", "jk", "<Esc>")

map("n", "<leader>nh", "<cmd>nohl<CR>")

map("n", "<leader>sv", "<C-w>v")
map("n", "<leader>sh", "<C-w>s")
map("n", "<leader>se", "<C-w>=")
map("n", "<leader>sx", "<cmd>close<CR>")

map("n", "<leader>to", "<cmd>tabnew<CR>")
map("n", "<leader>tx", "<cmd>tabclose<CR>")
map("n", "<leader>tn", "<cmd>tabn<CR>")
map("n", "<leader>tp", "<cmd>tabp<CR>")
map("n", "<leader>tf", "<cmd>tabnew %<CR>")
map("n", "<leader>ts", "<cmd>tab split<CR>")

map("n", "U", "<C-r>")

map({"n", "x", "o"}, "mm", "%", { remap = true })
