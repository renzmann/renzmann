autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'cespare/vim-toml'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-compe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'morhetz/gruvbox'
Plug 'williamboman/nvim-lsp-installer'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jpalardy/vim-slime'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
call plug#end()
