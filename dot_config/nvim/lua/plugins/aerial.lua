vim.pack.add { gh "stevearc/aerial.nvim" }

local aerial = require "aerial"

aerial.setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})

local map = vim.keymap.set

map("n", "<leader>a", "<cmd>AerialToggle<CR>")
map("n", "<leader>af", function() aerial.fzf_lua_picker() end)

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.filetype == "aerial" then
      aerial.close()
    end
  end,
})
