-- ============================================================
-- Avante AI Assistant Configuration (lua/plugins/avante.lua)
-- AI pair-programming assistant and its dependencies
-- ============================================================

vim.pack.add {
  {
    src = 'https://github.com/yetone/avante.nvim',
    version = 'main',
  },

  -- Core dependencies
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/ColinKennedy/mega.logging',
  'https://github.com/ColinKennedy/mega.cmdparse',

  -- Optional dependencies
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/HakonHarnes/img-clip.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/folke/snacks.nvim',
}

require('avante').setup {
  provider = 'openrouter',
  providers = {
    openrouter = {
      __inherited_from = 'openai',
      endpoint = 'https://openrouter.ai/api/v1',
      api_key_name = 'OPENROUTER_API_KEY',
      model = 'openrouter/free',
    },
    gemini = {
      model = 'gemini-flash-latest',
    },
  },
}
