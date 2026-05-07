return {
    "rcarriga/nvim-notify",
    keys = {
        {
            "<leader>un",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Dismiss notifications",
        },
        {
            "<leader>uN",
            "<cmd>Notifications<CR>",
            desc = "Notification history",
        },
    },
    opts = {
        timeout = 3000,
        stages = "fade", -- fade, slide, fade_in_slide_out, static
        render = "default", -- default, minimal, compact, wrapped-compact
        top_down = true, -- show toasts from the top (bottom is used by overseer/quickfix)
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.4)
        end,
        background_colour = "#1e1e2e", -- fallback for terminals without pseudo-transparency
    },
    init = function()
        -- Lazy-load: the first vim.notify() call loads the plugin and routes through it.
        vim.notify = function(...)
            return require("notify")(...)
        end
    end,
}
