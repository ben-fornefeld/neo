local ok, err = xpcall(function()
  assert(vim.fn.executable 'mmdc' == 1, 'install mermaid-cli before running this test')
  local terminal = Snacks.image.terminal
  -- Emulate terminal capabilities; conversion and image placements use the real implementations.
  terminal._terminal = { terminal = 'ghostty', version = 'test' }
  terminal._env = { supported = true, placeholders = true }
  local requests = {}
  terminal.write = function(data)
    requests[#requests + 1] = data
  end

  local placements = {}
  local new = Snacks.image.placement.new
  Snacks.image.placement.new = function(...)
    local image = new(...)
    placements[#placements + 1] = image
    return image
  end

  local lines = { '# Mermaid preview', '', '```mermaid', 'flowchart LR', '  A[Start] --> B[Finish]', '```' }
  local function open_markdown()
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_name(buf, vim.fn.tempname() .. '.md')
    vim.api.nvim_set_current_buf(buf)
    vim.cmd 'filetype detect'
    return buf
  end
  local function wait_for(check, message)
    assert(vim.wait(20000, check), message)
  end
  local function ready_image()
    local image = placements[#placements]
    if not image or image.closed or not image.img:ready() then
      return false
    end
    local marks = vim.api.nvim_buf_get_extmarks(image.buf, Snacks.image.placement.ns, 0, -1, { details = true })
    return vim.inspect(marks):find(vim.fn.nr2char(0x10EEEE), 1, true) ~= nil
  end

  local buf = open_markdown()
  wait_for(ready_image, 'Mermaid diagram should convert to an inline image')
  local first = placements[#placements]
  assert(first.opts.inline and first.opts.conceal)
  assert(first.img.info.size.width > 0 and first.img.info.size.height > 0)
  assert(first.img.info.dpi.width == 288 and first.img.info.dpi.height == 288, '3x rendering must retain its logical size')
  local size = first:state().loc
  local cell = terminal.size()
  assert(size.width * cell.cell_width <= first.img.info.size.width, 'diagram text should not be upscaled')
  assert(first.img.file:find(require('custom.mermaid').cache(), 1, true) == 1, 'theme changes must bypass stale images')
  assert(#requests > 0, 'image should send graphics protocol requests')
  local file = assert(io.open(first.img.file, 'rb'))
  assert(file:read(8) == '\137PNG\r\n\26\n', 'Mermaid output should be a PNG')
  file:close()

  vim.cmd 'RenderMarkdown toggle'
  wait_for(function()
    return first.closed
  end, 'source view should remove the diagram')
  lines[5] = '  A[Start] --> B[Changed]'
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.cmd 'RenderMarkdown toggle'
  wait_for(ready_image, 'preview should render the edited diagram')
  local edited = placements[#placements]
  assert(edited.img.src ~= first.img.src, 'editing should produce a new diagram')
  assert(vim.deep_equal(lines, vim.api.nvim_buf_get_lines(buf, 0, -1, false)), 'rendering must not change source text')

  vim.cmd 'RenderMarkdown buf_toggle'
  wait_for(function()
    return edited.closed
  end, 'per-buffer source toggle should remove the diagram')
  assert(require('render-markdown').get(), 'per-buffer toggle must not change the global default')
  local second = open_markdown()
  wait_for(ready_image, 'new buffers should still render diagrams')
  local second_image = placements[#placements]
  vim.api.nvim_buf_delete(second, { force = true })
  assert(second_image.closed, 'deleting a buffer should release its diagram')

  local background = vim.o.background
  vim.o.background = 'light'
  lines = { '# Sequence preview', '', '```mermaid', 'sequenceDiagram', '  Reader->>Editor: Preview Markdown', '```' }
  local light = open_markdown()
  wait_for(ready_image, 'sequence diagrams should render with the light theme')
  assert(placements[#placements].img.file:find '%.light%.png$', 'light and dark themes must not share images')
  local args = require('custom.mermaid').args()
  assert(args[8] == 'redux', 'light mode should use the light Redux theme')
  vim.api.nvim_buf_delete(light, { force = true })
  vim.o.background = background

  local mermaid = require 'custom.mermaid'
  local detect = terminal.detect
  local pending
  terminal.detect = function(cb)
    pending = cb
  end
  mermaid.render { buf = buf }
  mermaid.clear { buf = buf }
  terminal.detect = detect
  local count = #placements
  pending()
  assert(#placements == count, 'a late terminal callback must not restore a cleared diagram')
  terminal._env.supported = false
  mermaid.render { buf = buf }
  assert(#placements == count, 'unsupported terminals should retain source text without image placements')
  print 'Mermaid conversion, inline placement, editing, toggles, cleanup, and stale callbacks: OK'
end, debug.traceback)

if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd 'cquit 1'
end
vim.cmd 'qa!'
