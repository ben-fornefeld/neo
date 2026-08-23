return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map(']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Next git change')
        map('[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Previous git change')
        map('<leader>hp', gitsigns.preview_hunk, 'Preview git hunk')
        map('<leader>hd', gitsigns.diffthis, 'Diff against index')
        map('<leader>hD', function()
          gitsigns.diffthis '@'
        end, 'Diff against last commit')
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
    opts = {
      enhanced_diff_hl = true,
    },
  },
  {
    'APZelos/blamer.nvim',
    cmd = { 'BlamerToggle', 'BlamerShow', 'BlamerHide' },
    keys = {
      { '<leader>gb', '<cmd>BlamerToggle<cr>', desc = '[G]it [B]lame (toggle inline)' },
    },
    init = function()
      vim.g.blamer_enabled = 0
    end,
  },
}
