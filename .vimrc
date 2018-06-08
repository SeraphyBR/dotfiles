
" Sessão Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'chrisbra/colorizer'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ


" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Airline status line
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


" General

set mouse=n                " Enable mouse. see :help mouse for info. 
set number	           " Show line numbers
set relativenumber
set linebreak	           " Break lines at word (requires Wrap lines)
set showbreak=+++ 	   " Wrap-broken line prefix
set textwidth=100	   " Line wrap (number of cols)
set showmatch	           " Highlight matching brace
set visualbell	           " Use visual bell (no beeping)
set encoding=utf8

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

set shell=/bin/zsh
 
set background=dark
set termguicolors
colorscheme material-monokai
"" Persistent Undo
" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"" NERDtree Section ""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

"" Syntax
syntax on

"" Advanced
set ruler	                " Show row and column ruler information
 
set undolevels=1000	        " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
  
"" AutoStart Commands : 

"" Color HightLight by colorizer plugin:
autocmd VimEnter * ColorHighlight 






