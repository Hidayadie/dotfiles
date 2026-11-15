-- ============================================================
-- Colorschemes Configuration (lua/plugins/colorscheme.lua)
-- Tokyonight, Everforest, Gruvbox
-- ============================================================

vim.pack.add {
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/sainnhe/everforest',
  'https://github.com/ellisonleao/gruvbox.nvim',
}

-- tokyonight setup
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}

-- everforest: opsi lewat variabel global, harus sebelum :colorscheme
vim.g.everforest_background = 'hard' -- 'soft' | 'medium' | 'hard'
vim.g.everforest_enable_italic = false
vim.g.everforest_better_performance = 1

-- gruvbox: opsi lewat setup()
---@diagnostic disable-next-line: missing-fields
require('gruvbox').setup {
  contrast = 'hard', -- '' | 'soft' | 'hard'
  italic = { comments = false },
  transparent_mode = true,
}

-- Pilihan tema:
-- 'tokyonight-night' | 'tokyonight-storm' | 'tokyonight-moon' | 'everforest' | 'gruvbox'
local theme = 'gruvbox'

if vim.env.TERM == 'linux' then
  vim.opt.termguicolors = false
  vim.cmd 'colorscheme habamax'
else
  vim.opt.termguicolors = true
  vim.o.background = 'dark'
  vim.cmd.colorscheme(theme)
end
