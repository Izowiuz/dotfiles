return {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/overseer.nvim" },
    ft = { "cpp", "c", "cmake" },
    cmd = {
        "CMakeGenerate",
        "CMakeBuild",
        "CMakeRun",
        "CMakeDebug",
        "CMakeSelectConfigurePreset",
        "CMakeSelectBuildPreset",
        "CMakeSelectBuildTarget",
        "CMakeSelectLaunchTarget",
    },
    keys = {
        { "<leader>cmP", "<cmd>CMakeSelectConfigurePreset<CR>", desc = "Select configure preset" },
        { "<leader>cmp", "<cmd>CMakeSelectBuildPreset<CR>",     desc = "Select build preset" },
        { "<leader>cmg", "<cmd>CMakeGenerate<CR>",              desc = "Generate" },
        { "<leader>cmb", "<cmd>CMakeBuild<CR>",                 desc = "Build" },
        { "<leader>cmr", "<cmd>CMakeRun<CR>",                   desc = "Run" },
        { "<leader>cmd", "<cmd>CMakeDebug<CR>",                 desc = "Debug" },
        { "<leader>cmt", "<cmd>CMakeSelectBuildTarget<CR>",     desc = "Select build target" },
        { "<leader>cmT", "<cmd>CMakeSelectLaunchTarget<CR>",    desc = "Select launch target" },
    },
    config = function(_, opts)
        require("cmake-tools").setup(opts)

        -- Workaround for cmake-tools.nvim#388: :wall raises E141 on unnamed
        -- modified buffers. Temporarily flip 'modified' so :wall skips them.
        local utils = require("cmake-tools.utils")
        local function bypass_wall_on_unnamed(fn)
            return function(...)
                local flipped = {}
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if
                        vim.api.nvim_buf_is_loaded(buf)
                        and vim.bo[buf].modified
                        and vim.api.nvim_buf_get_name(buf) == ""
                    then
                        table.insert(flipped, buf)
                        vim.bo[buf].modified = false
                    end
                end
                local result = fn(...)
                for _, buf in ipairs(flipped) do
                    if vim.api.nvim_buf_is_valid(buf) then
                        vim.bo[buf].modified = true
                    end
                end
                return result
            end
        end
        utils.run = bypass_wall_on_unnamed(utils.run)
        utils.execute = bypass_wall_on_unnamed(utils.execute)
    end,
    opts = {
        cmake_use_preset = true,
        cmake_soft_link_compile_commands = true,
        cmake_command = "cmake",
        cmake_notifications = {
            enabled = true,
            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            refresh_rate_ms = 100,
        },
        -- Build → overseer task (errors auto-parsed to quickfix, output in task panel)
        cmake_executor = {
            name = "overseer",
            opts = {
                new_task_opts = {
                    strategy = "jobstart",
                },
                on_new_task = function(task)
                    require("overseer").open({ enter = false, direction = "bottom" })
                end,
            },
        },
        -- Run → overseer task with terminal (interactive output)
        cmake_runner = {
            name = "overseer",
            opts = {
                new_task_opts = {
                    strategy = "jobstart",
                },
                on_new_task = function(task)
                    require("overseer").open({ enter = false, direction = "bottom" })
                end,
            },
        },
    },
}
