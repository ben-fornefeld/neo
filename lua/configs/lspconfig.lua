require("mason").setup()
require("mason-lspconfig").setup()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "tsserver",
  "tailwindcss",
  "eslint",
  "marksman",
  "glsl_analyzer",
  "gopls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lsp == "gopls" then
    lspconfig.gopls.setup {
      on_attach = function(client)
        -- Enable golangci-lint integration
        require("lspconfig").gopls.setup {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        }
      end,
    }

    goto continue
  end

  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }

  ::continue::
end
