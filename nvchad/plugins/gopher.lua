return {
  "olexsmir/gopher.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",
  },
  ft = "go",
  config = function(_, opts)
    require("gopher").setup(opts)
    require("core.utils").load_mappings("gopher")
  end,
  build = function() vim.cmd([[silent! GoInstallDeps]]) end,
}
