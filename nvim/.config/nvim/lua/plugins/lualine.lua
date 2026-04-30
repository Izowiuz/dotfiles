return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",            -- matches your colorscheme
        globalstatus = true,       -- one statusline for all windows (matches laststatus = 3)
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
      },
      sections = {
        lualine_a = { "mode" },                          -- mode (colored per-mode by default)
        lualine_b = { "branch", "diff", "diagnostics" }, -- git + LSP diagnostics
        lualine_c = { { "filename", path = 1 } },        -- relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },                      -- percent through file
        lualine_z = { "location" },                      -- line:col
      },
    })
  end,
}