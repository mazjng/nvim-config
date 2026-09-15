vim.o.shell = 'pwsh'
vim.keymap.set('n', '<leader>t', ':split | terminal<CR>', { desc = 'Open terminal window'})
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
