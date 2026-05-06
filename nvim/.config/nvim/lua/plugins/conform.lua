return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters = {
            stylua = vim.tbl_extend("force", vim.g.is_win and {
                -- .CMD wrappers require cmd.exe which chokes on spaces in paths.
                -- Calling .exe directly goes through CreateProcess and handles spaces correctly.
                command = vim.fn.stdpath("data") .. "/mason/packages/stylua/stylua.exe",
            } or {}, { prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" } }),
        },
        formatters_by_ft = {
            lua = { "stylua" },
            cpp = { "clang-format" },
            c = { "clang-format" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback", -- use LSP if no formatter defined for the filetype
        },
    },
}
