return require('packer').startup(function(use)
  use({ 'wbthomason/packer.nvim' }) -- Packer can manage itself

  use({
    'Iron-E/nvim-soluarized',
    config = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd('colorscheme soluarized')
      vim.cmd('highlight clear LineNr')
    end,
  })

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'solarized_dark',
        },
        sections = {
          lualine_a = {
            {
              path = 1
            }
          }
        }
      })
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
          map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

          -- Actions
          map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
          map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
          map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
          map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
          map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
          map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
          map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
          map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
          map('n', '<leader>htd', '<cmd>Gitsigns toggle_deleted<CR>')

          -- Text object
          map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      })
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'c',
          'cmake',
          'cpp',
          'css',
          'go',
          'gomod',
          'html',
          'json',
          'lua',
          'make',
          'python',
          'regex',
          'rust',
          'typescript',
          'vim',
          'vue',
        },
        sync_install = false,
        highlight = { enable = true },
      })
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      })
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require('telescope').load_extension('fzf')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-s>'] = require('telescope.actions').select_horizontal,
              ['<C-?>'] = require('telescope.actions').which_key,
            },
            n = {
              ['<C-s>'] = require('telescope.actions').select_horizontal,
            },
          },
        },
      })

      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      end

      map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>')
      map('n', '<leader>fc', '<cmd>Telescope treesitter<cr>')
      map('n', '<leader>fg', '<cmd>Telescope git_commits<cr>')
      map('n', '<leader>fG', '<cmd>Telescope git_bcommits<cr>')
      map('n', '<leader>/', '<cmd>Telescope live_grep<cr>')
      map('n', '<leader>*', '<cmd>Telescope grep_string<cr>')
    end,
  })

  use({
    'williamboman/mason.nvim',
    run = ":MasonUpdate",
    config = function()
      require("mason").setup();
    end
  })

  use({
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',
    requires = { 'williamboman/mason.nvim' },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "bashls",
          "clangd",
          "cmake",
          "cssls",
          "docker_compose_language_service",
          "dockerls",
          "eslint",
          "gopls",
          "html",
          "jsonls",
          "lemminx",
          "lua_ls",
          "marksman",
          "pylsp",
          "rust_analyzer",
          "taplo",
          "yamlls"
        },
        automatic_installation = true,
      }
    end
  })

  use({
    'neovim/nvim-lspconfig',
    after = { 'mason-lspconfig.nvim' },
    requires = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      local lspconfig = require("lspconfig")

      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      vim.diagnostic.config({
        underline = true,
        signs = true,
        virtual_text = false,
        float = {
          show_header = true,
          source = 'if_many',
          border = 'rounded',
          focusable = false,
        },
        update_in_insert = false, -- default to false
        severity_sort = true , -- default to false
      })

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() return vim.lsp.buf.format{async=true} end, bufopts)
      end

      -- servers that require no special setup go here
      local myServers = {'gopls', 'pyright', 'jsonls'}
      for _, server in ipairs(myServers) do
        lspconfig[server].setup{on_attach = on_attach}
      end

      -- customized servers go here

      lspconfig.eslint.setup {
        on_attach = on_attach,
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine"
            },
            showDocumentation = {
              enable = true
            }
          },
          codeActionOnSave = {
            enable = false,
            mode = "all"
          },
          format = true,
          nodePath = "",
          onIgnoredFiles = "off",
          packageManager = "npm",
          quiet = false,
          rulesCustomizations = {},
          run = "onType",
          useESLintClass = false,
          validate = "on",
          workingDirectory = {
            mode = "location"
          }
        }
      }
    end
  })

  use({ 'tpope/vim-unimpaired' })

  use({
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = function()
      local submods = {
        bufremove = {},
        comment = {},
        jump = {},
        pairs = {},
        surround = {},
        trailspace = {},
        base16 = nil,
        completion = nil,
        cursorword = nil,
        doc = nil,
        fuzzy = nil,
        indentscope = nil,
        misc = nil,
        sessions = nil,
        starter = nil,
        statusline = nil,
        tabline = nil,
      }
      for name, cfg in pairs(submods) do
        if cfg then
          require('mini.' .. name).setup(cfg)
        else
          vim.g['mini' .. name .. '_disable'] = true
        end
      end

      vim.cmd('command! BD lua MiniBufremove.wipeout()')
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<F12>', ':lua MiniTrailspace.trim()<CR>', opts)
      vim.cmd(':highlight! link MiniTrailspace NONE')
    end,
  })

  use({
    'mbbill/undotree',
    config = function()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<F5>', ':UndotreeToggle<CR>', opts)
    end,
  })
end)

-- vim: set expandtab ts=2 sw=2:
