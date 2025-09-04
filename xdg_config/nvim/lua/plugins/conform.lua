return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      markdown = { "prettierd" },
      gotmpl = { "prettierd" },
    },
  },
}
