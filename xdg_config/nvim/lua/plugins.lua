return require('packer').startup(function(use)

  use { 'wbthomason/packer.nvim' }  -- Packer can manage itself

  use { 'Iron-E/nvim-soluarized', config = function()
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    vim.cmd('colorscheme soluarized')
    vim.cmd('highlight clear LineNr')
  end}

end)

-- vim: set expandtab ts=2 sw=2:
