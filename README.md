# 📝 mi.nvim

![image](https://github.com/user-attachments/assets/e903c80c-5f26-4024-9ed3-1b1e17850f32)

## 📌 Requirements
- Git
- Neovim
- Nerd Font
- Python3
  - ```pip install neovim```

## 📦 Install


### Linux
```
mkdir ~/.config/nvim
```
```
curl https://raw.githubusercontent.com/FelipeIzolan/mi.nvim/refs/heads/main/init.lua -o ~/.config/nvim/init.lua
```

### Windows 10/11 (PowerShell)
```
mkdir $ENV:USERPROFILE\AppData\Local\nvim
```
```
curl https://raw.githubusercontent.com/FelipeIzolan/mi.nvim/refs/heads/main/init.lua -o $ENV:USERPROFILE\AppData\Local\nvim\init.lua
```

## 🧩 Plugins

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin Manager
- [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - Colorscheme
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Nvim LSP Config
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Nvim Package Manager
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Mason Extension for LSP Config
- [b0o/schemastore.nvim](https://github.com/b0o/SchemaStore.nvim) - Schemastore
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - Nerd Font Icons
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File Explorer
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax Highlighting
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion Engine
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - CMP Buffer Source
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - CMP Nvim LSP Source
- [quangnguyen30192/cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips) - CMP Ultisnips Source
- [SirVer/ultisnips](https://github.com/SirVer/ultisnips) - Snippets Engine
- [honza/vim-snippets](https://github.com/honza/vim-snippets) - Snippets
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git Integration

## 💾 Mappings

- **Leader + q** - Quit.
- **Leader + w** - Open terminal.
- **Leader + d** - Toggle diagnostics.
- **Leader + c** - Comment or uncomment line or block.
- **Leader + t** - Open or focus file explorer.
- **Leader + T** - Close file explorer.
- **CTRL + w** - Move selected block up.
- **CTRL + s** - Move selected block down.

### nvim-cmp

- **Tab** - Select next item.
- **Shift + Tab** - Select prev item.
- **Return** - Confirm.
- **CTRL + up** - expand or jump forwards (snippet).
