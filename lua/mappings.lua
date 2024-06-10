require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- leap
map({ "n", "x", "o" }, "f", "<Plug>(leap-forward)")
map({ "n", "x", "o" }, "F", "<Plug>(leap-backward)")

-- file tree
nomap("n", "<C-n>")
nomap("n", "<leader>e")

map("n", "<C-n>", "<cmd>Neotree toggle<CR>")
map("n", "<leader>e", "<cmd>Neotree reveal<CR>")
