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
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on          " 
set ttyfast                 " Speed up scrolling in Vim
set noswapfile              " disable creating swap file
set nobackup                " disable backup file
set nowritebackup           " disable backup writing
set undodir=~/.vim/backup		" undofile dir
set undofile								" alows undo even after writing
set undoreload=10000				" 10k undo limit
set scrolloff=10            " set scrolloff limit as 10 lines
let &fcs='eob: '            " hide ~ at the end of the buffer


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
  " mkdir on sava
  Plug 'jghauser/mkdir.nvim'
  " dashboard
  Plug 'glepnir/dashboard-nvim'
  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Nvim Tree 
  Plug 'kyazdani42/nvim-tree.lua'
  " Built-in LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  " cmp
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " TreeSitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  " ayu colorscheme
  Plug 'Shatur/neovim-ayu'

call plug#end()


" PLUGINS CONFIG
" Lualine
lua << END
require'lualine'.setup {}
END

" Bufferline
set termguicolors
lua << END
require("bufferline").setup{}
END

" colorscheme
colorscheme ayu

" Dashboard
let g:dashboard_default_executive ='fzf'

" Nvim Tree
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_quit_on_open = 1
lua << END
require'nvim-tree'.setup {}
END

" Built-in LSP

" cmp
set completeopt=menuone,noselect

lua << END
local cmp = require'cmp'
local nvim_lsp = require'lspconfig'.pyright.setup {}
local nvim_lsp = require'lspconfig'.sumneko_lua.setup {}
local nvim_lsp = require'lspconfig'.cssls.setup {}
local nvim_lsp = require'lspconfig'.html.setup {}
local nvim_lsp = require'lspconfig'.jsonls.setup {}

cmp.setup({
    sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
    },
    mapping = {
        ["<cr>"] = cmp.mapping.confirm({select = true}),
        ["<s-tab>"] = cmp.mapping.select_prev_item(),
        ["<tab>"] = cmp.mapping.select_next_item(),
    },
    formatting = {
        format = function(entry, item)
            item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
            })[entry.source.name]

            return item
        end,
    },
})
END

" may not be neccesay with different themes
hi Pmenu ctermfg=250 ctermbg=235 guifg=#bcbcbc guibg=#262626 

" treesitter Config
lua <<END
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"css", "gdscript" }, -- "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}
END
