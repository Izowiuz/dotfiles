return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern", -- modern, classic, or helix layout
        delay = 400, -- ms to wait before showing popup (matches timeoutlen)
        icons = {
            mappings = true, -- show icons next to mappings
        },
        spec = {
            -- Group definitions: friendly names for leader prefixes
            { "<leader>b", group = "buffers" },
            { "<leader>c", group = "code" },
            { "<leader>cm", group = "cmake" },
            { "<leader>f", group = "file / find" },
            { "<leader>g", group = "git" },
            { "<leader>gh", group = "hunks" },
            { "<leader>q", group = "quit / session" },
            { "<leader>s", group = "search" },
            { "<leader>u", group = "ui" },
            { "<leader>w", group = "windows" },
            { "<leader>x", group = "diagnostics / quickfix" },
            -- Standalone descriptions
            { "<leader>e", desc = "toggle file tree" },
            { "<leader>o", desc = "focus file tree" },
            { "<leader>?", desc = "show all keymaps" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = true })
            end,
            desc = "Show all keymaps",
        },
    },
}
