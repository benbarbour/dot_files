-- ruff picks UTF-8 offsets while basedpyright uses UTF-16, so a Python
-- buffer attached to both trips LspInfo's "different position encodings"
-- warning. Offer ruff UTF-16 only; it supports it, and the two then agree.
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
      capabilities = { general = { positionEncodings = { "utf-16" } } },
    })
  end,
}
