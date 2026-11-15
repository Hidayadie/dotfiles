-- ============================================================
-- Mini.nvim Configuration (lua/plugins/mini.lua)
-- Collection of small independent plugins/modules
-- ============================================================

vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Backwards compatibility with plugins requiring nvim-web-devicons
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects (e.g. va), yiiq, ci')
require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- saiw), sd', sr)'
require('mini.surround').setup()

-- Minimal statusline
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
