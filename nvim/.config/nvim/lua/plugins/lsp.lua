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
                map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

                -- Toggle inlay hints (parameter names + inferred types) for this buffer
                if vim.lsp.inlay_hint then
                    map("n", "<leader>uh", function()
                        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
                    end, "Toggle inlay hints")
                end

                -- clangd-specific: switch between source and header via LSP request
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.name == "clangd" then
                    map("n", "<leader>ch", function()
                        local params = vim.lsp.util.make_text_document_params(bufnr)
                        client:request("textDocument/switchSourceHeader", params, function(err, result)
                            if err then
                                vim.notify("clangd: " .. tostring(err), vim.log.levels.ERROR)
                            elseif result then
                                vim.cmd.edit(vim.uri_to_fname(result))
                            else
                                vim.notify("No matching source/header file", vim.log.levels.WARN)
                            end
                        end, bufnr)
                    end, "Switch source/header")
                end
            end,
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu", -- auto-insert needed headers as you type
                "--completion-style=detailed", -- show full signatures in completion
                "--function-arg-placeholders", -- placeholders for fn args after completion
                "--cross-file-rename", -- rename refactor works across translation units
            },
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
