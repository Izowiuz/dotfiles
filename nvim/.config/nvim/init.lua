-- Leader must be set BEFORE loading keymaps and plugins,
-- otherwise <leader> resolves to the default backslash.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- platform detection
vim.g.is_win = vim.fn.has("win32") == 1

-- configs
require("config.options")

-- keymaps
require("config.keymaps")

-- auto commands
require("config.autocmds")

-- plugin manager
require("config.lazy")
