return require("packer").startup(function()
	use 'wbthomason/packer.nvim'

	-- dependencies
	use 'nvim-lua/plenary.nvim'
	use 'kyazdani42/nvim-web-devicons'

	-- plugins
	use 'leafoftree/vim-svelte-plugin'
	use 'mattn/emmet-vim'
	use 'mg979/vim-visual-multi'
	use 'tpope/vim-surround'
	use 'Yggdroot/indentLine'
	use 'b3nj5m1n/kommentary'
	use {
		'karb94/neoscroll.nvim',
		require('neoscroll').setup()
	}
	use {
		'TimUntersberger/neogit',
		require('neogit').setup()
	}
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
		require('gitsigns').setup{
			signs = {
				add = { text = '+'},
				change = { text = '~'},
				delete = { text = '_'},
				topdelete = { text = '‾'},
				changedelete = { text = '~'},
			}
		}
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		require('nvim-treesitter.configs').setup {
			ensure_installed = "all",
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			}
		}
	}
	use {
		'neovim/nvim-lspconfig',
		'williamboman/nvim-lsp-installer',
		require("nvim-lsp-installer").on_server_ready(function(server)
			local opts = {}
			if server.name == "sumneko_lua" then
				opts = {
					settings = {
						Lua = {
							diagnostics = {
								globals = {'vim', 'use'}
							}
						}
					}
				}
			end
			server:setup(opts)
		end)
	}
	use {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-vsnip',
		'hrsh7th/vim-vsnip'
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
