-- Herdr integration: both plugins only activate inside a herdr pane
-- (herdr exports HERDR_ENV=1). Outside herdr, your plain <C-h/j/k/l>
-- window maps from custom.mappings keep working.
return {
  { -- Seamless nvim <-> herdr navigation & resizing (smart-splits style)
    'lmilojevicc/herdr-splits.nvim',
    cond = vim.env.HERDR_ENV == '1',
    event = 'VeryLazy',
    config = function()
      require('herdr-splits').setup {
        at_edge = 'wrap',
        nav_keys = { left = '<C-h>', down = '<C-j>', up = '<C-k>', right = '<C-l>' },
        resize_keys = { left = '<M-h>', down = '<M-j>', up = '<M-k>', right = '<M-l>' },
        unzoom_on_nav = true,
        ignored_filetypes = {
          'NvimTree',
          'neo-tree',
          'snacks_dashboard',
          'snacks_explorer',
          'snacks_picker',
          'aerial',
          'Outline',
          'Trouble',
          'quickfix',
        },
      }
    end,
    keys = {
      { '<C-h>', function() require('herdr-splits').move_cursor_left() end, desc = 'Navigate left (herdr-aware)' },
      { '<C-j>', function() require('herdr-splits').move_cursor_down() end, desc = 'Navigate down (herdr-aware)' },
      { '<C-k>', function() require('herdr-splits').move_cursor_up() end, desc = 'Navigate up (herdr-aware)' },
      { '<C-l>', function() require('herdr-splits').move_cursor_right() end, desc = 'Navigate right (herdr-aware)' },
      { '<M-h>', function() require('herdr-splits').resize_left() end, desc = 'Resize left' },
      { '<M-j>', function() require('herdr-splits').resize_down() end, desc = 'Resize down' },
      { '<M-k>', function() require('herdr-splits').resize_up() end, desc = 'Resize up' },
      { '<M-l>', function() require('herdr-splits').resize_right() end, desc = 'Resize right' },
    },
  },

  { -- Stage code context from nvim into a live herdr agent's prompt
    'makyinmars/herdr-context.nvim',
    cond = vim.env.HERDR_ENV == '1',
    lazy = false, -- keeps :checkhealth herdr-context discoverable
    opts = {
      submit = false, -- stage only; you review the prompt before sending
      target_scope = 'workspace',
      remember_target = 'session',
    },
    keys = {
      { '<leader>ac', function() require('herdr-context').compose() end, mode = { 'n', 'v' }, desc = '[A]gent: [c]ompose context bundle' },
      { '<leader>ay', function() require('herdr-context').reference() end, mode = { 'n', 'v' }, desc = '[A]gent: stage reference (@file#L1-L9)' },
      { '<leader>aY', function() require('herdr-context').send() end, mode = { 'n', 'v' }, desc = '[A]gent: stage reference + code' },
      { '<leader>ad', function() require('herdr-context').diagnostics() end, mode = { 'n', 'v' }, desc = '[A]gent: stage [d]iagnostics' },
      { '<leader>ah', '<Cmd>HerdrContextHunk<CR>', desc = '[A]gent: stage git [h]unk' },
      { '<leader>at', function() require('herdr-context').select_target() end, desc = '[A]gent: pick [t]arget agent' },
      { '<leader>aa', function() require('herdr-context').agents() end, desc = '[A]gent: toggle [a]gent drawer' },
      { '<leader>ar', function() require('herdr-context').refresh() end, desc = '[A]gent: [r]efresh agents' },
    },
  },
}
