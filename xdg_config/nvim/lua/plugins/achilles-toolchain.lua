-- Run the achilles tree's own checks, and only those, inside that tree.
-- Every decision here is conditional on achilles.root(buf); other projects
-- keep LazyVim's defaults untouched. What counts as a check comes from the
-- repo's config, not from this file — see lua/achilles.lua.

local achilles = require("achilles")

achilles.setup()

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      -- ruff hard-fails on a `required-version` it does not satisfy, so the
      -- tree needs its pinned binary; everywhere else "ruff" is Mason's.
      opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
        cmd = function(dispatchers, config)
          local root = config and config.root_dir
          local exe = achilles.ruff_exe(root) or "ruff"
          return vim.lsp.rpc.start({ exe, "server" }, dispatchers, { cwd = root })
        end,
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters_by_ft = opts.linters_by_ft or {}

      opts.linters.wt_code_style = {
        cmd = function()
          local root = achilles.root(0)
          return root and (root .. "/tools/git-hooks/wt_code_style.py") or ""
        end,
        stdin = false,
        ignore_exitcode = true, -- the script exits 2 on a finding
        condition = function(ctx)
          local root = achilles.root(vim.fn.bufnr(ctx.filename))
          return root ~= nil and achilles.linters(root, "python") ~= nil
        end,
        -- Output is one record per finding: the path, the offending pair of
        -- lines each prefixed with its number, then "==".
        parser = function(output)
          local diags, record = {}, {}
          for _, line in ipairs(vim.split(output, "\n", { plain = true })) do
            if line == "==" then
              -- The script leaks prev_line across files and can report
              -- line 0; nvim-lint passes one file, so that is belt and braces.
              local lnum = record[3] and record[3]:match("^(%d+)")
              if lnum and tonumber(lnum) > 0 then
                diags[#diags + 1] = {
                  lnum = tonumber(lnum) - 1,
                  col = 0,
                  severity = vim.diagnostic.severity.WARN,
                  source = "wt_code_style",
                  message = "closing bracket at column 0 after a trailing comma",
                }
              end
              record = {}
            else
              record[#record + 1] = line
            end
          end
          return diags
        end,
      }

      local py = opts.linters_by_ft.python or {}
      table.insert(py, "wt_code_style")
      opts.linters_by_ft.python = py
    end,
  },

  {
    "stevearc/conform.nvim",
    init = function()
      -- Format on save only where a hook says the project formats that
      -- filetype. The tree carries no .clang-format, stylua.toml or
      -- editorconfig, so today that is nowhere — and saving stops rewriting
      -- files in a style nothing enforces. When a formatting hook does
      -- appear, conform has no python entry and falls back to the LSP,
      -- which is the same pinned ruff the hook runs.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("achilles_format", { clear = true }),
        callback = function(ev)
          local root = achilles.root(ev.buf)
          if not root then return end
          vim.b[ev.buf].autoformat =
            achilles.formatters(root, vim.bo[ev.buf].filetype) ~= nil
        end,
      })
    end,
  },
}
