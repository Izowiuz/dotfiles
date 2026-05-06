return {
    "Izowiuz/izo-nvim-treesitter",
    cond = not vim.g.is_win,
    config = function()
        require("izo-nvim-treesitter").setup()
    end,
}
