return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    -- Navigation
    { "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",            desc = "Previous buffer" },
    { "<S-l>",      "<cmd>BufferLineCycleNext<CR>",            desc = "Next buffer" },
    -- Close
    { "<leader>bd", "<cmd>bdelete<CR>",                        desc = "Delete current buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>",          desc = "Close other buffers" },
    { "<leader>br", "<cmd>BufferLineCloseRight<CR>",           desc = "Close buffers to the right" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>",            desc = "Close buffers to the left" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close non-pinned buffers" },
    -- Pin
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>",            desc = "Pin/unpin buffer" },
    -- Pick
    { "<leader>bb", "<cmd>BufferLinePick<CR>",                 desc = "Pick buffer (jump letter)" },
    { "<leader>bD", "<cmd>BufferLinePickClose<CR>",            desc = "Pick buffer to close" },
  },
  opts = {
    options = {
      mode = "buffers",                       -- "buffers" or "tabs"; "buffers" = like VSCode tabs
      diagnostics = "nvim_lsp",               -- show LSP error/warn count on each buffer
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,                   -- vertical separator between offset and tabs
        },
      },
      separator_style = "slant",              -- "slant" | "thick" | "thin" | { "|", "|" }
      show_buffer_close_icons = true,
      show_close_icon = false,                -- the global "close all" icon at the right
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },                 -- show close button on hover
      },
    },
  },
}
