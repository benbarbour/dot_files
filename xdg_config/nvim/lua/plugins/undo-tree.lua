return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = {
    { "<leader>i", "<cmd>lua require('undotree').toggle()<cr>", "undotree", desc = "UndoTree" },
  },
}
