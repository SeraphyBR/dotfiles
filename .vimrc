" ____    ____  __  .___  ___. .______        ______
" \   \  /   / |  | |   \/   | |   _  \      /      |
"  \   \/   /  |  | |  \  /  | |  |_)  |    |  ,----'
"   \      /   |  | |  |\/|  | |      /     |  |
" __ \    /    |  | |  |  |  | |  |\  \----.|  `----.
"(__) \__/     |__| |__|  |__| | _| `._____| \______|
"
"================================================================
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
Plug 'valloric/youcompleteme'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/colorizer'
Plug 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call plug#end()            " required

" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Airline status line:
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1

" General:

set mouse=n                " Enable mouse. see :help mouse for info. 
set number	           " Show line numbers
set relativenumber
set linebreak	           " Break lines at word (requires Wrap lines)
set showbreak=+++ 	   " Wrap-broken line prefix
set textwidth=110	   " Line wrap (number of cols)
set showmatch	           " Highlight matching brace
set visualbell	           " Use visual bell (no beeping)
set encoding=utf-8
set wildmenu
set wildmode=full

set hlsearch	           " Highlight all search results
set smartcase	           " Enable smart-case search
set ignorecase	           " Always case-insensitive
set incsearch	           " Searches for strings incrementally
 
set ve=all                 " Permite mover o cursor onde não há texto
set autoindent	           " Auto-indent new lines
set expandtab	           " Use spaces instead of tabs
set shiftwidth=4	   " Number of auto-indent spaces
set smartindent	           " Enable smart-indent
set smarttab	           " Enable smart-tabs
set softtabstop=4	   " Number of spaces per Tab
set clipboard=unnamedplus 
set shell=/bin/zsh
 
set background=dark
set termguicolors

"" Gruvbox Section:
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

"" Persistent Undo:
" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"" NERDtree Section: 
map <C-n> :NERDTreeToggle<CR>
"" Syntax
syntax on

"" General Shortcuts:

" Normal mode only:
nnoremap <C-h> :new <bar> :Startify <CR>  " Abre uma janela horizontalmente e abre um menu inicial
nnoremap <C-v> :vnew <bar> :Startify <CR> " Abre uma janela verticalmente e abre um menu inicial

"" Advanced:
set ruler	                " Show row and column ruler information
 
set undolevels=1000	        " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
  

"" AutoStart:
autocmd StdinReadPre * let s:std_in=1

