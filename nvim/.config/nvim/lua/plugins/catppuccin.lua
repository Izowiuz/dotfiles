return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 9000,
    lazy = true, -- loads on demand via :colorscheme catppuccin
    config = function()
        require("catppuccin").setup({
            flavour = "frappe",
            integrations = {
                treesitter = true,
                native_lsp = { enabled = true },
            },
        })
        -- no colorscheme call here - onedark is the default now
        -- catppuccin remains available via :colorscheme catppuccin
    end,
}

