return {
  { 'folke/todo-comments.nvim', event = 'VimEnter',  dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
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
          separator_style = vim.g.transparent_enabled == true and 'thin' or 'slant',
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
        },
        exclude_groups = {
          'AvanteNormal',
          'AvanteEndOfBuffer',
          'AvanteStatusline',
          'AvanteStatuslineNC',
          'AvanteTabline',
          'AvanteTablineFill',
          'AvanteTablineSel',
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
        on_clear = function()
          require('transparent').clear_prefix('BufferLine')
          require('transparent').clear_prefix('NeoTree')
        end
      }
    end,
  },
  {
    'tamton-aquib/staline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'staline'.setup {
        sections = {
          left  = {
            ' ', 'right_sep', '-mode', 'left_sep', ' ',
            'right_sep', '-file_name', 'left_sep', ' ',
            'right_sep', '-branch', 'left_sep', ' ',
          },
          mid   = { 'lsp' },
          right = {
            'right_sep', '-cool_symbol', 'left_sep', ' ',
            'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
            'right_sep', '-line_column', 'left_sep', ' ',
          }
        },

        defaults = {
          fg = "#986fec",
          cool_symbol = "",
          left_separator = "",
          right_separator = "",
          -- line_column = "%l:%c [%L]",
          true_colors = true,
          line_column = "[%l:%c] 並%p%% ",
        },
        mode_icons = {
          n  = "₪",
          i  = "☥",
          ic = "☿",
          c  = "Ω",
          v  = "ℵ" -- etc
        },
        mode_colors = {
          n  = "#181a23",
          i  = "#181a23",
          ic = "#181a23",
          c  = "#181a23",
        }
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        cmdline = {
          view = "cmdline",
        },
        views = {
          cmdline_popup = {
            border = {
              style = "none",
              padding = { 1, 2 },
            },
            filter_options = {},
            win_options = {
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
          },
        },
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        fps = 120,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2, -- Show only warnings and errors
        minimum_width = 50,
        max_width = 150,
        time_formats = {
          ["*short"] = "[%H:%M]",
          ["*long"] = "[%Y-%m-%d %H:%M]",
          ["*full"] = "[%Y-%m-%d %H:%M:%S]",
        },
        max_height = 20,
        on_open = function() end,
        on_close = function() end,
        stages = "fade",
        render = "compact",
        timeout = 3000,
        top_down = true,
        filter = function(notification)
          -- Exclude "Message" level notifications
          return notification.level ~= vim.log.levels.MESSAGE
        end
      })
    end
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
  { 'catppuccin/nvim',          name = 'catppuccin', priority = 1000 },

  -- Ayu theme
  { 'Shatur/neovim-ayu',        priority = 1000 },

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

  {
    "0xstepit/flow.nvim",
    name = "flow",
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

  -- Dracula theme
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
  },

  -- Nordic theme
  {
    'AlexvZyl/nordic.nvim',
    priority = 1000,
    config = function()
      require('nordic').load()
    end
  },

  -- Melange theme
  {
    'savq/melange-nvim',
    priority = 1000,
  },

  -- Solarized Osaka theme
  {
    'craftzdog/solarized-osaka.nvim',
    priority = 1000,
    opts = {},
  },

  -- Nord theme
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
  },

  -- Oxocarbon theme
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
  },

  -- OneDarkPro theme
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
  },

  -- Gruvbox theme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup()
    end
  },
  {
    "slugbyte/lackluster.nvim",
    priority = 1000,
  },
  {
    'vague2k/vague.nvim',
    priority = 1000,
  },
  {
    "Zeioth/neon.nvim",
    priority = 1000,
  },
  {
    'sainnhe/sonokai',
    priority = 1000,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    priority = 1000,
  }
}
