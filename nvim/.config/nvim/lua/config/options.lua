local opt = vim.opt

-- === Appearance ===
opt.number = true              -- show line numbers
opt.relativenumber = true      -- relative line numbers (easier to jump: 5j, 12k)
opt.cursorline = true          -- highlight current line
opt.signcolumn = "yes"         -- always show sign column (LSP, git) so text doesn't shift
opt.termguicolors = true       -- enable 24-bit colors (required by most colorschemes)
opt.scrolloff = 8              -- keep 8 lines visible above/below cursor
opt.sidescrolloff = 8          -- same but horizontally

-- === Indentation ===
opt.expandtab = true           -- use spaces instead of tabs
opt.tabstop = 4                -- a tab renders as 4 spaces
opt.shiftwidth = 4             -- >> and << shift by 4
opt.softtabstop = 4            -- backspace removes 4 spaces as one tab
opt.smartindent = true         -- smart auto-indenting in code
opt.breakindent = true         -- keep indent when wrapping long lines

-- === Search ===
opt.ignorecase = true          -- ignore case...
opt.smartcase = true           -- ...unless query contains uppercase
opt.hlsearch = true            -- highlight matches
opt.incsearch = true           -- show matches as you type

-- === Files / undo ===
opt.swapfile = false           -- no .swp files
opt.backup = false             -- no backup files
opt.undofile = true            -- persistent undo across sessions
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- === Editor behavior ===
opt.mouse = "a"                -- enable mouse in all modes
opt.clipboard = "unnamedplus"  -- use system clipboard for yank/paste
opt.splitright = true          -- vertical splits open to the right
opt.splitbelow = true          -- horizontal splits open below
opt.wrap = false               -- don't wrap long lines
opt.updatetime = 250           -- faster updates (CursorHold, diagnostics)
opt.timeoutlen = 400           -- how long to wait for a key sequence

-- === Completion ===
opt.completeopt = { "menu", "menuone", "noselect" }  -- nicer completion menu

-- === Misc ===
opt.showmode = false           -- don't show "-- INSERT --" (statusline plugin handles it)
opt.laststatus = 3             -- single global statusline instead of per-window

-- === Whitespace visualization ===
opt.list = true                -- show invisible characters
opt.listchars = {
  tab = "→ ",                  -- tab character
  trail = "·",                 -- trailing spaces
  extends = "›",               -- line extends beyond screen (when wrap=false)
  precedes = "‹",              -- line precedes screen
  nbsp = "␣",                  -- non-breaking space (often a hidden bug)
}