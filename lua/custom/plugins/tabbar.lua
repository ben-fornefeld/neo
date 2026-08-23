return {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        mode = 'buffers',
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        separator_style = 'thin',
        offsets = {
          {
            -- The Snacks explorer sidebar is a real vsplit whose container
            -- window has filetype `snacks_layout_box`. The inner picker list
            -- (`snacks_picker_list`) is a float layered on top, so it never
            -- appears in `winlayout()` and bufferline could not offset against
            -- it. Matching the split container makes the tabbar start next to
            -- the explorer instead of spanning above it. (Same as LazyVim.)
            filetype = 'snacks_layout_box',
            text = 'Explorer',
            text_align = 'left',
            separator = true,
          },
        },
      },
    },
  },
}
