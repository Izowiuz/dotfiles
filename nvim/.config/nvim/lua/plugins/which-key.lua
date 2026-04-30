return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",       -- modern, classic, or helix layout
    delay = 400,             -- ms to wait before showing popup (matches timeoutlen)
    icons = {
      mappings = true,       -- show icons next to mappings
    },
    spec = {
      -- Group definitions: give friendly names to leader prefixes
      { "<leader>f", group = "find" },
      { "<leader>s", group = "splits" },
      { "<leader>e", desc = "toggle file tree" },
      { "<leader>o", desc = "focus file tree" },
      { "<leader>w", desc = "save file" },
      { "<leader>q", desc = "quit" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = true }) end,
      desc = "Show all keymaps",
    },
  },
}