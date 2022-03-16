return require('packer').startup(function(use)

  use { 'wbthomason/packer.nvim' }  -- Packer can manage itself

  use { 'Iron-E/nvim-soluarized', config = function()
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    vim.cmd('colorscheme soluarized')
    vim.cmd('highlight clear LineNr')
  end}

  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'solarized_dark'
        }
      }
    end
  }

  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
          map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

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
        end
      })
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup{
        ensure_installed = 'maintained',
        sync_install = false,
        highlight = { enable = true }
      }
    end
  }

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    },
    config = function()
      require('telescope').load_extension('fzf')
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ['<C-s>'] = require('telescope.actions').select_horizontal,
              ['<C-?>'] = require('telescope.actions').which_key
            },
            n = {
              ['<C-s>'] = require('telescope.actions').select_horizontal
            }
          }
        }
      }

      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      end

      map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>')
      map('n', '<leader>fc', '<cmd>Telescope treesitter<cr>')
      map('n', '<leader>fg', '<cmd>Telescope git_commits<cr>')
      map('n', '<leader>fG', '<cmd>Telescope git_bcommits<cr>')
      map('n', '<leader>/',  '<cmd>Telescope live_grep<cr>')
      map('n', '<leader>*',  '<cmd>Telescope grep_string<cr>')
    end
  }

end)

-- vim: set expandtab ts=2 sw=2:
