" show line numbers
set number 											

" enable mouse support
set mouse=a											

" enable 256 color mode
let base16colorspace=256		

" set colorscheme
try
    colorscheme base16-default-dark
catch
endtry

" allow system-wide clipboard
set clipboard=unnamedplus				

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Enable syntax highlighting
syntax enable

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup
set noswapfile

" Indentation
set autoindent 
set smartindent 

" Set 10 lines vertical scrolloff to the cursor 
set scrolloff=10

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <A-DOWN> mz:m+<cr>`z
nmap <A-UP> mz:m-2<cr>`z
vmap <A-DOWN> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-UP> :m'<-2<cr>`>my`<mzgv`yo`z

" Undo
set undodir=~/.vim/backup				" undofile dir
set undofile										" alows undo even after writing
set undoreload=10000						" 

" Tab key
set tabstop=2										" show tab as 2 char wide
set shiftwidth=2                " no. of spaces for step in autoindent
set softtabstop=2               " no. of spaces for tab when editing
set smarttab                    " smart tabulation and backspace

" Tabline
set showtabline=2								" always show top tab line

" NETRW
let g:netrw_banner = 0					" hide banner
let g:netrw_liststyle = 3				"	list files in tree mode
let g:netrw_browse_split = 3		" open file in new tab
let g:netrw_altv = 1						" open sidebar to the left
let g:netrw_winsize = 10				" size of the sidebar in %


" FUNCTIONS

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Toggle Netrw Sidebar
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

nnoremap <silent> <C-\> :call ToggleNetrw()<CR>		" toggle NETRW with Ctrl-\ (like script list in godot)

