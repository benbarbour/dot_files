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

end)

-- vim: set expandtab ts=2 sw=2:
