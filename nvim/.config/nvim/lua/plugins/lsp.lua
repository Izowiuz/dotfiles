return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- Diagnostic display
        vim.diagnostic.config({
            virtual_text = { prefix = "●" },
            signs = true,
            underline = true,
            severity_sort = true,
        })

        -- Keymaps that activate when any LSP attaches to a buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
                end

                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "gr", vim.lsp.buf.references, "List references")
                map("n", "K", vim.lsp.buf.hover, "Hover documentation")
                map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
                map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic at cursor")
            end,
        })

        vim.lsp.config("clangd", {
            cmd = { "clangd", "--background-index", "--clang-tidy" },
        })
        vim.lsp.enable("clangd")

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } }, -- don't warn on 'vim' global
                    workspace = { checkThirdParty = false }, -- no "configure your work environment" prompt
                    telemetry = { enable = false },
                },
            },
        })
        vim.lsp.enable("lua_ls")
    end,
}
