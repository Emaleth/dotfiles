" ############################################################
"
" ███████╗███╗░░░███╗░█████╗░██╗░░░░░███████╗████████╗██╗░░██╗
" ██╔════╝████╗░████║██╔══██╗██║░░░░░██╔════╝╚══██╔══╝██║░░██║
" █████╗░░██╔████╔██║███████║██║░░░░░█████╗░░░░░██║░░░███████║
" ██╔══╝░░██║╚██╔╝██║██╔══██║██║░░░░░██╔══╝░░░░░██║░░░██╔══██║
" ███████╗██║░╚═╝░██║██║░░██║███████╗███████╗░░░██║░░░██║░░██║
" ╚══════╝╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝ 
"  
" ############################################################
" Slowly making Vim my own, for time being my be chaotic and 
" messy, will fix later. Maybe. Less plug-ins the better,
" ideally only plug-ins providing new and needed functionality
" (ok i given up on NERDTree and Lightline), like vimwiki 
" for example. Only acceptable exception are colorschemes 
" (sure...). Plugins are cloned directly from git, inside 
" '.vim/pack/plugins/start/[plugin_folder]'.
" ############################################################

" GENERAL ---------------------------------------------------------------- {{{

" Vi compatibility [R!]
set nocompatible

" encoding
set encoding=UTF-8

" detect filetypes
filetype on

" check spelling
set spell

" enable plugins
filetype plugin on

" load indentation files ???
filetype indent on

" syntax highlight
syntax on  

" line numbers
set number

" Enable horizontal highlight
set cursorline

" Disable vertical highlight
set nocursorcolumn

set expandtab
set smarttab
" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

set clipboard=unnamedplus       " Copy/paste between vim and other programs.
" Do not save backup files.
set writebackup
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
" set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Wildmenu
set wildmenu
set wildmode=list:longest
set laststatus=2
set noshowmode

" }}}


" COLORS ---------------------------------------------------------------- {{{

" Colorcheme 
colorscheme srcery

" }}}


" MAPPING ---------------------------------------------------------------- {{{


nnoremap <C-t> :NERDTreeToggle<CR>


" }}}


" PLUGINS ---------------------------------------------------------------- {{{

" <NERDTree>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:NERDTreeWinSize=20
let NERDTreeShowHidden=1
" <Lightline>
let g:lightline = {
      \ 'colorscheme': 'srcery',
      \ }

" <Coc>
 
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline nocursorcolumn
augroup END

" }}}
