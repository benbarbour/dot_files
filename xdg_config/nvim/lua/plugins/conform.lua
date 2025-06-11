return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      html = { "prettier" },
      javascript = { "prettier" },
      markdown = { "prettier" },
    },
  },
}
