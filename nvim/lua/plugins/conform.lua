-- ============================================================
-- Formatter Configuration (lua/plugins/conform.lua)
-- Autoformatting via conform.nvim
-- ============================================================

vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Tentukan filetype yang ingin otomatis diformat saat save:
    local enabled_filetypes = {
      -- lua = true,
      -- python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Format pakai external formatter jika ada, fallback ke LSP
  },
  formatters_by_ft = {
    -- rust = { 'rustfmt' },
    -- python = { "isort", "black" },
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
}

-- Shortcut format manual: <leader>f
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
