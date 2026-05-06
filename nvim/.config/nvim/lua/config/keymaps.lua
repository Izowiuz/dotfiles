local map = vim.keymap.set

-- === Window splits ===
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>w=", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close current split" })

-- === Move between splits ===
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- === Resize splits ===
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase split height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease split height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease split width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase split width" })

-- === Quality of life ===
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })

-- === Diagnostics navigation ===
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

-- === Quickfix list navigation ===
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>xQ", "<cmd>cclose<CR>", { desc = "Close quickfix list" })
