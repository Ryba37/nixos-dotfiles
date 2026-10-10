local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    java = { "palantir-java-format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    python = { "black" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    sh = { "shfmt" },
    toml = { "taplo" },
    kotlin = { "ktlint" },
    swift = { "swift-format" },
  },

  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
}

return options
