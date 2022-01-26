-- "basic configuration

vim.o.autoread = true
vim.o.autowriteall = true
vim.o.backupcopy = 'auto'
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- 
-- " highlight current line
-- hi cursorline cterm=none term=none
-- autocmd WinEnter * setlocal cursorline
-- autocmd WinLeave * setlocal nocursorline
-- highlight CursorLine guibg=#303030 ctermbg=234
-- 
-- " copy from vim to clipboard key mapping
-- vnoremap <C-c> "+y
-- 
-- " Find files using Telescope command-line sugar.
-- nnoremap <C-p> <cmd>Telescope find_files<cr>
-- nnoremap <C-g> <cmd>Telescope live_grep<cr>
-- nnoremap <C-b> <cmd>Telescope buffers<cr>
-- nnoremap <C-h> <cmd>Telescope help_tags<cr>
-- 
-- " Register CocExtensions
-- let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-svelte', 'coc-tsserver', 'coc-rls', 'coc-lua']
--       
-- " Netrw setting
-- map <C-t> :Lexplore<CR>
-- let g:netrw_liststyle = 3
-- let g:netrw_winsize = -32
-- 
-- ********************************************************************************
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'airblade/vim-gitgutter'
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
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        require('telescope').setup{
            defaults = {
                mappings = {
                    i = {
                        ["<C-p>"] = "find_files(opts)"
                    }
                }
            },
            pickers = {
                find_files = {
                    theme = 'dropdown',
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
end)
