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
set undoreload=10000				" 
set scrolloff=10            " scrolloff

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
  " Nvim Tree 
  Plug 'kyazdani42/nvim-tree.lua'
  " Built-in LSP
  Plug 'neovim/nvim-lspconfig'
  " cmp
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
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

" cmp
set completeopt=menuone,noselect

lua << END
local cmp = require'cmp'
local nvim_lsp = require'lspconfig'.pyright.setup {}

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

hi Pmenu ctermfg=250 ctermbg=235 guifg=#bcbcbc guibg=#262626

