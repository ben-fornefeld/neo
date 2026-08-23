return {
  { 'folke/todo-comments.nvim', event = 'VimEnter',  dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = function()
      require('transparent').setup {
        extra_groups = {
        },
        exclude_groups = {
          -- Exclude todo-comments highlight groups
          'TodoBgTODO',
          'TodoBgFIX',
          'TodoBgHACK',
          'TodoBgWARN',
          'TodoBgPERF',
          'TodoBgNOTE',
          'TodoBgTEST',
          'TodoFgTODO',
          'TodoFgFIX',
          'TodoFgHACK',
          'TodoFgWARN',
          'TodoFgPERF',
          'TodoFgNOTE',
          'TodoFgTEST',
          'TodoSignTODO',
          'TodoSignFIX',
          'TodoSignHACK',
          'TodoSignWARN',
          'TodoSignPERF',
          'TodoSignNOTE',
          'TodoSignTEST',
        },
      }
    end,
  },

  -- THEMES

  {
    'zaldih/themery.nvim',
    event = 'VimEnter',
    priority = 1000,
    config = function()
      require('themery').setup {
        themes = {
          'tokyonight',
          'tokyonight-night',
          'tokyonight-storm',
          'tokyonight-day',
          'tokyonight-moon',
          'catppuccin',
          'catppuccin-latte',
          'catppuccin-frappe',
          'catppuccin-macchiato',
          'catppuccin-mocha',
          'flow',
          'ayu',
          'ayu-dark',
          'ayu-light',
          'ayu-mirage',
          'rose-pine',
          'rose-pine-moon',
          'rose-pine-dawn',
          'kanagawa',
          'kanagawa-wave',
          'kanagawa-dragon',
          'kanagawa-lotus',
          'everforest',
          'cyberdream',
          'dracula',
          'nordic',
          'melange',
          'solarized-osaka',
          'nord',
          'oxocarbon',
          'onedark',
          'onelight',
          'onedark_vivid',
          'onedark_dark',
          'gruvbox',
          "lackluster",
          'vague',
          'neon',
          "sonokai",
          "github_dark",
          "github_light",
          "github_dimmed",
          "github_dark_default",
          "github_dark_colorblind",
          "github_dark_high_contrast",
          "github_dark_dimmed",
          "github_light_default",
          "github_light_colorblind",
          "github_light_high_contrast",
          "github_light_dimmed",
          "github_dark_tritanopia",
          "github_light_tritanopia",
        },
        livePreview = true,
      }
    end,
  },

  -- Default colorscheme: eager + high priority so it's available before other UI plugins.
  -- All other themes are lazy and only load when activated (themery or :colorscheme).
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },

  { 'catppuccin/nvim',          name = 'catppuccin', lazy = true },
  { 'Shatur/neovim-ayu',        lazy = true },
  { 'rose-pine/neovim',         name = 'rose-pine',  lazy = true },
  { 'rebelot/kanagawa.nvim',    lazy = true },
  { 'sainnhe/everforest',       lazy = true },
  { '0xstepit/flow.nvim',       name = 'flow',       lazy = true },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = true,
    config = function()
      require('cyberdream').setup {
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
      }
    end,
  },
  { 'Mofiqul/dracula.nvim', lazy = true },
  {
    'AlexvZyl/nordic.nvim',
    lazy = true,
    config = function()
      require('nordic').load()
    end,
  },
  { 'savq/melange-nvim',              lazy = true },
  { 'craftzdog/solarized-osaka.nvim', lazy = true, opts = {} },
  { 'shaunsingh/nord.nvim',           lazy = true },
  { 'nyoom-engineering/oxocarbon.nvim', lazy = true },
  { 'olimorris/onedarkpro.nvim',      lazy = true },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    config = function()
      require('gruvbox').setup()
    end,
  },
  { 'slugbyte/lackluster.nvim',  lazy = true },
  { 'vague2k/vague.nvim',        lazy = true },
  { 'Zeioth/neon.nvim',          lazy = true },
  { 'sainnhe/sonokai',           lazy = true },
  { 'projekt0n/github-nvim-theme', name = 'github-theme', lazy = true },
}
