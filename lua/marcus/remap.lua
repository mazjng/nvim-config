vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- block movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- re-indent entire file
vim.keymap.set("n", "<leader>=", function()
    local view = vim.fn.winsaveview()
    vim.cmd("normal! gg=G")
    vim.fn.winrestview(view)
end, { desc = "Reindent entire file, keep cursor position" })

-- boostrap undo
-- FIXES: undo re-indent entire file
vim.keymap.set('n', 'u', function()
    local view = vim.fn.winsaveview()
    vim.cmd.undo()
    vim.fn.winrestview(view)
end, { desc = "Undo last action, keep cursor position"})
