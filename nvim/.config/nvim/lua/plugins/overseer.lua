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
                -- Smart toggle: close everything overseer-related (panel + output
                -- windows). If nothing is open, open the panel and focus it.
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
                    require("overseer").open({ enter = true, direction = "bottom" })
                end
            end,
            desc = "Toggle overseer (panel + outputs, focus on open)",
        },
        {
            "<leader>uO",
            function()
                -- Jump-to-panel toggle: if cursor is in the panel, return to the
                -- previous window. Otherwise, open the panel and focus it.
                if vim.bo.filetype == "OverseerList" then
                    vim.cmd("wincmd p")
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
                -- <CR> opens task output as a vsplit. Reuse: if any task output
                -- vsplit already exists in the main editor area (above the panel),
                -- swap its buffer to the selected task and focus it. Only create
                -- a new vsplit when none exists.
                -- Overseer's auto-preview in the panel (same row as the task list)
                -- is ignored on purpose — we want the big vsplit, not the preview.
                ["<CR>"] = {
                    desc = "Open task output (reuse existing vsplit or create new)",
                    callback = function()
                        local sb = require("overseer.task_list.sidebar").get()
                        if not sb then
                            return
                        end
                        local task = sb:get_task_from_line()
                        if not task or not task.strategy or not task.strategy.bufnr then
                            return
                        end
                        local target = task.strategy.bufnr

                        -- Collect all task output bufnrs (used to detect reusable windows).
                        local task_bufs = {}
                        for _, t in ipairs(require("overseer").list_tasks()) do
                            if t.strategy and t.strategy.bufnr then
                                task_bufs[t.strategy.bufnr] = true
                            end
                        end

                        -- Panel row — anything at or below this row is part of the
                        -- bottom panel (task list + auto-preview), and is skipped.
                        local panel_row
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].filetype == "OverseerList" then
                                panel_row = vim.api.nvim_win_get_position(win)[1]
                                break
                            end
                        end

                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            if vim.api.nvim_win_is_valid(win) then
                                local buf = vim.api.nvim_win_get_buf(win)
                                local row = vim.api.nvim_win_get_position(win)[1]
                                if task_bufs[buf] and (not panel_row or row < panel_row) then
                                    if buf ~= target then
                                        vim.api.nvim_win_set_buf(win, target)
                                    end
                                    vim.api.nvim_set_current_win(win)
                                    return
                                end
                            end
                        end
                        sb:run_action("open vsplit")
                    end,
                },
                -- Action menu moves to 'a' since <CR> is taken.
                ["a"] = { "keymap.run_action", desc = "Task action menu" },
            },
        },
    },
}
