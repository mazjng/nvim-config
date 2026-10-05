-- Set the mapleader before all remaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require('marcus.editor')
require('marcus.terminal')
require('marcus.packer')
require('marcus.remap')
require('marcus.statusline')
