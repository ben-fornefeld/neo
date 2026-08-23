return {
  {
    'leap.nvim',
    url = 'https://codeberg.org/andyg/leap.nvim',
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap)')
      vim.keymap.set('n', 'F', '<Plug>(leap-from-window)')
      -- require('leap').create_default_mappings()
    end,
  },
  {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    event = 'VeryLazy',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<C-x>',
          clear_suggestion = '<C-e>',
          accept_word = '<C-f>',
        },
        ignore_filetypes = {}, -- or { "cpp", }
        color = {
          -- suggestion_color = "#ffffff",
          cterm = 244,
        },
        log_level = 'off',                 -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control
        condition = function()
          return false
        end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      }
    end,
  },
}
