return {
    "stevearc/overseer.nvim",
    cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerRun",
        "OverseerRunCmd",
        "OverseerInfo",
        "OverseerBuild",
        "OverseerQuickAction",
        "OverseerTaskAction",
    },
    keys = {
        { "<leader>uo", "<cmd>OverseerToggle<CR>",      desc = "Toggle task panel" },
        { "<leader>ur", "<cmd>OverseerRun<CR>",         desc = "Run task" },
        { "<leader>ua", "<cmd>OverseerQuickAction<CR>", desc = "Task quick action" },
    },
    opts = {
        strategy = "jobstart",
        templates = { "builtin" },
        task_list = {
            direction = "bottom",
            min_height = 10,
            max_height = 20,
            default_detail = 1,
        },
        component_aliases = {
            default = {
                { "display_duration", detail_level = 2 },
                "on_output_summarize",
                "on_exit_set_status",
                "on_complete_notify",
                "on_complete_dispose",
            },
        },
    },
}
