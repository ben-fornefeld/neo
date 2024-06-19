return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "ggandor/leap.nvim",
    event = "VimEnter",
    config = function() end,
  },
}
