return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim", -- utility library, dependency of many plugins
        "nvim-tree/nvim-web-devicons", -- file icons
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = vim.g.is_win
                    and 'cmd /c "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"'
                or "make",
            cond = function()
                return vim.fn.executable(vim.g.is_win and "cmake" or "make") == 1
            end,
        },
    },
    cmd = "Telescope",
    keys = {
        -- File / find
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "List open buffers" },
        { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
        -- Search
        { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Grep in project" },
        { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Search help" },
        { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
        { "<leader>sR", "<cmd>Telescope resume<CR>", desc = "Resume last picker" },
        -- UI
        { "<leader>uC", "<cmd>Telescope colorscheme<CR>", desc = "Switch colorscheme" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = { preview_width = 0.55 },
                },
                file_ignore_patterns = { "node_modules", ".git/", "build/", "%.o" },
            },
            pickers = {
                find_files = {
                    hidden = true, -- include dotfiles/dotdirectories
                },
            },
        })
        pcall(telescope.load_extension, "fzf") -- enable fzf extension if compiled
    end,
}
