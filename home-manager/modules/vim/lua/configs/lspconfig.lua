require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        buildScripts = {
          enable = false,
        },
        checkOnSave = false,
      },
    },
  },
})

vim.lsp.config("sourcekit", {})

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

local servers = { "html", "cssls", "rust_analyzer", "sourcekit", "pyright" }
vim.lsp.enable(servers)
