------------------------------BASIC CONFIGURATIONS------------------------------
-- line numbering
vim.wo.number = true
vim.wo.relativenumber = true

-- highlights
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.hlsearch = false

-- case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- tab to space setting
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- file related setting
vim.o.autowriteall = true
vim.o.backupcopy = 'auto'
vim.o.undofile = true
vim.o.scrolloff = 4

-- better escape
vim.keymap.set('i', 'jj', '<esc>', { desc = 'Switch to Normal Mode' })
-- launch lazy
vim.keymap.set('n', '<space>ll', ':Lazy<cr>', { desc = 'Launch Lazy' })
-- toggle Nvim Tree
vim.keymap.set('n', '<c-j>', ':NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })
-- launch Telescope
vim.keymap.set('n', '<c-p>', ':Telescope find_files<CR>', { desc = 'Launch Telescope' })
-- copy selected lines to system clipboard
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Install Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
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
    'folke/neodev.nvim',
    'karb94/neoscroll.nvim',
    'mattn/emmet-vim',
    'mg979/vim-visual-multi',
    'neovim/nvim-lspconfig',
    'numToStr/Comment.nvim',
    'nvim-treesitter/nvim-treesitter',
    'rafamadriz/friendly-snippets',
    'ray-x/lsp_signature.nvim',
    'rcarriga/nvim-notify',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
    'windwp/nvim-autopairs',

    --plugins with configuration
    {
        'j-hui/fidget.nvim',
        opts = {
            text = {
                spinner = 'dots_pulse'
            }
        }
    },
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'navarasu/onedark.nvim',
        opts = {
            style = 'deep'
        }
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap'
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                globalstatus = true
            },
            sections = {
                lualine_a = { 'mode', 'selectioncount' },
            },
            tabline = {
                lualine_a = { 'buffers' }
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
                    'node_modules'
                }
            }
        },
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            }
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
    },
}, {})

-- activate plugins
vim.notify = require("notify")
require('Comment').setup()
require('fidget').setup()
require('lsp_signature').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('neoscroll').setup()
require('nvim-autopairs').setup()
require('nvim-tree').setup()
require('onedark').load()
require('nvim-treesitter.configs').setup {
    ensure_installed = { 'css', 'javascript', 'html', 'lua', 'python' },
}

----------------------------------LSP Mappings----------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
--------------------------------NVIM CMP CONFIGS--------------------------------
local cmp = require 'cmp'

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
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
local servers = { 'lua_ls', 'tsserver', 'pyright' }
for _, server in pairs(servers) do
    require('lspconfig')[server].setup {
        capabilities = capabilities
    }
end

-- treesitter configuration
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    },
    indent = {
        enable = true,
        disable = { 'python' }
    }
}

-- enable nvim-tree indent_markers
require('nvim-tree').setup({
    renderer = {
        indent_markers = {
            enable = true
        }
    }
})

-- friendly snippets plugin loaded
require("luasnip.loaders.from_vscode").lazy_load()
