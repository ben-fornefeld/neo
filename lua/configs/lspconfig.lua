require("mason").setup()
require("mason-lspconfig").setup()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "tsserver",
  "tailwindcss",
  "eslint",
  "markdown_ls",
}

lspconfig.markdown_ls.setup {
  filetypes = { "markdown", "mdx" },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lsp == "markdown_ls" then
    goto continue
  end

  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }

  ::continue::
end
