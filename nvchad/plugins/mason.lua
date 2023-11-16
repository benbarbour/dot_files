return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- lua stuff
      "lua-language-server",
      "stylua",
      -- python
      "mypy",
      "pyright",
      "ruff",
    },
  },
}
