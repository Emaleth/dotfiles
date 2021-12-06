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


" cmp snips
" For vsnip users.
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

" cmp
set completeopt=menu,menuone,noselect

lua << END
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
END

hi Pmenu ctermfg=250 ctermbg=235 guifg=#bcbcbc guibg=#262626
