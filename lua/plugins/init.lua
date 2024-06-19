return {

  {
    "rmagatti/auto-session",
    priority = 1000,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_save_enabled = true,
        auto_restore_enabled = true,
      }
    end,
    event = "VimEnter",
  },

  { import = "plugins.modules" },
}
