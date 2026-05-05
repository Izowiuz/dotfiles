return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<CR>",                desc = "LazyGit (status)" },
    { "<leader>gf", "<cmd>LazyGitCurrentFile<CR>",     desc = "LazyGit for current file" },
    { "<leader>gl", "<cmd>LazyGitFilter<CR>",          desc = "LazyGit log filter" },
  },
}
