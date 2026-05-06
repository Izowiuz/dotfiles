return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true, -- show signs in the sign column
        numhl = false, -- don't highlight line numbers (signcolumn is enough)
        current_line_blame = false, -- inline blame off by default; toggle with <leader>gb
        current_line_blame_opts = {
            virt_text_pos = "eol", -- show blame at end of line
            delay = 500,
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- === Navigation between hunks ===
            map("n", "]h", function()
                gs.nav_hunk("next")
            end, "Next git hunk")
            map("n", "[h", function()
                gs.nav_hunk("prev")
            end, "Previous git hunk")

            -- === Hunk actions (under <leader>gh*) ===
            map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
            map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>ghS", gs.stage_buffer, "Stage entire buffer")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
            map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk diff")
            map("n", "<leader>ghd", gs.diffthis, "Diff against index")

            -- === Blame ===
            map("n", "<leader>ghb", function()
                gs.blame_line({ full = true })
            end, "Blame current line")
            map("n", "<leader>ghB", gs.toggle_current_line_blame, "Toggle inline blame")
        end,
    },
}

