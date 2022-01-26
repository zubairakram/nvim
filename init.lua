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
-- " Register CocExtensions
-- let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-svelte', 'coc-tsserver', 'coc-rls', 'coc-lua']
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
    vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {})
    vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {})
end)
