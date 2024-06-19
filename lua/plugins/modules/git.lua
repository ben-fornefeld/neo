return {
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
