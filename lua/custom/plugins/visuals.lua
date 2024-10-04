return {
  {
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
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
        NvimTree = true,
        -- Or, specify the text used for the offset:
        undotree = {
          text = 'undotree',
          align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
        },
        -- Or, specify the event which the sidebar executes when leaving:
        ['neo-tree'] = { event = 'BufWipeout' },
        -- Or, specify all three
        Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
      },
    },
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
          'BufferVisible',
          'BufferInactive',
          'BufferTabpages',
          'BufferTabpageFill',
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
    lazy = false,
    priority = 1000,
    config = function()
      require('themery').setup {
        themes = vim.fn.getcompletion('', 'color'),
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
}
