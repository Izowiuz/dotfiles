return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<CR>",         desc = "Open diff view" },
    { "<leader>gV", "<cmd>DiffviewClose<CR>",        desc = "Close diff view" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
  },
}