local M = {
  plugins = "custom.plugins",
  mappings = require("custom.mappings"),
  ui = {
    cheatsheet = { theme = "simple" },
    theme = "solarized_dark",
    tabufline = { enabled = false },
    telescope = { style = "bordered" },
  },
}

return M
