return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
        -- Navigation
        { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
        -- Close
        { "<leader>bd", "<cmd>bdelete<CR>", desc = "Delete current buffer" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
        { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
        { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
        { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close non-pinned buffers" },
        -- Pin
        { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Pin/unpin buffer" },
        -- Pick
        { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
        { "<leader>bD", "<cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close" },
    },
    opts = {
        options = {
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "",
                    text_align = "left",
                    separator = false, -- vertical separator between offset and tabs
                },
            },
        },
    },
}
