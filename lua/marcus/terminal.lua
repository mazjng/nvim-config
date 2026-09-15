local os_utils = require('marcus.osutils')

if os_utils.is_windows then
    vim.o.shell = 'pwsh'
else
    vim.o.shell = '/usr/bin/zsh'
end

vim.keymap.set('n', '<leader>t', ':split | terminal<CR>', { desc = 'Open terminal window'})
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
