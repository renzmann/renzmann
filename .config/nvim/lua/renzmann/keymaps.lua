-------------------------------------------------------------------------------
--                             Keyboard Shortcuts
-------------------------------------------------------------------------------
-- Search for [<letter> to see what's mapped under <leader><letter>.
-- e.g. /[s will take you to the settings navigation section.

-- Function closures for easier reading
local function silent_mode(mode, lhs, rhs)
   return vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local function silent_normal(lhs, rhs) return silent_mode("n", lhs, rhs) end
local function silent_insert(lhs, rhs) return silent_mode("i", lhs, rhs) end
local function silent_operator(lhs, rhs) return silent_mode("o", lhs, rhs) end
local config = vim.fn.stdpath("config")

-- Faster scrolling
silent_normal("<C-e>", "2<C-e>")
silent_normal("<C-y>", "2<C-y>")

-- Make spacebar the Leader key
vim.g.mapleader = " "
silent_normal("<Space>", "<Nop>")

-- Unset accidental sleep
silent_normal("gs", "<Nop>")

-- Case-insensitive search
silent_normal("<Leader>/", [[/\c<Left><Left>]])

-- Make `cgn` operate on the currently selected word
-- https://vi.stackexchange.com/a/18895
silent_normal("cgn", [[:<C-u>let @/=expand('<cword>')<cr>cgn]])

-- Capitalize last word while inserting text
silent_insert("<C-j>", "<Esc>gUiwea")


-- [s]ettings navigation
-------------------------------------------------------------------------
silent_normal("<Leader>si", "<Cmd>edit $MYVIMRC<CR>")
silent_normal("<Leader>sk", "<Cmd>edit "..config.."/lua/renzmann/keymaps.lua<CR>")
silent_normal("<Leader>sp", "<Cmd>edit "..config.."/after/plugin<CR>")
silent_normal("<Leader>sf", "<Cmd>edit "..config.."/after/ftplugin<CR>")

-- Markdown and RST headers [1] [2] [3] [4]
-------------------------------------------------------------------------
silent_normal("<Leader>1", "yypVr=")
silent_normal("<Leader>2", "yypVr-")
silent_normal("<Leader>3", "yypVr+")
silent_normal("<Leader>4", "yypVr*")
silent_operator("ih", [[:<C-U>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>]])

-- Tab movement [h] [l]
-------------------------------------------------------------------------
silent_normal("<Leader>h", ":<C-u>bprevious<CR>")
silent_normal("<Leader>l", ":<C-u>bnext<CR>")
silent_normal("<Leader>H", ":<C-u>tabprevious<CR>")
silent_normal("<Leader>L", ":<C-u>tabnext<CR>")

-- [c]lipboard [c]ommands
-------------------------------------------------------------------------
silent_normal("<Leader>cv", '"+p')
silent_normal("<Leader>cv", '"+p')
silent_normal("<Leader>cc", '"+y')

-- [f]ind things
-------------------------------------------------------------------------
silent_normal("<Leader>ff", ":Telescope find_files<CR>")
silent_normal("<Leader>fb", ":Telescope buffers<CR>")
silent_normal("<Leader>fg", ":Telescope git_files<CR>")
silent_normal("<Leader>ft", ":Telescope tags<CR>")
silent_normal("<Leader>fr", ":Telescope live_grep<CR>")
silent_normal("<Leader>fh", ":Telescope help_tags<CR>")
silent_normal("<Leader>fq", ":Telescope quickfix<CR>")
silent_normal("<Leader>fc", ":Telescope command_history<CR>")
silent_normal("<Leader>fo", ":Telescope oldfiles<CR>")
silent_normal("<Leader>fa", ":<C-u>e ~/.aws/credentials<CR>")

-- Language server bindings
-------------------------------------------------------------------------
silent_normal("<C-s>", "<ESC>l:lua vim.lsp.buf.signature_help()<CR>i")
silent_normal("<Leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>")
silent_normal("<Leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>")
silent_normal("<Leader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
-- [r]ename
silent_normal("<Leader>rn", ":lua vim.lsp.buf.rename()<CR>")
-- [g]o references
-- nnoremap <silent><Leader>gr  :lua vim.lsp.buf.references()<CR>
silent_normal("<Leader>gr", ":Telescope lsp_references<CR>")
silent_normal("<Leader>gs", ":Telescope lsp_document_symbols<CR>")
-- [d]iagnostics
silent_normal("<Leader>de", ":lua vim.diagnostic.open_float()<CR>")
silent_normal("<Leader>dn", ":lua vim.diagnostic.goto_next()<CR>")
silent_normal("<Leader>dp", ":lua vim.diagnostic.goto_prev()<CR>")
silent_normal("<Leader>dq", ":lua vim.diagnostic.setqflist()<CR>")

-- e[x]tra
-------------------------------------------------------------------------
-- nnoremap <silent><Leader>xm    :<C-u>GitMessenger<CR>
silent_normal("<Leader>xm", "<Plug>(git-messenger)")
