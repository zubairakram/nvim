-- plugins for neovim
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    -- dependencies
    use 'nvim-lua/plenary.nvim'

    -- plugins
    use 'digitaltoad/vim-jade'
    use {
        'windwp/nvim-autopairs',
        require('nvim-autopairs').setup()
    }
    use 'leafoftree/vim-svelte-plugin'
    use 'mattn/emmet-vim'
    use 'rust-lang/rust.vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'yggdroot/indentline'
    use 'yuttie/comfortable-motion.vim'
    use 'tpope/vim-fugitive'
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
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/nvim-lsp-installer',
        require("nvim-lsp-installer").on_server_ready(function(server)
            local opts = {}
            if server.name == "sumneko_lua" then
                opts = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim', 'use' }
                            }
                        }
                    }
                }
            end
            server:setup(opts)
        end)
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
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    local cmp = require'cmp'

    cmp.setup({
        mapping = {
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
            })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        sources = {
        { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
        { name = 'path' }
        }, {
            { name = 'cmdline' }
            })
    })

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    require('lspconfig')['sumneko_lua'].setup {
        capabilities = capabilities
    }
end)
