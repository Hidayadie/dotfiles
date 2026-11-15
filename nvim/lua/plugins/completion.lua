-- ============================================================
-- Autocompletion & Snippets (lua/plugins/completion.lua)
-- blink.cmp and LuaSnip
-- ============================================================

-- Snippet engine: LuaSnip
vim.pack.add { { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Autocomplete engine: blink.cmp
vim.pack.add { { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' } }

require('blink.cmp').setup {
  keymap = {
    -- Preset 'default': <c-y> to accept, <c-space> to open menu, <c-n>/<c-p> next/prev
    -- <tab>/<s-tab> untuk navigasi ekspansi snippet
    preset = 'default',
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    -- Tekan <c-space> untuk melihat dokumentasi
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },

  snippets = { preset = 'luasnip' },

  fuzzy = { implementation = 'lua' },

  signature = { enabled = true },
}
