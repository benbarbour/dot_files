setlocal nolist
setlocal noexpandtab ts=2 sw=2 sts=2
setlocal textwidth=89 colorcolumn=+1

lua <<EOF
  function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
EOF

autocmd BufWritePre <buffer> lua OrgImports(1000)
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
