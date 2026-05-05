-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()  -- remember cursor position
    vim.cmd([[%s/\s\+$//e]])           -- :s replaces, e flag = no error if no match
    vim.fn.winrestview(save)            -- restore cursor
  end,
})

-- Esc exits terminal mode only in plain :term buffers,
-- not in lazygit/toggleterm/etc. which have their own filetypes.
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    if vim.bo[args.buf].filetype == "" then
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>",
        { buffer = args.buf, desc = "Exit terminal mode" })
    end
  end,
})
