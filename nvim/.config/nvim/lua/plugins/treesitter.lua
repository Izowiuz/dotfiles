return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "cmake", "make",
        "lua", "vim", "vimdoc",
        "markdown", "markdown_inline",  -- fixes the error you just got
        "bash", "json", "yaml", "toml",
        "gitignore", "gitcommit",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}