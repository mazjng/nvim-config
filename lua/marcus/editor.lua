vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.undofile = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"

-- toggle invisibles on <leader>si (show invisibles)
vim.keymap.set('n', '<leader>si', function () vim.opt.list = not vim.opt.list:get() end)
vim.opt.listchars = { leadmultispace = "|···", tab = "<->", trail = "·"}
