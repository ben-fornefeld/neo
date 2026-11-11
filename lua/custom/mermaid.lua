local M = {}
local buffers = {}
local config = vim.fn.stdpath 'config' .. '/mermaid.json'
local light_config = vim.fn.stdpath 'config' .. '/mermaid-light.json'
local scale = 3

function M.args()
  local file = vim.o.background == 'light' and light_config or config
  return { '-i', '{src}', '-o', '{file}', '-b', 'transparent', '-c', file, '-s', tostring(scale) }
end

function M.cache()
  local contents = table.concat(vim.fn.readfile(config), '\n') .. '\n' .. table.concat(vim.fn.readfile(light_config), '\n')
  local hash = vim.fn.sha256(contents):sub(1, 12)
  return vim.fn.stdpath 'cache' .. '/snacks/mermaid-sharp-3x/' .. hash
end

local function set_density(image)
  -- mmdc omits PNG density; keep supersampling from increasing the diagram's display size.
  if image.img.info then
    image.img.info.dpi = { width = 96 * scale, height = 96 * scale }
  end
end

function M.clear(ctx)
  local state = buffers[ctx.buf]
  buffers[ctx.buf] = nil
  for _, image in pairs(state and state.images or {}) do
    image:close()
  end
end

function M.render(ctx)
  local buf = ctx.buf
  buffers[buf] = buffers[buf] or { images = {} }
  local state = buffers[buf]
  local request = {}
  state.request = request

  local function current()
    return buffers[buf] == state and state.request == request and vim.api.nvim_buf_is_valid(buf)
  end

  Snacks.image.terminal.detect(function()
    local env = Snacks.image.terminal.env()
    if not current() or not env.supported or not env.placeholders then
      return
    end
    Snacks.image.doc.find_visible(buf, function(matches)
      if not current() then
        return
      end
      local images = {}
      for _, match in ipairs(matches) do
        if match.ext == 'chart.mmd' then
          local image = state.images[match.id]
          if image and image.img.src ~= match.src then
            image:close()
            image = nil
          end
          if image then
            image.opts.pos = match.pos
            image.opts.range = match.range
            image:update()
          else
            image = Snacks.image.placement.new(buf, match.src, {
              pos = match.pos,
              range = match.range,
              inline = true,
              conceal = true,
              type = 'chart',
              max_width = 100,
              max_height = 40,
              on_update_pre = set_density,
            })
          end
          images[match.id] = image
        end
      end
      for id, image in pairs(state.images) do
        if not images[id] then
          image:close()
        end
      end
      state.images = images
    end)
  end)
end

vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
  group = vim.api.nvim_create_augroup('custom-mermaid', { clear = true }),
  callback = M.clear,
})

return M
