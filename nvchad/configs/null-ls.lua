return function()
  local null_ls = require("null-ls")

  local b = null_ls.builtins

  local sources = {
    -- Lua
    b.formatting.stylua,
    -- Python
    b.formatting.isort,
    b.formatting.black,
    b.diagnostics.mypy,
    b.diagnostics.ruff,
  }

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    -- debug = true,
    sources = sources,

    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    end,
  })
end
