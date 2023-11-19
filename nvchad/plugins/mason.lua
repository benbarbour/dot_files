return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- python
      "black",
      "debugpy",
      "mypy",
      "pyright",
      "ruff",
    },
  },
}
