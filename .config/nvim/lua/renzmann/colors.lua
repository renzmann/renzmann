vim.o.termguicolors = true
vim.g.airline_theme = "base16_nord"

require("nightfox").setup {
   options = {
      styles = {
         comments = "italic",
         functions = "italic,bold",
      }
   },
}

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

require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "lua", "rust", "python" },
  highlight = {
    enable = true,
  },
}

vim.cmd("colorscheme nordfox")
