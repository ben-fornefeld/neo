return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { "sindrets/diffview.nvim", event = "BufRead" },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup {
        disable_commit_confirmation = true,
        disable_signs = false,
        disable_context_highlighting = false,
        disable_builtin_notifications = false,
        commit_popup = {
          kind = "split",
        },
        integrations = {
          diffview = true,
        },
      }
    end,
  },
  {
    'APZelos/blamer.nvim',
    event = 'VeryLazy',
  },
}
