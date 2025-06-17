return {
  "nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      signs = true,
    },
    servers = {
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            codeActions = {
              ForceStable = true,
            },
            linters = {
              SpellCheck = true,
            },
            dialect = "Canadian",
          },
        },
      },
    },
  },
}
