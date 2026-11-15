-- ============================================================
-- LSP Configuration (lua/plugins/lsp.lua)
-- Language Server Protocol, Mason, server configs & keymaps
-- ============================================================

-- Status updates for LSP in bottom right corner
vim.pack.add { 'https://github.com/j-hui/fidget.nvim' }
require('fidget').setup {}

-- Runs when an LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename variable under cursor
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Code actions (cursor on warning/error/suggestion)
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- Goto declaration (e.g. C header)
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Highlight references of word under cursor
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints if supported
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Configure Lua LSP for Neovim config, runtime, and plugins efficiently (lazy loading)
vim.pack.add { 'https://github.com/folke/lazydev.nvim' }
require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- Language servers configuration
---@type table<string, vim.lsp.Config>
local servers = {
  gopls = {},
  stylua = {},

  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        format = { enable = false },
        diagnostics = {
          disable = { 'missing-fields' },
        },
      },
    },
  },
}

vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}

-- Mason package manager for external language tools
require('mason').setup {}

require('mason-lspconfig').setup {
  automatic_enable = false,
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  -- Tambahkan tools lain yang ingin otomatis diinstall oleh Mason di sini
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- Aktifkan server yang telah didefinisikan
for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
