local path = require("lspconfig/util").path

return function()
  local null_ls = require("null-ls")

  local b = null_ls.builtins

  if vim.env.VIRTUAL_ENV then vim.env.PATH = path.join(vim.env.VIRTUAL_ENV, "bin") .. ":" .. vim.env.PATH end

  local sources = {
    -- Go
    b.formatting.gofumpt,
    b.formatting.goimports,
    b.formatting.golines,
    -- Lua
    b.formatting.stylua,
    -- Python
    b.formatting.isort,
    b.formatting.black,
    b.diagnostics.mypy,
    b.diagnostics.ruff,
    -- Web
    b.formatting.biome.with({
      args = {
        "check",
        "--apply-unsafe",
        "--formatter-enabled=true",
        "--organize-imports-enabled=true",
        "--skip-errors",
        "$FILENAME",
      },
    }),
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
