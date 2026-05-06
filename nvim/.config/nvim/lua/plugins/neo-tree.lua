return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim", -- UI component library
    },
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
        {
            "<leader>o",
            function()
                if vim.bo.filetype == "neo-tree" then
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype ~= "neo-tree" and vim.bo[buf].buftype == "" then
                            vim.api.nvim_set_current_win(win)
                            return
                        end
                    end
                else
                    vim.cmd("Neotree focus")
                end
            end,
            desc = "Toggle focus: tree / buffer",
        },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            source_selector = {
                winbar = true,
                separator = { left = "▏", right = " " },
                content_layout = "center",
                sources = {
                    { source = "filesystem", display_name = "󰉓 Files" },
                    { source = "buffers", display_name = "󰈙 Buffers" },
                    { source = "git_status", display_name = "󰊢 Git" },
                },
            },
            window = {
                position = "left",
                width = 32,
                mappings = {
                    ["<bs>"] = false,
                    ["<leader>f"] = function(state)
                        local node = state.tree:get_node()
                        local path = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
                        require("telescope.builtin").find_files({ cwd = path })
                    end,
                    ["<leader>s"] = function(state)
                        local node = state.tree:get_node()
                        local path = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
                        require("telescope.builtin").live_grep({ cwd = path })
                    end,
                    ["<leader>g"] = function(state)
                        local node = state.tree:get_node()
                        local path = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
                        require("lazygit").lazygit(path)
                    end,
                },
            },
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            },
            default_component_configs = {
                indent = {
                    with_markers = true,
                    with_expanders = true,
                },
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "~",
                        deleted = "-",
                        renamed = "→",
                        untracked = "?",
                        ignored = "○",
                        unstaged = "U",
                        staged = "S",
                        conflict = "!",
                    },
                },
            },
        })
    end,
}
