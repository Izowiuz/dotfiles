return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",            -- UI component library
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
    { "<leader>o", "<cmd>Neotree focus<CR>",  desc = "Focus file tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        position = "left",
        width = 32,
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      default_component_configs = {
        indent = { with_markers = true },
        git_status = {
          symbols = {
            added     = "+",
            modified  = "~",
            deleted   = "-",
            renamed   = "→",
            untracked = "?",
            ignored   = "○",
            unstaged  = "U",
            staged    = "S",
            conflict  = "!",
          },
        },
      },
    })
  end,
}