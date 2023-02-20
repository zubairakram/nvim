-- line numbering
vim.wo.number = true
vim.wo.relativenumber = true

-- set highlight on search
vim.o.hlsearch = false
vim.o.breakindent = true
-- case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- tab to space setting
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- file related setting
vim.o.autowriteall = true
vim.o.backupcopy = 'auto'
vim.o.undofile = true

-- toggle Nvim Tree
vim.keymap.set('n', '<C-j>', ':NvimTreeToggle<cr>')
-- launch Telescope
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>')
-- copy selected lines to system clipboard
vim.keymap.set('v', '<C-c>', '"+y', {})

-- Install Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        --        require('onedark').load()
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
--------------------------------------PLUGINS-----------------------------------
require("lazy").setup({

    -- plugins without configuration
    'karb94/neoscroll.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'mattn/emmet-vim',
    'mg979/vim-visual-multi',
    'numToStr/Comment.nvim',
    'tpope/vim-surround',
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'windwp/nvim-autopairs',
    'nvim-treesitter/nvim-treesitter',

    --plugins with configurationp
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "tsserver" }
        }
    },
    {
        'navarasu/onedark.nvim',
        opts = {
            style = "deep"
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            tabline = {
                lualine_a = {'buffers'}
            }
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "node_modules"
                }
            }
        },
        version='*',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+'},
                change = { text = '~'},
                delete = { text = '_'},
                topdelete = { text = '‾'},
                changedelete = { text = '~'},
            }
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
    },
}, {})

require("mason").setup()
require("mason-lspconfig").setup()
require('neoscroll').setup()
require("nvim-autopairs").setup()
require("nvim-tree").setup()
require("onedark").load()
require('Comment').setup()
require('nvim-treesitter.configs').setup {
    ensure_installed = { "css", "javascript", "html", "lua", "python"},
}


local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities
}
