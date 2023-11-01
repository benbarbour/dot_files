local M = {
  plugins = "custom.plugins",
  mappings = require("custom.mappings"),
  ui = {
    cheatsheet = { theme = "simple" },
    statusline = {
      overriden_modules = function(modules)
        modules[2] = (function() -- fileInfo override
          local full_path = vim.fn.expand("%:p:~:.") -- relative to project root

          -- get what chad would normally put here (just the filename in a highlight group, followed by a separator)
          local theme = require("core.utils").load_config().ui.statusline.theme
          local chad_fi = require("nvchad.statusline." .. theme).fileInfo()

          -- replace the filename in chad's output with the full path
          local clean_cfi = chad_fi:gsub("%%.*# %A+ (.*) %%.*#.+", "%1") -- strip hightlight groups
          if full_path:match(clean_cfi .. "$") then return chad_fi:gsub(clean_cfi, full_path) end

          -- otherwise return chad's output
          return chad_fi
        end)()
      end,
    },
    tabufline = { enabled = false },
    telescope = { style = "bordered" },
    theme = "solarized_dark",
  },
}

return M
