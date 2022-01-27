
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'digitaltoad/vim-jade'
    use 'jiangmiao/auto-pairs'
    use 'leafoftree/vim-svelte-plugin'
    use 'mattn/emmet-vim'
    use 'rust-lang/rust.vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'yggdroot/indentline'
    use 'yuttie/comfortable-motion.vim'
    use 'tpope/vim-fugitive'
    use 'neovim/nvim-lspconfig'
    require('lspconfig').tsserver.setup{}
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
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
            options = { theme = 'powerline' },
            tabline = {
                lualine_a = {'buffers'}
            }
        }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        require'nvim-tree'.setup {}
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        require('gitsigns').setup()
    }
end)
