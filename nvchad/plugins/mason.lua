return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
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
