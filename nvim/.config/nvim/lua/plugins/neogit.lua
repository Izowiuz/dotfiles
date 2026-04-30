return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",         -- enables nice diff views inside neogit
    "nvim-telescope/telescope.nvim",  -- branch/commit picker via telescope
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>",                  desc = "Open Neogit status" },
    { "<leader>gc", "<cmd>Neogit commit<CR>",           desc = "Neogit commit" },
    { "<leader>gP", "<cmd>Neogit push<CR>",             desc = "Neogit push" },
    { "<leader>gl", "<cmd>Neogit pull<CR>",             desc = "Neogit pull" },
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
    graph_style = "unicode",            -- nicer commit graph
    disable_commit_confirmation = false,
    kind = "tab",                       -- open in a new tab; alternatives: "split", "vsplit", "floating"
  },
}