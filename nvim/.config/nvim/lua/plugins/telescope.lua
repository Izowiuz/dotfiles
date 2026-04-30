return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",          -- utility library, dependency of many plugins
    "nvim-tree/nvim-web-devicons",    -- file icons
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",                 -- compiled C extension for fast fuzzy matching
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>",  desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>",   desc = "Grep in project" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>",     desc = "List open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",   desc = "Search help" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>",    desc = "Recent files" },
    { "<leader>fc", "<cmd>Telescope colorscheme<CR>", desc = "Switch colorscheme" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { preview_width = 0.55 },
        },
        file_ignore_patterns = { "node_modules", ".git/", "build/", "%.o" },
      },
    })
    pcall(telescope.load_extension, "fzf")  -- enable fzf extension if compiled
  end,
}