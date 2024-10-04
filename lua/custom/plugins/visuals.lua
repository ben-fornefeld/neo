return {
  --[[ {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      icons = {
        buffer_index = false,
        buffer_number = false,
        button = '',
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = '' },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
        filetype = {
          custom_colors = false,
          enabled = true,
        },
        separator = { left = '▎', right = '' },
        modified = { button = '●' },
        pinned = { button = '車', filename = true, separator = { right = '' } },
        alternate = { filetype = { enabled = false } },
        current = { buffer_index = false },
        inactive = { button = '×' },
        visible = { modified = { buffer_number = false } },
      },
      sidebar_filetypes = {
        NvimTree = true,
        undotree = { text = 'undotree' },
        ['neo-tree'] = { event = 'BufWipeout' },
        Outline = { event = 'BufWinLeave', text = 'symbols-outline' },
      },
      minimum_padding = 0,
      maximum_padding = 0,
      maximum_length = 30,
    },
  }, ]]
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.opt.termguicolors = true

      local plug = require 'bufferline'

      plug.setup {
        options = {
          diagnostics = 'nvim_lsp',
          indicator = {
            icon = '鬼',
            style = 'icon',
          },
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Neo Tree',
              highlight = 'Directory',
              separator = {
                left = '',
                right = '',
              },
            },
          },
          show_tab_indicators = true,
          show_buffer_close_icons = false,
          separator_style = 'slant',
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
          },
        },
      }
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = function()
      require('transparent').setup {
        extra_groups = {
          'NeoTreeNormal',
          'NeoTreeNormalNC',
          'NeoTreeVertSplit',
          'NeoTreeCursorLine',
          'NeoTreeDimText',
          'NeoTreeDirectoryIcon',
          'NeoTreeDirectoryName',
          'NeoTreeDotfile',
          'NeoTreeFileIcon',
          'NeoTreeFileName',
          'NeoTreeFileNameOpened',
          'NeoTreeFilterTerm',
          'NeoTreeGitAdded',
          'NeoTreeGitConflict',
          'NeoTreeGitDeleted',
          'NeoTreeGitIgnored',
          'NeoTreeGitModified',
          'NeoTreeGitUnstaged',
          'NeoTreeGitUntracked',
          'NeoTreeGitStaged',
          'NeoTreeHiddenByName',
          'NeoTreeIndentMarker',
          'NeoTreeExpander',
          'NeoTreeSignColumn',
          'NeoTreeStats',
          'NeoTreeStatsHeader',
          'NeoTreeStatusLine',
          'NeoTreeStatusLineNC',
          'NeoTreeEndOfBuffer',
          'NeoTreeRootName',
          'NeoTreeSymbolicLinkTarget',
          'NeoTreeWindowsHidden',
        },
        exclude_groups = {
          'AvanteNormal',
          'AvanteEndOfBuffer',
          'AvanteStatusline',
          'AvanteStatuslineNC',
          'AvanteTabline',
          'AvanteTablineFill',
          'AvanteTablineSel',
          'NeoTreeFloatBorder',
          'NeoTreeFloatTitle',
          'NeoTreeTitleBar',
          'NeoTreeWinSeparator',
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
        },
        livePreview = true,
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      --  vim.cmd.hi 'Comment gui=none'
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- Ayu theme
  { 'Shatur/neovim-ayu', priority = 1000 },

  -- Rose Pine (pastel theme)
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
  },

  -- Kanagawa (pastel theme)
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },

  -- Everforest theme
  {
    'sainnhe/everforest',
    priority = 1000,
  },

  -- Cyberdream theme
  {
    'scottmckendry/cyberdream.nvim',
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        -- Recommended settings, but can be adjusted according to preference
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = {
            { 'filename', separator = { right = '' }, right_padding = 2 },
            { 'branch', separator = { right = '' }, right_padding = 2 },
          },
          lualine_c = {
            { 'fileformat', separator = { right = '' }, right_padding = 2 },
          },
          lualine_x = {
            { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ' } },
          },
          lualine_y = {
            { 'filetype', separator = { left = '' }, left_padding = 2 },
            { 'progress', separator = { left = '' }, left_padding = 2 },
          },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
}
