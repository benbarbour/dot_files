return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm" },
  keys = {
    {
      "<leader>tf",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
      end,
      desc = "ToggleTerm (float root_dir)",
    },
    {
      "<leader>ts",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, nil, LazyVim.root.get(), "horizontal")
      end,
      desc = "ToggleTerm (horizontal root_dir)",
    },
    {
      "<leader>tv",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, nil, LazyVim.root.get(), "vertical")
      end,
      desc = "ToggleTerm (vertical root_dir)",
    },
    {
      "<leader>tn",
      "<cmd>ToggleTermSetName<cr>",
      desc = "Set term name",
    },
    {
      "<leader>tc",
      "<cmd>TermSelect<cr>",
      desc = "TooggleTerm choose",
    },
  },
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    shade_terminals = true,
    float_opts = { border = "double" },
  },
}
