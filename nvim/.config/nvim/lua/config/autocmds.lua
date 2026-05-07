-- Strip trailing whitespace on save. Skip filetypes where trailing whitespace carries meaning:
--   markdown (two spaces = <br>), diff/gitcommit (patch context).
local strip_skip = { markdown = true, diff = true, gitcommit = true, mail = true }
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if strip_skip[vim.bo.filetype] then
            return
        end
        local save = vim.fn.winsaveview() -- remember cursor position
        vim.cmd([[%s/\s\+$//e]]) -- :s replaces, e flag = no error if no match
        vim.fn.winrestview(save) -- restore cursor
    end,
})

-- Esc exits terminal mode only in plain :term buffers,
-- not in lazygit/toggleterm/etc. which have their own filetypes.
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        if vim.bo[args.buf].filetype == "" then
            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = args.buf, desc = "Exit terminal mode" })
        end
    end,
})

-- Show cursorline only in the active window (visual focus indicator).
local focus = vim.api.nvim_create_augroup("FocusedCursorline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = focus,
    callback = function()
        vim.wo.cursorline = true
    end,
})
vim.api.nvim_create_autocmd("WinLeave", {
    group = focus,
    callback = function()
        vim.wo.cursorline = false
    end,
})