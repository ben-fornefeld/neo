return {
  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    priority = 1200,
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {},
    opts = {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        window = {
          mappings = {},
        },
      },
    },
    lazy = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  --[[ -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      vim.opt.termguicolors = true

      local plug = require "bufferline"

      plug.setup {
        options = {
          diagnostics = "nvim_lsp",
          indicator = {
            style = "underline",
          },
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              -- text_align = "left" | "center" | "right"
              separator = true,
            },
          },
          show_tab_indicators = true,
          show_buffer_close_icons = false,
          seperator_style = "slant",
        },
      }
    end,
  }, ]]
}
