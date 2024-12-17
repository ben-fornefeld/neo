return {
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        diagnostics = {
          relative = "win",
          size = 0.4,
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.5,
          },
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>x',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      --[[
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
     },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      }, ]]
    },
  },
  {
    'laytan/tailwind-sorter.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm ci && npm run build',
    config = true,
  },
  {
    'elixir-editors/vim-elixir',
    ft = { 'elixir', 'eelixir', 'heex', 'surface' },
    event = 'VeryLazy',
  },
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'html',
      'dart',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        -- defaults
        'vim',
        'lua',
        'vimdoc',

        -- web dev
        'html',
        'css',
        'javascript',
        'typescript',
        'tsx',
        'markdown',
        'dart',
        'elixir',
        'templ',
        'python',
        "ruby",
        "erb",

        -- low level
        'go',
        'glsl',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
    },
  },
}
