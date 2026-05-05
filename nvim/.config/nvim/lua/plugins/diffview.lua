return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>",          desc = "Open diff view" },
    { "<leader>gD", "<cmd>DiffviewClose<CR>",         desc = "Close diff view" },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
  },
}