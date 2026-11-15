-- ============================================================
-- Treesitter Configuration (lua/plugins/treesitter.lua)
-- Syntax highlighting, parsing, and indentation
-- ============================================================

vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }

-- Parser dasar yang dipastikan terpasang
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- Periksa parser dan muat
  if not vim.treesitter.language.add(language) then return end

  -- Pastikan buffer valid
  if not vim.api.nvim_buf_is_valid(buf) then return end

  -- Aktifkan syntax highlighting berbasis Treesitter
  vim.treesitter.start(buf, language)

  -- Indentasi otomatis jika query tersedia untuk bahasa tsb
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      -- Aktifkan parser jika sudah terpasang
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- Auto-install parser jika tersedia lalu pasang
      require('nvim-treesitter').install(language):await(function()
        treesitter_try_attach(buf, language)
      end)
    else
      -- Coba attach jika parser ada di runtime path lain
      treesitter_try_attach(buf, language)
    end
  end,
})
