local M = {}

M.is_windows = vim.fn.has('win32') == 1
M.is_linux = vim.fn.has('unix') == 1

return M
