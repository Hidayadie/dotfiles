-- ============================================================
-- Options Configuration (lua/config/options.lua)
-- Core Neovim settings, leaders, and options
-- ============================================================

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o` and `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping:
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable persistent undo (even after closing and reopening a file)
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters in search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time (ms)
vim.o.updatetime = 250

-- Decrease mapped sequence wait time (ms)
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how Neovim displays whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
vim.o.inccommand = 'split'

-- Show which line cursor is on
vim.o.cursorline = true

-- Minimal screen lines to keep above/below the cursor
vim.o.scrolloff = 10

-- Raise dialog asking to save changes on operations that would fail
vim.o.confirm = true

-- Indentation settings (tabs & spaces)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
