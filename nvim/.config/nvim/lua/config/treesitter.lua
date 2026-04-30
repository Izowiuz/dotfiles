-- Use Neovim's built-in treesitter parsers
-- These ship with Neovim itself: c, lua, vim, vimdoc, query, markdown, markdown_inline

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "lua", "vim", "help", "query", "markdown" },
  callback = function(args)
    -- pcall: silently skip if parser missing for this filetype
    pcall(vim.treesitter.start, args.buf)
  end,
})