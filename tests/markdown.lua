local ok, err = xpcall(function()
  local lines = { '# Preview test', '', '**Bold** and [a link](https://example.com)', '', '- [x] Done' }
  local function open_markdown()
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_name(buf, vim.fn.tempname() .. '.md')
    vim.api.nvim_set_current_buf(buf)
    vim.cmd 'filetype detect'
    assert(vim.bo[buf].filetype == 'markdown')
    return buf
  end

  local first = open_markdown()
  local renderer = require 'render-markdown'
  local ns = vim.api.nvim_get_namespaces()['render-markdown.nvim']
  local function rendered(buf)
    return #vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {}) > 0
  end

  assert(renderer.get(), 'preview should be the default')
  assert(
    vim.wait(3000, function()
      return rendered(first)
    end),
    'Markdown should render automatically'
  )
  assert(vim.wo.conceallevel == 3)
  assert(vim.wo.concealcursor == 'nvic')

  vim.cmd 'RenderMarkdown toggle'
  assert(not renderer.get(), 'toggle should switch the default to source')
  assert(
    vim.wait(3000, function()
      return not rendered(first)
    end),
    'source view should clear preview decorations'
  )
  assert(vim.wo.conceallevel == 0)
  local second = open_markdown()
  assert(not rendered(second), 'new Markdown buffers should follow the source default')

  vim.cmd 'RenderMarkdown toggle'
  assert(renderer.get(), 'toggle should restore the preview default')
  assert(
    vim.wait(3000, function()
      return rendered(second)
    end),
    'toggle should render the current buffer'
  )
  local third = open_markdown()
  assert(
    vim.wait(3000, function()
      return rendered(third)
    end),
    'new Markdown buffers should follow the preview default'
  )
  for _, buf in ipairs { first, second, third } do
    assert(vim.deep_equal(lines, vim.api.nvim_buf_get_lines(buf, 0, -1, false)), 'preview must not change source text')
  end
  print 'Markdown defaults, toggle, rendering, and unchanged source: OK'
end, debug.traceback)

if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd 'cquit 1'
end
vim.cmd 'qa!'
