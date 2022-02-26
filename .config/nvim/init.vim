" =============================================================================
" Section: Editor settings
" =============================================================================
set nocompatible
filetype plugin on
set background=dark
set encoding=utf-8
set noerrorbells
set visualbell
set cursorline
set hidden
syntax on
set linebreak
set shiftround
set number
set relativenumber
set nowrap
set hlsearch
set wildignore=*.o,*.obj,*.db-whl,*.db-shm,*node_modules*,*.venv*,tags,.*.un~,*.pyc
set list listchars=tab:>\ ,trail:·
set mouse=a
set showcmd

if $TERM != 'screen-256color'
  set termguicolors
end

" Command line typos
cabbrev fidn find
cabbrev greo grep
cabbrev vsf vert sfind
cabbrev %% %:p:h
" `cd current file`
cabbrev ccf cd %:p:h

if has("win32")
  set nocursorline
  set t_vb=
  if has("gui")
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11
    set guioptions-=T
    set t_vb=
  end
end

" =============================================================================
" Section: plugins
" =============================================================================
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-compe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'morhetz/gruvbox'
call plug#end()

colo gruvbox

" =============================================================================
" Section: netrw customization
" =============================================================================
" tree style list
let g:netrw_liststyle = 3
" suppress the banner
let g:netrw_banner = 0

" =============================================================================
" Section: slime customization
" =============================================================================
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" =============================================================================
"                        Language Server Configuration
" =============================================================================
" Copied from the suggestions in the nvim-lspconfig README:
" https://github.com/neovim/nvim-lspconfig
lua << EOF
local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  --commenting out while trying nvim-compe
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD',         '<CMD>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',         '<CMD>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',          '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi',         '<CMD>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>',      '<CMD>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D',  '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<CMD>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr',         '<CMD>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e',  '<CMD>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d',         '<CMD>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',         '<CMD>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q',  '<CMD>lua vim.diagnostic.set_loclist()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "bashls", "yamlls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end

-- python setup
lspconfig['pyright'].setup {
  cmd = { 'pyright-langserver', '--stdio' },
  on_attach = on_attach,
  filetypes = { 'python' },
  root_dir = lspconfig.util.root_pattern(
    'pyproject.toml',
    'setup.cfg',
    'setup.py',
    'requirements.txt',
    '.git',
    '.gitignore'
  ),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      },
      pythonPath = "python3"
    }
  },
  single_file_support = true,
}

-- gopls setup
-- Make sure that $GOPATH/bin is on $PATH after installing gopls for this to work
-- cd $HOME && mkdir -p tmp && cd tmp && go install golang.org/x/tools/gopls@latest
lspconfig["gopls"].setup { on_attach = on_attach, cmd = {'gopls', '--remote=auto'} }

-- julia setup
-- Make sure to run julia and from the package manager prompt:
-- ] add LanguageServer SymbolServer
lspconfig["julials"].setup {
  on_attach = on_attach,
  cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    "-e", [[
      using Pkg;
      Pkg.instantiate()
      using LanguageServer; using SymbolServer;
      depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
      project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
      # Make sure that we only load packages from this environment specifically.
      @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
      server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
      server.runlinter = true;
      run(server);
    ]]
  }
}

-- Uncomment to disable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- Uncomment to disable location list of diagnostics
-- lua vim.lsp.diagnostic.set_loclist({open_loclist = false})

EOF

" Format golang on save
augroup gofmt
  autocmd!
  autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
augroup END

" Uncomment to enable automatic opening of location list with LSP diagnostics
" augroup lsp_loclist
"   autocmd!
"   autocmd BufWrite,BufEnter,InsertLeave * :call LspLocationList()
" augroup END

" Diagnostics colors
" lua << EOF
" require("lsp-colors").setup {
"   Error = "#db4b4b",
"   Warning = "#e0af68",
"   Information = "#0db9d7",
"   Hint = "#10B981"
" }
" EOF

" =============================================================================
"                   Completion engine: nvim-compe
" =============================================================================
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


" =============================================================================
"                         TreeSitter Configuration
" =============================================================================
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "fish", "bash", "lua", "vim" },
  highlight = { enable = true },
  indent = { enable = true },
}
EOF
