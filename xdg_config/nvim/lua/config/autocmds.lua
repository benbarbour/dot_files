-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local api = vim.api

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command("augroup " .. group_name)
    api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.iter({ "autocmd", def }):flatten():totable(), " ")
      api.nvim_command(command)
    end
    api.nvim_command("augroup END")
  end
end

nvim_create_augroups({
  terminal_job = {
    { "TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]] },
    { "TermOpen", "*", "startinsert" },
    { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" },
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    -- using harper-ls for spelling
    vim.wo.spell = false
  end,
})
