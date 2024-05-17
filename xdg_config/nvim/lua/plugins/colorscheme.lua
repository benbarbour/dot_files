return {
  "maxmx03/solarized.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized").setup({
      highlights = function(colors, _)
        return {
          LineNr = { bg = colors.base03 },
          GitsignsAdd = { bg = colors.base03 },
          GitsignsChange = { bg = colors.base03 },
          GitsignsDelete = { bg = colors.base03 },
        }
      end,
    })
    vim.o.background = "dark" -- or 'light'
    vim.cmd.colorscheme("solarized")
  end,
}
