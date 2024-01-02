local M = {}

M["general (n)"] = { -- named for NvCheatsheet
  n = {
    ["<A-d>"] = { '"_d', "Delete to null register" },
    ["x"] = { '"_x', "Delete to null register", opts = { noremap = true } },
    ["X"] = { '"_X', "Delete to null register", opts = { noremap = true } },
    ["<C-I>"] = { "<C-A>", "Increment number", opts = { noremap = true } },
    ["<C-D>"] = { "<C-X>", "Decrement number", opts = { noremap = true } },
    ["<C-X>"] = { "" },
  },
}

M["gitsigns"] = {
  n = {
    ["<leader>hs"] = {
      function() require("gitsigns").stage_hunk() end,
      "Hunk stage",
    },
    ["<leader>hr"] = {
      function() require("gitsigns").reset_hunk() end,
      "Hunk reset",
    },
    ["<leader>hu"] = {
      function() require("gitsigns").undo_stage_hunk() end,
      "Hunk undo stage",
    },
    ["<leader>hb"] = {
      function() require("gitsigns").blame_line({ full = true }) end,
      "Hunk blame",
    },
    ["<leader>hd"] = {
      function() require("gitsigns").toggle_deleted() end,
      "Toggle displaying deleted hunks",
    },
  },
}

M["nvterm"] = {
  n = {
    ["<leader>tv"] = {
      function() require("nvterm.terminal").new("vertical") end,
      "New vertical term",
    },
    ["<leader>th"] = {
      function() require("nvterm.terminal").new("horizontal") end,
      "New horizontal term",
    },
    ["<leader>tf"] = {
      function() require("nvterm.terminal").toggle("float") end,
      "Toggle floating term",
    },
  },
}

M["telescope"] = {
  n = {
    ["<leader>/"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
  },
}

M["tabufline"] = nil -- disabled plugin

M["dap"] = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Toggle a breakpoint" },
    ["<leader>dus"] = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M["dap_go"]={
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function() require("dap-go").debug_test() end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function() require("dap-go").debug_last() end,
      "Debug last go test",
    },
  },
}

M["dap_python"] = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function() require("dap-python").test_method() end,
      "Run the nearest test method",
    },
  },
}

M["gopher"] = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}

M.disabled = {
  n = {
    -- default gitsigns
    ["<leader>rh"] = "",
    ["<leader>td"] = "",
    -- default term management
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
  t = {
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
}

return M
