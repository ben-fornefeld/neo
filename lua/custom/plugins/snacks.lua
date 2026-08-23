local function toggle_explorer(dashboard)
  local function open()
    Snacks.explorer()
  end

  -- The dashboard is a transient nofile buffer. Opening the explorer directly
  -- from it can race Snacks' async picker setup, so close the dashboard first
  -- and open the sidebar on the next tick.
  if dashboard and dashboard.buf then
    pcall(vim.api.nvim_buf_delete, dashboard.buf, { force = true })
    vim.schedule(open)
    return
  end

  if vim.bo.filetype == 'snacks_dashboard' then
    pcall(vim.cmd, 'bdelete')
    vim.schedule(open)
    return
  end

  local ok, pickers = pcall(Snacks.picker.get, { source = 'explorer' })
  local explorer = ok and pickers[1] or nil
  if explorer then
    explorer:close()
  else
    open()
  end
end

local search_exclude = { '.git', 'node_modules', '.next', 'build', 'dist' }

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        width = 58,
        preset = {
          header = [[
          e2b

    ┌────────────────────────────┐
    │  sandbox ready             │
    │  code · tools · files      │
    └────────────────────────────┘

        ]·········[
        ]·*·······[
        ]···*·····[
        ]·········[]],
          keys = {
            { icon = ' ', key = 'e', desc = 'Explorer', action = toggle_explorer },
            { icon = ' ', key = 'f', desc = 'Find file', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'g', desc = 'Search text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'r', desc = 'Recent files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = 'header' },
          { text = { { 'AI sandboxes for agents', hl = 'footer' } }, align = 'center', padding = { 1, 0 } },
          { section = 'keys', gap = 1, padding = 1 },
          { title = 'recent', section = 'recent_files', limit = 5, cwd = true, padding = 1 },
          { section = 'startup', icon = 'λ ' },
        },
      },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = {
        enabled = true,
        ui_select = true,
        layout = {
          preset = function()
            return vim.o.columns >= 110 and 'dialog' or 'vertical'
          end,
        },
        layouts = {
          dialog = {
            preset = 'default',
            layout = {
              width = 0.92,
              min_width = 90,
              height = 0.9,
              min_height = 24,
            },
          },
        },
        win = {
          input = {
            keys = {
              ['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
              ['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
            },
          },
          list = {
            keys = {
              ['<Tab>'] = { 'list_down', mode = { 'n', 'x' } },
              ['<S-Tab>'] = { 'list_up', mode = { 'n', 'x' } },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = { preset = 'sidebar', preview = false },
          },
          files = {
            hidden = true,
            ignored = true,
            exclude = search_exclude,
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = search_exclude,
          },
          projects = {
            dev = { '~/dev', '~/Documents', '~/code' },
            patterns = { '.git', 'package.json', 'Makefile', 'go.mod', 'Cargo.toml', 'mix.exs' },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        '<leader>e',
        function()
          toggle_explorer()
        end,
        desc = 'Explorer (toggle)',
      },
      { '<leader>n', function() toggle_explorer() end, desc = 'Explorer' },

      { '<leader>fh', function() Snacks.picker.help() end, desc = '[F]ind [H]elp' },
      { '<leader>fk', function() Snacks.picker.keymaps() end, desc = '[F]ind [K]eymaps' },
      { '<leader>ff', function() Snacks.picker.files() end, desc = '[F]ind [F]iles (including hidden, excluding build folders)' },
      { '<leader>fs', function() Snacks.picker.pickers() end, desc = '[F]ind [S]elect Picker' },
      { '<leader>fw', function() Snacks.picker.grep() end, desc = '[F]ind by [G]rep' },
      { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = '[F]ind [D]iagnostics' },
      { '<leader>fr', function() Snacks.picker.resume() end, desc = '[F]ind [R]esume' },
      { '<leader>f.', function() Snacks.picker.recent() end, desc = '[F]ind Recent Files ("." for repeat)' },
      { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
      { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
      { '<leader>f/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
      { '<leader>sK', function() Snacks.picker.keymaps({ pattern = '<leader>', modes = { 'n' } }) end, desc = '[S]earch Leader [K]eymaps' },
      { '<leader>fn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files' },
      { '<leader>fg', function() Snacks.picker.git_status() end, desc = '[F]ind [G]it changes' },
      { '<leader>ft', function() Snacks.picker.todo_comments() end, desc = '[F]ind [T]odo comments' },
      { '<leader>fp', function() Snacks.picker.projects() end, desc = '[F]ind [P]roject (switch workspace)' },

      { '<leader>un', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    },
  },
}
