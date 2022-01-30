-- plugins for neovim
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- dependencies
  use 'nvim-lua/plenary.nvim'

  -- plugins
  use 'leafoftree/vim-svelte-plugin'
  use 'mattn/emmet-vim'
  use 'mg979/vim-visual-multi'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'yuttie/comfortable-motion.vim'
  use 'Yggdroot/indentLine'

  use {
    'windwp/nvim-autopairs',
    require('nvim-autopairs').setup()
  }
  use {
    'kyazdani42/nvim-tree.lua',
    require('nvim-tree').setup {}
  }
  use {
    'lewis6991/gitsigns.nvim',
    require('gitsigns').setup()
  }
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    require("nvim-lsp-installer").on_server_ready(function(server)
      local opts = {}
      server:setup(opts)
    end)
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    -- run = ':TSUpdate'
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained",
      sync_install = false,

      highlight = {
        enable = true,
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      }
    }
  }
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    require('cmp').setup{
      sources = require('cmp').config.sources({
      { name = 'nvim_lsp'},
      { name = 'buffer'},
      { name = 'path'},
      })
      }
  }
  use {
    'nvim-telescope/telescope.nvim',
    require('telescope').setup{
      defaults = {
        file_ignore_patterns = {
          "node_modules"
        }
      }
    }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    require('lualine').setup{
      options = {
        theme = 'powerline',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      tabline = {
        lualine_a = {'buffers'}
      },
      extentions = { }
    }
  }
end)
