return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { -- format & linting
      "nvimtools/none-ls.nvim",
      config = require("custom.configs.none-ls"),
    },
  },
  config = function()
    require("plugins.configs.lspconfig") -- default nvchad config
    require("custom.configs.lspconfig")
  end,
}
