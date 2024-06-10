return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
    lazy = false,
  },
  --[[   {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {}
    end,
    lazy = false,
  }, ]]
  {
    "APZelos/blamer.nvim",
    lazy = false,
  },
  {
    "laytan/tailwind-sorter.nvim",
    config = function()
      require("tailwind-sorter").setup {
        on_save_enabled = true, -- If `true`, automatically enables on save sorting.
        on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.twig", "*.hbs", "*.php", "*.heex", "*.astro" }, -- The file patterns to watch and sort.
        node_path = "node",
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
    lazy = false,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").create_default_mappings()
    end,
    lazy = false,
  },
  {
    "tikhomirov/vim-glsl",
    lazy = false,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_save_enabled = true,
        auto_restore_enabled = true,
      }
    end,
    lazy = false,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "rust-analyzer",
        "prettierd",
        "marksman",
      },
      automatic_installation = false,
    },
    lazy = false,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "vimdoc",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "markdown",

        -- low level
        "rust",
        "c",
        "zig",
        "glsl",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
    },
    --[[ config = function()
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup {}
      -- tell treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register("markdown", "mdx")
    end, ]]
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "html",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
