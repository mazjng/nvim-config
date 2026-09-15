return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "bashls",
            "clangd",
            "cssls",
            "eslint",
            "html",
            "lua_ls",
            "marksman",
            "powershell_es",
            "pyright",
            "ruff",
            "texlab",
            "ts_ls",
        }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
