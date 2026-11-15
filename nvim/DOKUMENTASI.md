dokumentasi ditulis oleh ai, klo bingung tanya langsung : @hytrin 

# Dokumentasi Konfigurasi Neovim Modular (Kickstart.nvim)

Selamat datang di konfigurasi Neovim Anda yang kini telah dirapikan ke dalam modul-modul kecil! 
Dokumentasi ini dibuat untuk membantu Anda memahami struktur file, cara kerja setiap modul, serta cara menambah atau mengubah konfigurasi di masa mendatang.

---

## 📁 Struktur Direktori & File

Konfigurasi Anda kini tersusun secara modular dan terpisah sesuai fungsinya di dalam folder `lua/`:

```text
~/.config/nvim/
├── init.lua                     # Titik masuk utama (entry point) Neovim
├── DOKUMENTASI.md               # Panduan lengkap struktur konfigurasi ini
├── nvim-pack-lock.json          # Lockfile dependensi plugin (vim.pack)
│
├── lua/
│   ├── config/                  # Pengaturan inti Neovim (tanpa plugin luar)
│   │   ├── options.lua          # Pengaturan opsi (tabstop, line number, clipboard, leader)
│   │   ├── keymaps.lua          # Pintasan tombol umum (navigasi window, escape, diagnostic)
│   │   └── autocmds.lua         # Event otomatisasi (misal: highlight saat copy/yank)
│   │
│   ├── plugins/                 # Modul-modul plugin utama
│   │   ├── pack.lua             # Hook otomatis pasca-install/update (build script)
│   │   ├── colorscheme.lua      # Tema editor (Gruvbox, Tokyonight, Everforest)
│   │   ├── ui.lua               # Utilitas UI (guess-indent, todo-comments)
│   │   ├── which-key.lua        # Menu popup petunjuk keybinding (<leader>)
│   │   ├── gitsigns.lua         # Indikator perubahan Git pada gutter & hunk actions
│   │   ├── mini.lua             # Modul mini.nvim (statusline, icons, surround, textobject)
│   │   ├── telescope.lua        # Fuzzy finder pencarian file, teks, & simbol
│   │   ├── lsp.lua              # LSP (Language Server Protocol), Mason, & lspconfig
│   │   ├── conform.lua          # Code formatter otomatis (<leader>f)
│   │   ├── completion.lua       # Autocompletion (blink.cmp) & snippet (LuaSnip)
│   │   ├── treesitter.lua       # Syntax highlighting cerdas berbasis AST
│   │   └── avante.lua           # Asisten AI coding (Avante.nvim)
│   │
│   ├── custom/
│   │   └── plugins/             # Folder khusus untuk plugin kustom tambahan Anda
│   │       └── init.lua         # Auto-loader: otomatis memuat file *.lua di folder ini
│   │
│   └── kickstart/
│       ├── health.lua           # Pemeriksaan kesehatan sistem (:checkhealth kickstart)
│       └── plugins/             # Plugin opsional bawaan kickstart (autopairs, neo-tree, dll)
│           ├── autopairs.lua
│           ├── neo-tree.lua
│           ├── indent_line.lua
│           ├── lint.lua
│           └── debug.lua
```

---

## 🚀 Alur Kerja `init.lua`

File `init.lua` di root direktori bertindak sebagai pengendali utama (orchestrator). Isinya sangat ringkas dan mudah dibaca:

1. **`vim.loader.enable()`**: Mengaktifkan bytecode cache bawaan Neovim agar startup super cepat.
2. **`require('config.*')`**: Memuat pengaturan editor, keymap dasar, dan autocommands sebelum plugin dimuat.
3. **`require('plugins.pack')`**: Memasang event listener `PackChanged` untuk menjalankan proses build (seperti `make`) secara otomatis saat plugin diinstall/diupdate.
4. **`require('plugins.*')`**: Memuat masing-masing modul plugin.
5. **`require('custom.plugins')`**: Memuat modul tambahan Anda secara otomatis.

---

## 🧩 Penjelasan Detail Setiap Modul

### 1. `lua/config/`
* **[options.lua](file:///home/trinsky/.config/nvim/lua/config/options.lua)**:
  * Menetapkan **Leader key** ke `<Space>` (`vim.g.mapleader = ' '`).
  * Konfigurasi tab & indentasi Anda: 2 spasi (`tabstop = 2`, `shiftwidth = 2`, `expandtab = true`).
  * Menyalakan nomor baris (`number = true`), clipboard sync dengan sistem operasi, pencarian case-insensitive pintar, dan persistent undo.
* **[keymaps.lua](file:///home/trinsky/.config/nvim/lua/config/keymaps.lua)**:
  * Tekan `<Esc>` di Normal mode untuk menghapus highlight hasil pencarian.
  * Navigasi antar split window lebih mudah dengan `Ctrl + h`, `Ctrl + j`, `Ctrl + k`, `Ctrl + l`.
  * Keluar dari terminal bawaan dengan cepat menggunakan `<Esc><Esc>`.
  * Konfigurasi floating window diagnostic (pesan error/warning kode).
* **[autocmds.lua](file:///home/trinsky/.config/nvim/lua/config/autocmds.lua)**:
  * Otomatis memberi efek highlight sesaat pada teks yang baru saja di-*yank* (di-copy).

### 2. `lua/plugins/`
* **[pack.lua](file:///home/trinsky/.config/nvim/lua/plugins/pack.lua)**:
  * Menggunakan autocommand `PackChanged` bawaan Neovim.
  * Menjalankan build script untuk: `telescope-fzf-native.nvim` (`make`), `LuaSnip` (`make install_jsregexp`), `nvim-treesitter` (`TSUpdate`), dan `avante.nvim` (`make`).
* **[colorscheme.lua](file:///home/trinsky/.config/nvim/lua/plugins/colorscheme.lua)**:
  * Berisi tema `gruvbox` (tema aktif saat ini), `tokyonight`, dan `everforest`.
  * Mendukung fallback otomatis ke `habamax` jika berada pada Linux TTY console tanpa truecolor.
* **[ui.lua](file:///home/trinsky/.config/nvim/lua/plugins/ui.lua)**:
  * `guess-indent.nvim`: Otomatis mendeteksi lebar indentasi (2/4 spasi atau tab) sesuai file yang dibuka.
  * `todo-comments.nvim`: Memberi warna khusus pada komentar seperti `TODO:`, `NOTE:`, `FIX:`, `WARN:`.
* **[which-key.lua](file:///home/trinsky/.config/nvim/lua/plugins/which-key.lua)**:
  * Saat Anda menekan `<Space>`, popup interaktif akan muncul menampilkan opsi tombol yang tersedia.
* **[gitsigns.lua](file:///home/trinsky/.config/nvim/lua/plugins/gitsigns.lua)**:
  * Menampilkan tanda baris baru/diubah/dihapus pada kolom sebelah kiri (gutter).
  * Navigasi perubahan kode dengan `]c` (next change) dan `[c` (prev change).
  * Preview atau staging per potongan perubahan (*hunk*).
* **[mini.lua](file:///home/trinsky/.config/nvim/lua/plugins/mini.lua)**:
  * Kumpulan modul ringan:
    * `mini.statusline`: Bar status minimalis di bagian bawah.
    * `mini.surround`: Menambah/mengubah/menghapus tanda kurung atau tanda kutip di sekeliling teks.
    * `mini.ai`: Pemilihan textobject yang lebih cerdas (misal: `va)` atau `ci'`).
    * `mini.icons`: Ikon visual untuk file dan ekstensi.
* **[telescope.lua](file:///home/trinsky/.config/nvim/lua/plugins/telescope.lua)**:
  * Pencarian fuzzy cepat:
    * `<leader>sf` : Cari nama file.
    * `<leader>sg` : Live grep (cari isi teks di seluruh folder proyek).
    * `<leader>sh` : Cari dokumentasi `:help`.
    * `<leader><leader>` : Cari tab/buffer yang sedang terbuka.
    * `<leader>/` : Fuzzy search di dalam file yang sedang aktif.
* **[lsp.lua](file:///home/trinsky/.config/nvim/lua/plugins/lsp.lua)**:
  * Pengaturan LSP via `nvim-lspconfig` dan installer `mason.nvim`.
  * Server aktif: `gopls` (Go), `lua_ls` (Lua), `stylua`.
  * Memasang keymap standar LSP: `grn` (rename variabel), `gra` (code action), `grd` (go to definition), `grr` (references).
* **[conform.lua](file:///home/trinsky/.config/nvim/lua/plugins/conform.lua)**:
  * Formatter kode otomatis. Tekan `<leader>f` untuk merapikan kode buffer saat ini secara manual.
* **[completion.lua](file:///home/trinsky/.config/nvim/lua/plugins/completion.lua)**:
  * `blink.cmp`: Mesin autocomplete modern dan sangat cepat.
  * `LuaSnip`: Mesin ekspansi template kode/snippet.
* **[treesitter.lua](file:///home/trinsky/.config/nvim/lua/plugins/treesitter.lua)**:
  * Syntax highlighting akurat berbasis pohon sintaksis bahasa pemrograman.
  * Otomatis mengunduh parser jika membuka bahasa baru.
* **[avante.lua](file:///home/trinsky/.config/nvim/lua/plugins/avante.lua)**:
  * AI pair-programmer yang dikonfigurasikan dengan provider OpenRouter dan Gemini.

---

## 🛠️ Manajemen Plugin (`vim.pack`)

Neovim v0.12+ memiliki plugin manager bawaan bernama **`vim.pack`**. Anda tidak lagi membutuhkan tool eksternal seperti packer atau vim-plug:

* **Melihat status dan plugin yang butuh update**:
  ```vim
  :lua vim.pack.update(nil, { offline = true })
  ```
* **Memperbarui seluruh plugin**:
  ```vim
  :lua vim.pack.update()
  ```
* **Menginstal package/tool LSP baru via Mason**:
  ```vim
  :Mason
  ```

---

## ➕ Cara Menambahkan Fitur / Plugin Baru

### Cara 1: Menggunakan Folder `lua/custom/plugins/` (Paling Praktis)
Cukup buat file Lua baru di dalam `lua/custom/plugins/<nama_plugin>.lua`.
Contoh, jika Anda ingin menambahkan plugin auto-tag:
```lua
-- File: ~/.config/nvim/lua/custom/plugins/autotag.lua
vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup()
```
File ini akan **otomatis dimuat** saat Neovim dinyalakan tanpa perlu Anda daftarkan manual di `init.lua`!

### Cara 2: Membuat Modul Sendiri di `lua/plugins/`
1. Buat file baru, misalnya `lua/plugins/harpoon.lua`.
2. Tulis instalasi dan konfigurasinya.
3. Buka `init.lua`, lalu tambahkan satu baris:
   ```lua
   require('plugins.harpoon')
   ```

### Mengaktifkan Modul Tambahan Kickstart
Di dalam folder `lua/kickstart/plugins/` sudah tersedia beberapa plugin opsional siap pakai:
* `autopairs.lua` : Menutup tanda kurung otomatis `(` -> `()`.
* `neo-tree.lua`  : File explorer sidebar (shortcut: `\`).
* `indent_line.lua`: Garis pemandu indentasi vertikal.
* `lint.lua`       : Pemeriksa kode (linter).
* `debug.lua`      : Debugger DAP (F5 untuk start).

Untuk mengaktifkannya, cukup buka **[init.lua](file:///home/trinsky/.config/nvim/init.lua)** dan hilangkan tanda komentar `--` pada baris yang diinginkan:
```lua
require('kickstart.plugins.autopairs')
require('kickstart.plugins.neo-tree')
```

---

## ⌨️ Daftar Pintasan Tombol (Cheat Sheet)

| Pintasan | Deskripsi |
| :--- | :--- |
| `<Space>` | **Leader Key** |
| `<Esc>` | Menghilangkan highlight pencarian |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Pindah fokus jendela (kiri/bawah/atas/kanan) |
| `<leader>sf` | Cari file proyek (Telescope) |
| `<leader>sg` | Cari teks di semua file proyek (Live Grep) |
| `<leader>sh` | Cari help Neovim |
| `<leader><leader>` | Pilih buffer yang terbuka |
| `<leader>f` | Format buffer saat ini (Conform) |
| `grn` | Rename variabel / simbol (LSP) |
| `gra` | Code Action / Quick Fix (LSP) |
| `grd` | Lompat ke definisi fungsi/variabel |
| `grr` | Cari semua referensi fungsi/variabel |
| `gO` | Buka outline daftar simbol dalam file |
| `]c` / `[c` | Lompat ke perubahan git berikutnya / sebelumnya |
| `<leader>hs` / `<leader>hr` | Stage / Reset git hunk |
| `<leader>tb` | Toggle git blame pada baris kursor |
| `<leader>th` | Toggle Inlay Hints (jika didukung LSP) |
| `saiw)` | Tambahkan tanda kurung pada kata di kursor (*mini.surround*) |
| `sd'` | Hapus tanda kutip di sekeliling kursor (*mini.surround*) |
| `sr)'` | Ganti tanda kurung `)` menjadi kutip `'` (*mini.surround*) |

---

> [!TIP]
> Jika sewaktu-waktu Anda ingin memeriksa kondisi instalasi dan dependensi sistem, jalankan perintah `:checkhealth` atau `:checkhealth kickstart` di Neovim.
