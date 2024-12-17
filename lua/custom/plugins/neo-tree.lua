-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>n', ':Neotree toggle<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    source_selector = {
      winbar = false,
      statusline = false,
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
      window = {
        mappings = {
          -- [''] = 'close_window',
          ['<S-w>'] = 'close_all_nodes',
        },
      },
    },
  },
}
