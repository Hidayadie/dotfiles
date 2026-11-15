-- ============================================================
-- UI & Editor Utilities (lua/plugins/ui.lua)
-- todo-comments (guess-indent dinonaktifkan)
-- ============================================================

-- Automatically detect and set indentation (tabs/spaces) - DINONAKTIFKAN
-- vim.pack.add { 'https://github.com/NMAC427/guess-indent.nvim' }
-- require('guess-indent').setup {}

-- Highlight TODO, NOTE, FIX, WARN, etc. in code comments
vim.pack.add { 'https://github.com/folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }
