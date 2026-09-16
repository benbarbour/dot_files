return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      gotmpl = { "prettierd" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      sh = { "shfmt" },
    },
  },
}
