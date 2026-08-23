require 'custom.options'

vim.o.guifont = 'Berkeley Mono:h13:e-subpixelantialias:h-none'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      icons = {
        keys = {
          Space = '<leader> ',
        },
      },
      spec = {
        { '<leader>a', group = 'agent (herdr)' },
        { '<leader>b', group = 'buffer' },
        { '<leader>c', group = 'code' },
        { '<leader>d', group = 'document/diagnostics' },
        { '<leader>f', group = 'find' },
        { '<leader>g', group = 'git' },
        { '<leader>h', group = 'git hunk' },
        { '<leader>n', group = 'explorer' },
        { '<leader>r', group = 'rename/refactor' },
        { '<leader>s', group = 'search/symbols' },
        { '<leader>t', group = 'toggle/terminal' },
        { '<leader>u', group = 'ui' },
        { '<leader>w', group = 'workspace' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Keymaps (which-key)',
      },
      {
        '<C-w><space>',
        function()
          require('which-key').show { keys = '<C-w>', loop = true }
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
    config = function(_, opts)
      require('which-key').setup(opts)
    end,
  },

  --[[ { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  }, ]]

  require 'kickstart.plugins.autopairs',

  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Themery saves the chosen theme under stdpath('data'), but the plugin is
-- loaded on VimEnter.  At that point Themery can try to restore a lazy
-- colorscheme before lazy.nvim's colorscheme loader is ready, fail, and fall
-- back to the first configured theme.  Restore the saved colorscheme once lazy
-- has registered all plugin specs so the selection survives restarts.
local function apply_themery_state()
  local state_file = vim.fn.stdpath 'data' .. '/themery/state.json'
  if vim.fn.filereadable(state_file) == 0 then
    return
  end

  local ok, state = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(state_file), '\n'))
  end)
  if not ok or type(state) ~= 'table' or not state.colorscheme then
    return
  end

  local function run_lua(code)
    if not code or code == '' then
      return true
    end
    local chunk = load(code)
    if not chunk then
      return false
    end
    local ran = pcall(chunk)
    return ran
  end

  run_lua(state.globalBeforeCode)
  run_lua(state.beforeCode)
  local applied = pcall(vim.cmd.colorscheme, state.colorscheme)
  if applied then
    run_lua(state.afterCode)
    run_lua(state.globalAfterCode)
  end
end

apply_themery_state()

vim.opt.cmdheight = 1

require 'custom.mappings'
