return {
  "andrewferrier/wrapping.nvim",
  config = function()
    require("wrapping").setup()
  end,
  opts = {
    create_commands = true,
    create_keymaps = false,
  },
}
