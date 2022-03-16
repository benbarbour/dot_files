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
        ensure_installed = 'maintained',
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
    'neovim/nvim-lspconfig',
    config = function()
      vim.diagnostic.config({
        virtual_text = { severity = 'Error' },
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = true,
      })

      -- Customize the diagnostic symbols
      local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Show diagnostics on the current line in a popup
      -- vim.o.updatetime = 250
      -- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

      -- Keybindings
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    end,
  })

  use({
    'williamboman/nvim-lsp-installer',
    config = function()
      require('nvim-lsp-installer').on_server_ready(function(server)
        local opts = {
          on_attach = function()
            local opts = { noremap = true, silent = true }
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Key Mappings
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<space>wa',
              '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
              opts
            )
            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<space>wr',
              '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
              opts
            )
            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<space>wl',
              '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
              opts
            )
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
          end,
        }

        if server.name == 'sumneko_lua' then
          opts.settings = {
            Lua = {
              diagnostics = { globals = { 'vim', 'bufnr' } },
              workspace = { library = vim.api.nvim_get_runtime_file('', true) },
              telemetry = { enable = false },
            },
          }
        end

        -- This setup() function will take the provided server configuration
        -- and decorate it with the necessary properties before passing it
        -- onwards to lspconfig.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
      end)
    end,
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      local ns = require('null-ls')
      ns.setup({
        sources = {
          ns.builtins.formatting.stylua.with({
            extra_args = {
              '--indent-type',
              'Spaces',
              '--indent-width',
              '2',
              '--quote-style',
              'AutoPreferSingle',
            },
          }),
        },
      })
    end,
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
