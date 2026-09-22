-- achilles.lua — keep the editor's checks in step with the repo's own.
--
-- The tree declares what it enforces in .pre-commit-config.yaml and
-- ruff.toml. Restating those rules here would drift the first time someone
-- adds a hook, so nothing in this file states one: it reads the repo's
-- config and maps each declared hook to its editor equivalent. A hook with
-- no mapping warns once, so a check the editor is not running gets noticed
-- rather than quietly going missing.
--
-- Scope comes from patrocles.find_workspace() — structural (achilles-engine
-- + deps/deb), so it holds in every worktree and with the VM down. Outside
-- an achilles checkout every function here returns nil and nothing changes.

local patrocles = require("patrocles")

local M = {}
local uv = vim.uv or vim.loop

-- pre-commit hook id -> what the editor does about it. `false` means the
-- hook is deliberately not mirrored because it does not look at buffer
-- contents (file names, the staged diff); only an unlisted id warns.
local HOOKS = {
  ["ruff-check"] = { lsp = "ruff" },
  ["ruff-format"] = { format = { python = { "ruff_format" } } },
  ["wt-code-style"] = { lint = { python = { "wt_code_style" } } },
  ["ascii-filenames"] = false,
  ["whitespace-errors"] = false,
  ["check-translations"] = false,
}

local warned = {}

local function warn_once(key, msg)
  if warned[key] then return end
  warned[key] = true
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.WARN, { title = "achilles" })
  end)
end

-- --- the repo's declared checks ---------------------------------------------

--- Hook ids declared for the commit stage, as a set. A line scan rather
--- than a YAML parse: nvim ships no YAML reader, and in this file `id:`
--- only ever introduces a hook. A hook whose `stages:` excludes commit is
--- off the commit path, so the editor should not run it either.
local function scan(path)
  local fd = io.open(path, "r")
  if not fd then return nil end
  local ids, current = {}, nil
  for line in fd:lines() do
    local id = line:match("^%s*%-%s*id:%s*([%w._-]+)")
    if id then
      current, ids[id] = id, true
    elseif current then
      local stages = line:match("^%s*stages:%s*(.+)")
      if stages and not stages:find("commit") then ids[current] = nil end
    end
  end
  fd:close()
  return ids
end

local cache = {} -- root -> { hooks = {mtime, value}, ruff = {mtime, value} }

local function cached(root, key, path, load)
  cache[root] = cache[root] or {}
  local slot = cache[root][key]
  local st = uv.fs_stat(path)
  local mtime = st and st.mtime.sec or -1
  if slot and slot.mtime == mtime then return slot.value end
  local value = st and load(path) or nil
  cache[root][key] = { mtime = mtime, value = value }
  return value
end

--- The set of hook ids this root runs on commit. An absent config means
--- the project declares no checks, which is the honest answer here: the
--- tree carries no .clang-format, stylua.toml or .editorconfig either.
function M.hooks(root)
  if not root then return {} end
  local hooks =
    cached(root, "hooks", root .. "/.pre-commit-config.yaml", scan) or {}
  for id in pairs(hooks) do
    if HOOKS[id] == nil then
      warn_once(root .. "/" .. id, ("pre-commit hook %q has no editor "
        .. "equivalent yet — it will not run on save"):format(id))
    end
  end
  return hooks
end

--- Whether the root declares its checks at all. Before that file exists
--- there is nothing to derive from, so callers leave the editor's own
--- defaults alone rather than reading silence as "runs nothing".
function M.declares(root)
  return root ~= nil
    and uv.fs_stat(root .. "/.pre-commit-config.yaml") ~= nil
end

--- Collect one capability ("lsp" | "format" | "lint") across declared
--- hooks. Returns nil when nothing declares it, which callers read as
--- "the project does not do this", not "unknown".
local function declared(root, capability, ft)
  local out = nil
  for id in pairs(M.hooks(root)) do
    local map = HOOKS[id]
    if map and map[capability] then
      local v = map[capability]
      if capability == "lsp" then
        out = out or {}
        out[v] = true
      elseif v[ft] then
        out = vim.list_extend(out or {}, v[ft])
      end
    end
  end
  return out
end

--- true if a declared hook is what `server` checks (so the LSP earns its
--- place in this tree).
function M.uses_lsp(root, server)
  local set = declared(root, "lsp")
  return set ~= nil and set[server] == true
end

--- conform formatters for `ft`, or nil if no hook formats it.
function M.formatters(root, ft)
  return declared(root, "format", ft)
end

--- nvim-lint linters for `ft`, or nil.
function M.linters(root, ft)
  return declared(root, "lint", ft)
end

-- --- pinned tools -----------------------------------------------------------

local function required_version(path)
  local fd = io.open(path, "r")
  if not fd then return nil end
  local content = fd:read("*a")
  fd:close()
  -- Only the exact form resolves to one binary; a range would need a
  -- solver, and leaving the LSP alone is the safe answer there.
  return content:match('required%-version%s*=%s*"==([%d%.]+)"')
end

--- A ruff matching the root's `required-version`, or nil to leave the
--- server alone. Pinned versions live side by side as `ruff-<version>`
--- (`pipx install ruff==X --suffix=-X`), so bumping the pin in the repo
--- selects a different binary with no change here — and no bare `ruff` on
--- PATH means other projects keep Mason's.
function M.ruff_exe(root)
  if not root then return nil end
  local want = cached(root, "ruff", root .. "/ruff.toml", required_version)
  if not want then return nil end
  local exe = vim.fn.exepath("ruff-" .. want)
  if exe ~= "" then return exe end
  warn_once(root .. "/ruff/" .. want,
    ("ruff.toml requires ruff %s and no ruff-%s is on PATH — diagnostics "
      .. "will not match the commit hook.\n  pipx install ruff==%s "
      .. "--suffix=-%s"):format(want, want, want, want))
  return nil
end

-- --- buffer scope -----------------------------------------------------------

--- The achilles checkout this buffer belongs to, or nil.
function M.root(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  if name == "" then return nil end
  return patrocles.find_workspace(name)
end

-- --- wiring ----------------------------------------------------------------

--- Install the LSP gate and the pyright toggle. Called from the plugin
--- spec's body rather than an `init`, because patrocles-lsp.lua already
--- owns nvim-lspconfig's `init` and lazy keeps only one per plugin.
function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("achilles_lsp", { clear = true }),
    callback = function(ev)
      local root = M.root(ev.buf)
      if not root then return end
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client then return end
      -- basedpyright is a type checker, not one of the project's gates, so
      -- it stays out of the tree; :AchillesPyright brings it back for the
      -- session. ruff goes only if the repo stops declaring it.
      local drop = (client.name == "basedpyright" and not vim.g.achilles_pyright)
        or (client.name == "ruff" and M.declares(root)
          and not M.uses_lsp(root, "ruff"))
      if drop then vim.lsp.stop_client(client.id) end
    end,
  })

  vim.api.nvim_create_user_command("AchillesPyright", function()
    vim.g.achilles_pyright = not vim.g.achilles_pyright
    vim.notify("basedpyright "
      .. (vim.g.achilles_pyright and "enabled" or "disabled")
      .. " in the achilles tree", vim.log.levels.INFO, { title = "achilles" })
    vim.api.nvim_exec_autocmds("FileType", { buffer = 0 })
  end, { desc = "Toggle basedpyright inside the achilles tree" })
end

return M
