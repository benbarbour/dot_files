return {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = " mfussenegger/nvim-dap",
  config = function(_, opts)
    local dap_go = require("dap-go")
    opts.dap_configurations = {
      {
        type = "go",
        name = "Debug Package (Arguments)",
        request = "launch",
        program = "${fileDirname}",
        args = function()
          local args_string = vim.fn.input("Args (split by <space>): ")
          return vim.fn.split(args_string, " ", true)
        end,
      },
    }
    dap_go.setup(opts)
    require("core.utils").load_mappings("dap_go")
  end,
}
