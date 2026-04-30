return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
      },
    })
    -- no colorscheme call here - onedark is the default now
    -- catppuccin remains available via :colorscheme catppuccin
  end,
}