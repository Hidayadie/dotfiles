-- ============================================================
-- Neovim Modular Configuration (Kickstart.nvim)
-- ============================================================

-- 0. Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- 1. Core Editor Configuration
require('config.options')      -- Leader key, tabstop, line numbers, clipboard, options
require('config.keymaps')      -- Keymaps dasar, window navigation, diagnostics
require('config.autocmds')     -- Autocommands dasar (highlight yank, dll)

-- 2. Plugin Manager & Build Hooks
require('plugins.pack')        -- Build hooks (fzf-native, luasnip, treesitter, avante)

-- 3. Plugin Modules
require('plugins.colorscheme') -- Gruvbox, Tokyonight, Everforest
require('plugins.ui')          -- guess-indent, todo-comments
require('plugins.which-key')   -- Popup bantuan keybinding
require('plugins.gitsigns')    -- Git signs gutter & hunk navigation
require('plugins.mini')        -- mini.nvim (icons, ai, surround, statusline)
require('plugins.telescope')   -- Fuzzy finder & LSP pickers
require('plugins.lsp')         -- Mason, LSPconfig, gopls, lua_ls, stylua
require('plugins.conform')     -- Auto-formatter (<leader>f)
require('plugins.completion')  -- blink.cmp & LuaSnip autocompletion
require('plugins.treesitter')  -- Treesitter syntax highlighting & parser
require('plugins.avante')      -- Avante AI coding assistant

-- 4. Optional Kickstart Plugins (Aktifkan jika dibutuhkan)
-- require('kickstart.plugins.autopairs')
-- require('kickstart.plugins.neo-tree')
-- require('kickstart.plugins.indent_line')
-- require('kickstart.plugins.lint')
-- require('kickstart.plugins.debug')

-- 5. Custom Plugins
-- Otomatis memuat file *.lua tambahan di direktori `lua/custom/plugins/`
require('custom.plugins')

-- vim: ts=2 sts=2 sw=2 et
