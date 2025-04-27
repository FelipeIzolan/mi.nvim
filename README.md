# 📝 mi.nvim

minimal neovim configuration concentrated in a single file.

## 📋 Pre-requisites
- [Neovim 0.11+](https://neovim.io/)
- [Nerd Font](https://www.nerdfonts.com/)
- GCC, Windows users must have [mingw](https://scoop.sh/#/apps?q=mingw&id=965b35870a2cbc6584a302ef1721c7f18faaef24) installed.
- Make, Windows users must have [make](https://scoop.sh/#/apps?q=make&id=c43ff861c0f1713336e5304d85334a29ffb86317) installed.

> [!IMPORTANT]
> I recommend using [scoop](https://scoop.sh/) (a command-line installer for Windows) to install GCC and Make;

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
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet Engine
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippets Collection
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion Engine
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - CMP Buffer Source
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - CMP Path Source
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - CMP Nvim LSP Source
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - CMP LuaSnip Source
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git Integration
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) - Formatter

## ⌨️ Mappings

- **\<Leader\> + q** - Quit.
- **\<Leader\> + r** - Open Terminal.
- **\<Leader\> + c** - Comment or uncomment line or block.
- **\<Leader\> + t** - Open or focus file explorer.
- **\<Leader\> + T** - Close file explorer.
- **\<C\> + w** - Move selected block up.
- **\<C\> + s** - Move selected block down.

**nvim-cmp**

- **\<Tab\>** - Select next item.
- **\<S-Tab\>** - Select previous item.
- **\<CR\>** - Confirm.

**nvim-tree**

- **\<CR\>** - Change directory or open file.
- **+ Default mappings** - https://github.com/nvim-tree/nvim-tree.lua

> [!NOTE]
> **\<C\>** is Ctrl;\
> **\<S\>** is Shift;\
> **\<CR\>** is Enter;\
> **\<Leader\>** is Spacebar;
