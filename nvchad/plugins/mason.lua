return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- go
      "delve",
      "gofumpt",
      "goimports",
      "golines",
      "gopls",
      -- lua stuff
      "lua-language-server",
      "stylua",
      -- python
      "black",
      "debugpy",
      "isort",
      "mypy",
      "pyright",
      "ruff",
      -- web
      "biome",
      "svelte-language-server",
    },
  },
}
