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
        {
            "<leader>uo",
            function()
                -- Smart toggle: close everything overseer-related (panel + output windows).
                -- If nothing is open, open the panel.
                local task_bufs = {}
                for _, task in ipairs(require("overseer").list_tasks()) do
                    if task.strategy and task.strategy.bufnr then
                        task_bufs[task.strategy.bufnr] = true
                    end
                end
                local closed = false
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_is_valid(win) then
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype == "OverseerList" or task_bufs[buf] then
                            pcall(vim.api.nvim_win_close, win, false)
                            closed = true
                        end
                    end
                end
                if not closed then
                    require("overseer").open({ enter = false, direction = "bottom" })
                end
            end,
            desc = "Toggle overseer (panel + outputs)",
        },
        {
            "<leader>uO",
            function()
                if vim.bo.filetype == "OverseerList" then
                    vim.cmd("wincmd p") -- już w panelu → wróć do poprzedniego okna
                else
                    require("overseer").open({ enter = true, direction = "bottom" })
                end
            end,
            desc = "Focus task list (toggle)",
        },
        { "<leader>ur", "<cmd>OverseerRun<CR>",         desc = "Run task" },
        { "<leader>ua", "<cmd>OverseerQuickAction<CR>", desc = "Task quick action" },
    },
    opts = {
        task_list = {
            keymaps = {
                -- <CR> otwiera output jako vsplit obok edytora.
                -- Fullscreen przez <leader>wz (zoom toggle).
                ["<CR>"] = {
                    "keymap.open",
                    opts = { dir = "vsplit" },
                    desc = "Open task output (vsplit)",
                },
                -- menu akcji zostaje pod 'a'
                ["a"] = { "keymap.run_action", desc = "Task action menu" },
            },
        },
    },
}
