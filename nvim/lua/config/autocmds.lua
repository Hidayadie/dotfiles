-- ============================================================
-- Autocommands Configuration (lua/config/autocmds.lua)
-- General Neovim autocommands
-- ============================================================

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Fix double Enter / Backspace in Alacritty and modern terminals:
-- Neovim requests "Report event types" (flag 2 of Kitty keyboard protocol).
-- Alacritty sends key-release events that Neovim misinterprets as duplicate key presses.
-- \027[=0u resets/disables the progressive enhancement flags cleanly.
local function disable_kitty_keyboard()
  io.stdout:write '\027[=0u'
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'UIEnter', 'FocusGained' }, {
  group = vim.api.nvim_create_augroup('fix-terminal-key-repeat', { clear = true }),
  callback = function()
    disable_kitty_keyboard()
    -- Eksekusi tunda (100ms & 300ms) untuk mengantisipasi race-condition jika handshake TUI
    -- Neovim dengan Alacritty selesai beberapa milidetik setelah UIEnter.
    vim.defer_fn(disable_kitty_keyboard, 100)
    vim.defer_fn(disable_kitty_keyboard, 300)
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = 'fix-terminal-key-repeat',
  callback = function()
    io.stdout:write '\027[<u'
  end,
})
