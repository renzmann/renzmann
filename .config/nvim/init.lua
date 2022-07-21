-- Author: Robert A. Enzmann
-- License: Do anything you like.
--
-- Styled after LuaRocks: https://github.com/luarocks/lua-style-guide
-- Toggle the fold on any section using `za`

-- Editor settings {{{
require("renzmann.keymaps")
local o = vim.o
local g = vim.g

-- Set an environment variable that always points to the filestystem folder this init.lua
-- resides in. Useful for scripting or checking that my configuration is working correctly.
vim.env.MYVIMHOME = vim.fn.expand("<sfile>:p:h")

-- Highlight the line our cursor is on
o.cursorline = true

-- Use `{{{` to mark the beginning of a fold, and `}}}` to mark the end.  The combination of
-- both lines below cause nvim to automatically close folds within these markers, making it
-- much easier for me to navigate this file
o.foldmarker = "{{{,}}}"
o.foldmethod = "marker"

-- Allows us to temporarily "abandon" the current buffer, even if there are unsaved changes,
-- and hop to another buffer
o.hidden = true

-- Start highlighting matches as we type in searches with `/` and `?`
o.hlsearch = true

-- When wrapping lines, don't break in the middle of words
o.linebreak = true

-- Add lightly colored symbols that show things like trailing whitespace and whether leading
-- whitespace is a tab character
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- Turn on mouse support. This makes it possible to scroll and visual-select text with the
-- mouse. To disable it, which is useful for using Cmd-C on a mac, use `:set mouse=`
o.mouse = "a"

-- Turn on number lines
o.number = true
-- Relative line numbers make it much easier to use count-moves up and down. E.g. `13j` to get
-- exactly 13 lines down, since that's what the relative line number says
o.relativenumber = true

-- Set the minimum number of lines between the cursor line and the top/bottom of the screen
o.scrolloff = 2

-- When creating a new split, place it below or to the right of the current window
o.splitbelow = true
o.splitright = true

-- When indenting text via commands like `<`, `>`, CTRL-T, and CTRL-D, round to a multiple of
-- `shiftwidth`, which is usually set per filetype
o.shiftround = true

-- By default, let lines that are too long spill off to the right, don't soft-wrap them around
o.wrap = false
-- }}}

-- Packages {{{
-- TODO: one way we can structure this is a bunch of "requires", and pipe a
-- settings binding to telescope to go to a settings section.
require("packer").startup(function()
   -- packer can manage itself
   use("wbthomason/packer.nvim")

   -- Can't live without
   -- use "tpope/vim-surround"
   use({
      "kylechui/nvim-surround",
      config = function()
         require("nvim-surround").setup({})
      end,
   })
   use("tpope/vim-commentary")
   use("tpope/vim-fugitive")

   -- Wait until he finishes "only highlight after F is pressed"
   -- jinh0/eyeliner.nvim

   -- Autocomplete
   use({
      "williamboman/nvim-lsp-installer",
      config = function()
         require("nvim-lsp-installer").setup({})
      end,
   })

   use("neovim/nvim-lspconfig")
   use({
      "hrsh7th/nvim-cmp",
      requires = {
         { "hrsh7th/cmp-nvim-lsp" },
         { "hrsh7th/cmp-buffer" },
         { "hrsh7th/cmp-path" },
         { "hrsh7th/vim-vsnip" },
         { "hrsh7th/cmp-vsnip" },
      },
   })

   -- Colors
   use("romainl/Apprentice")
   use("EdenEast/nightfox.nvim")
   use("arcticicestudio/nord-vim")
   use("nvim-treesitter/nvim-treesitter")
   use("RRethy/vim-illuminate")
   use("norcalli/nvim-colorizer.lua")

   -- Status bar
   use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
   })

   -- Fuzzy-finding
   use({
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim" },
   })

   -- Extra languages
   use("JuliaEditorSupport/julia-vim")
   use({ "iamcco/markdown-preview.nvim", ft = "markdown" })
   use("habamax/vim-godot")
   use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })

   -- Project management
   use("airblade/vim-gitgutter")
   use("rhysd/git-messenger.vim")
   use("rbong/vim-flog")

   -- gutentags causes nvim to hang on exit
   -- use "ludovicchabant/vim-gutentags"
   --
   -- github.com/nginx/nginx/contrib/vim files could go to a packpath folder, if we want them
   --
   -- ? dhruvasagar/vim-table-mode
   -- ? junegunn/vim-easy-align
end)
-- }}}

-- Colors, Highlighting, and TreeSitter {{{
if vim.env.TMUX == nil then
   require("renzmann.colors")
elseif vim.fn.system("tmux -V") > "tmux 2.2" then
   -- FIXME this assumes that the currently running tmux is the same as what's on PATH... not
   -- sure if it will ever really become an issue, but in theory it could be.
   require("renzmann.colors")
else
   g.nord_italic = 1
   g.nord_bold = 1
   g.nord_italic_comments = 1
   vim.cmd("colorscheme nord")
end
-- }}}

-- Status line {{{
require("lualine").setup({
   options = {
      component_separators = { left = "", "" },
      section_separators = { left = "", right = "" },
   },
})
-- }}}

-- Auto-completion {{{
local cmp = require("cmp")

cmp.setup({
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

   mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
   }),

   sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
   }, {
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lua" },
   }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
   sources = cmp.config.sources({
      { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
   }, {
      { name = "buffer" },
   }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "buffer" },
   },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = "path" },
   }, {
      { name = "cmdline" },
   }),
})
-- }}}

-- LSP (Language Servers / Intellisense) {{{
-- Keep the gutter open all the time so it doesn't shutter back and forth when diagnostics
-- appear/disappear
vim.opt.signcolumn = "yes"

-- Main config starts here
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   local opts = { noremap = true, silent = true }

   -- The bindings here override very similar ones in base vim, and isn't a spot
   -- to add new bindings.  See the ./after/plugin/keymap.vim for those.
   buf_set_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
   buf_set_keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
   buf_set_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
   require("illuminate").on_attach(client)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
   "bashls",
   "yamlls",
   "rust_analyzer",
   "pyright",
   "omnisharp",
   "gdscript",
}

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
   })
end

-- gopls setup
-- Install notes below are from before I had the LSP installer plugin
--
-- > Make sure that $GOPATH/bin is on $PATH after installing gopls for this to work
-- > cd $HOME && mkdir -p tmp && cd tmp && go install golang.org/x/tools/gopls@latest
--
lspconfig.gopls.setup({
   on_attach = on_attach,
   cmd = { "gopls", "--remote=auto" },
   capabilities = capabilities,
})

-- julia setup
-- Install notes below are from before I had the LSP installer plugin
--
-- > Make sure to run julia and from the package manager prompt:
-- > ] add LanguageServer SymbolServer
--
lspconfig.julials.setup({
   cmd = {
      "julia",
      "--startup-file=no",
      "--history-file=no",
      "-e",
      [[
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
    ]],
   },
   capabilities = capabilities,
   on_attach = on_attach,
})

-- Uncomment to disable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- Uncomment to disable location list of diagnostics
-- vim.lsp.diagnostic.set_loclist({ open_loclist = false })
-- }}}
