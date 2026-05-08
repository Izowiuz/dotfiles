return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("onedark").setup({
            style = "dark", -- options: dark, darker, cool, deep, warm, warmer, light
            highlights = {
                -- onedark gives WinSeparator a bg that creates a "blocky" column
                -- along vertical splits (most visible next to neo-tree). Strip the
                -- bg so the separator is just a thin fg char on transparent bg —
                -- consistent with overseer's horizontal separator.
                WinSeparator = { fg = "#444444", bg = "NONE" },
                NeoTreeWinSeparator = { fg = "#444444", bg = "NONE" },
            },
        })
        vim.cmd.colorscheme("onedark") -- apply on startup
    end,
}

