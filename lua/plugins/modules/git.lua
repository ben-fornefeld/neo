return {
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
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "APZelos/blamer.nvim",
    event = "VimEnter",
    init = function()
      vim.g.blamer_enabled = true
    end,
  },
}
