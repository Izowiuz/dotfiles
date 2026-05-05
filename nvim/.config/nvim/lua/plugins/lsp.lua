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

        map("n", "gd",         vim.lsp.buf.definition,    "Go to definition")
        map("n", "gr",         vim.lsp.buf.references,    "List references")
        map("n", "K",          vim.lsp.buf.hover,         "Hover documentation")
        map("n", "<leader>cr", vim.lsp.buf.rename,        "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action,   "Code action")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic at cursor")
      end,
    })

    -- Configure clangd (extends the default config from nvim-lspconfig)
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
      },
    })

    -- Enable clangd (it will activate automatically for C/C++ filetypes)
    vim.lsp.enable("clangd")
  end,
}
