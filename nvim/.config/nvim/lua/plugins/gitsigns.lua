return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signcolumn = true,                 -- show signs in the sign column
    numhl      = false,                -- don't highlight line numbers (signcolumn is enough)
    current_line_blame = false,        -- inline blame off by default; toggle with <leader>gb
    current_line_blame_opts = {
      virt_text_pos = "eol",           -- show blame at end of line
      delay = 500,
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- === Navigation between hunks ===
      map("n", "]h", function() gs.nav_hunk("next") end, "Next git hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Previous git hunk")

      -- === Hunk actions ===
      map("n", "<leader>gs", gs.stage_hunk,           "Stage hunk")
      map("n", "<leader>gr", gs.reset_hunk,           "Reset hunk")
      map("n", "<leader>gS", gs.stage_buffer,         "Stage entire buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk,      "Undo stage hunk")
      map("n", "<leader>gp", gs.preview_hunk,         "Preview hunk diff")

      -- === Blame ===
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame current line")
      map("n", "<leader>gB", gs.toggle_current_line_blame,                  "Toggle inline blame")

      -- === Diff ===
      map("n", "<leader>gd", gs.diffthis, "Diff against index")
    end,
  },
}