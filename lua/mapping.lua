-- toggle Nvim Tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', {})

-- launch Telescope
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {})

-- copy selected lines to system clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {})
