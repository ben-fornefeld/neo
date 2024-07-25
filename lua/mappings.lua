require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- leap
map({ "n", "x", "o" }, "f", "<Plug>(leap-forward)")
map({ "n", "x", "o" }, "F", "<Plug>(leap-backward)")

-- copilot
map("i", "<C-x>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot: Accept" })

-- file tree
--[[ nomap("n", "<C-n>") ]]
map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")

-- telescope

local builtin = require "telescope.builtin"

map("n", "<leader>fg", function()
  builtin.git_status()
end, { desc = "Telescope git status" })

-- diagnostics
map("n", "<leader>e", function()
  vim.diagnostic.open_float()
end)
