-- Author: Robert A. Enzmann
-- License: Do anything you like.
--
-- Styled after LuaRocks: https://github.com/luarocks/lua-style-guide

-- Editor settings {{{
require("keymaps")
vim.o.hidden = true
vim.o.linebreak = true
vim.o.wrap = false
vim.o.shiftround = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.encoding = "utf-8"
vim.o.hlsearch = true
vim.o.mouse = "a"
vim.o.foldmethod = "marker"
vim.o.foldmarker = "{{{,}}}"

if vim.fn.has("termguicolors")
then
   vim.o.termguicolors = true
end
-- }}}

-- Packages {{{
require("packer").startup(function()
   -- Can't live without
   use "tpope/vim-surround"
   use "tpope/vim-commentary"
   use "tpope/vim-fugitive"

   -- Autocomplete
   use "williamboman/nvim-lsp-installer"
   use "neovim/nvim-lspconfig"
   use {
      "hrsh7th/nvim-cmp",
      requires = {
         { "hrsh7th/cmp-nvim-lsp" },
         { "hrsh7th/cmp-buffer" },
         { "hrsh7th/cmp-path" },
         { "hrsh7th/vim-vsnip" },
         { "hrsh7th/cmp-vsnip" },
      }
   }

   -- Colors
   use "EdenEast/nightfox.nvim"
   use "nvim-treesitter/nvim-treesitter"
   use "RRethy/vim-illuminate"
   use "norcalli/nvim-colorizer.lua"

   -- Status bar
   use "vim-airline/vim-airline"
   use "vim-airline/vim-airline-themes"

   -- Fuzzy-finding
   use {
      "nvim-telescope/telescope.nvim",
      requires = {
         { "nvim-lua/plenary.nvim" },
      }
   }

   -- Extra languages
   use { "JuliaEditorSupport/julia-vim", optional = true}

   -- Project management
   use "airblade/vim-rooter"
   use "airblade/vim-gitgutter"

   -- TODO
   -- gutentags causes nvim to hang on exit
   -- use "ludovicchabant/vim-gutentags"
   -- github.com/nginx/nginx/contrib/vim files could go to a packpath folder, if we want them
   -- replicate tpope vim-sensible in both ~/.vim/vimrc and here
   -- ? dhruvasagar/vim-table-mode
   -- ? junegunn/vim-easy-align
   -- use "rbong/vim-flog"
   -- use "rhysd/git-messenger.vim"
end)
-- }}}

-- Set Neovim color theme {{{
vim.g.airline_theme = "base16_nord"

require("nightfox").setup {
   options = {
      styles = {
         comments = "italic",
         functions = "italic,bold",
      }
   },
}

vim.cmd("colorscheme nordfox")
-- }}}

-- Auto-completion {{{
local cmp = require("cmp")

cmp.setup {
   snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
   },

   -- window = {
   --   completion = cmp.config.window.bordered(),
   --   documentation = cmp.config.window.bordered(),
   -- },

   mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      -- Wonky ass error when doing TAB inside python function
      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif vim.fn["vsnip#available"](1) == 1 then
      --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
      --   elseif has_words_before() then
      --     cmp.complete()
      --   else
      --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      --   end
      -- end, { "i", "s" }),

      -- ["<S-Tab>"] = cmp.mapping(function()
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      --     feedkey("<Plug>(vsnip-jump-prev)", "")
      --   end
      -- end, { "i", "s" }),
   },

   sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
   }, {
      { name = 'buffer' },
   }
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
   sources = cmp.config.sources({
   { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
   }, {
   { name = 'buffer' },
   })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = 'buffer' }
   }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = 'path' }
   }, {
      { name = 'cmdline' }
   })
})
-- }}}

-- LSP (Language Servers) {{{
-- Keep the gutter open all the time so it doesn't shutter back and forth when diagnostics
-- appear/disappear
vim.opt.signcolumn = "yes"

-- Adds ability to install LSP servers as we need them
require("nvim-lsp-installer").setup({})

-- Main config starts here
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- The bindings here override very similar ones in base vim, and isn't a spot
  -- to add new bindings.  See the ./after/plugin/keymap.vim for those.
  buf_set_keymap('n', 'gD', '<CMD>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<CMD>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'K',  '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
  require("illuminate").on_attach(client)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  "bashls",
  "yamlls",
  "rust_analyzer",
  "pyright",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
     on_attach = on_attach,
     capabilities = capabilities
  }
end

-- gopls setup
-- Make sure that $GOPATH/bin is on $PATH after installing gopls for this to work
-- cd $HOME && mkdir -p tmp && cd tmp && go install golang.org/x/tools/gopls@latest
lspconfig.gopls.setup {
   on_attach = on_attach,
   cmd = {'gopls', '--remote=auto'},
   capabilities = capabilities
}

-- julia setup
-- Make sure to run julia and from the package manager prompt:
-- ] add LanguageServer SymbolServer
lspconfig.julials.setup {
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
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Uncomment to disable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- Uncomment to disable location list of diagnostics
-- vim.lsp.diagnostic.set_loclist({ open_loclist = false })
-- }}}

-- Colorizer {{{
require("colorizer").setup {
   "python";
   "markdown";
   "css";
   "javascript";
   "vim";
   "lua";
   html = {
      mode = "foreground";
   }
}

-- Treesitter {{{
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },
  highlight = {
    enable = true,
  },
})
-- }}}
