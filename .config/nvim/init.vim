" Config targets nvim 0.6

" BASE NVIM CONFIG
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set noswapfile              " disable creating swap file
set nobackup                " disable backup file
set nowritebackup           " disable backup writing
set undodir=~/.vim/backup				" undofile dir
set undofile										" alows undo even after writing
set undoreload=10000						" 
set scrolloff=10                " scrolloff


" CUSTOM KEYMAPPING
" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nnoremap <C-Bslash> <cmd>NvimTreeToggle<cr>


" PLUGINS
call plug#begin('~/.vim/plugged')
  " bufferline
  Plug 'akinsho/bufferline.nvim'
  " lualine
  Plug 'nvim-lualine/lualine.nvim'
  " devicons for buffer line
  Plug 'kyazdani42/nvim-web-devicons'
  " scrollbar
  Plug 'Xuyuanp/scrollbar.nvim'
  " mkdir on sava
  Plug 'jghauser/mkdir.nvim'
  " dashboard
  Plug 'glepnir/dashboard-nvim'
  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Nvim Tree (until chadtree gets fixed???)
  Plug 'kyazdani42/nvim-tree.lua'
  " Built-in LSP
  Plug 'neovim/nvim-lspconfig'
  " coq base
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  " coq snippets
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  " coq third party sources 
  Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
call plug#end()

" PLUGINS CONFIG
" ScrollBar
augroup ScrollbarInit
  autocmd!
  autocmd WinScrolled,VimResized,QuitPre              * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained                        * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost     * silent! lua require('scrollbar').clear()
augroup end

" Lualine
lua << END
require'lualine'.setup()
END

" Bufferline
set termguicolors
lua << END
require("bufferline").setup{}
END

" Dashboard
let g:dashboard_default_executive ='fzf'

" Nvim Tree
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_quit_on_open = 1
lua << END
require'nvim-tree'.setup {}
END

" Built-in LSP
lua << END
local nvim_lsp = require('lspconfig')
local coq = require "coq" -- add this
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 
    'pyright' 
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup{coq.lsp_ensure_capabilities{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }}
end
END

" coq config
let g:coq_settings = { 'auto_start': 'shut-up' }

" coq third party
lua << END
require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
  { src = "vimtex", short_name = "vTEX" },
  { src = "copilot", short_name = "COP", tmp_accept_key = "<c-r>" },
  { src = "bc", short_name = "MATH", precision = 6 }
}
END
