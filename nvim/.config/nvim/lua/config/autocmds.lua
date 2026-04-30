-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()  -- remember cursor position
    vim.cmd([[%s/\s\+$//e]])           -- :s replaces, e flag = no error if no match
    vim.fn.winrestview(save)            -- restore cursor
  end,
})