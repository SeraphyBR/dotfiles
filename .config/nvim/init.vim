"=================================================================
"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"                                     
"================================================================
call plug#begin('~/.config/nvim/plugged')

Plug 'gentoo/gentoo-syntax'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'Yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'valloric/youcompleteme'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/colorizer'
Plug 'iamcco/markdown-preview.vim'
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

" IndentLine
let g:indentLine_char= '┊'

" Vimtex
let g:vimtex_view_general_viewer = 'zathura'

" General:

set mouse=a                " Enable mouse. see :help mouse for info. 
set number	           " Show line numbers
set relativenumber
set linebreak	           " Break lines at word (requires Wrap lines)
set showbreak=+++ 	   " Wrap-broken line prefix
set textwidth=110	   " Line wrap (number of cols)
set showmatch	           " Highlight matching brace
set visualbell	           " Use visual bell (no beeping)
set encoding=utf-8         " Define o encoding exibido no terminal
set fileencoding=utf-8     " Define o encoding na escrita dos arquivos
set wildmenu
set wildmode=full

set hlsearch	           " Highlight all search results
set smartcase	           " Enable smart-case search
set ignorecase	           " Always case-insensitive
set incsearch	           " Searches for strings incrementally
 
set ve=all                 " Permite mover o cursor onde não há texto
set autoindent	           " Auto-indent new lines
set expandtab	           " Use spaces instead of tabs
set shiftwidth=4	       " Number of auto-indent spaces
set smartindent	           " Enable smart-indent
set smarttab	           " Enable smart-tabs
set softtabstop=4	       " Number of spaces per Tab
set clipboard=unnamedplus 
set shell=/bin/zsh
 
set background=dark
set termguicolors

set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

"" SpellCheck
set spelllang=pt_br,en_us
autocmd FileType tex setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType txt setlocal spell
autocmd FileType markdown setlocal spell

"" VimTex autocomplete with YouCompleteMe
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
  endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

"" Disable conceal in Latex files ("Hiding tag")
let g:tex_conceal = ''

"" Colorscheme Section:
if empty($DISPLAY)
    colorscheme default
else
    colorscheme gruvbox
    let g:gruvbox_contrast_dark='hard'
endif 
 
"" Syntax Hightlighting
syntax on
 
"" Persistent Undo:
" Let's save undo info!
if !isdirectory($HOME."/.config/nvim/undo-dir")
    call mkdir($HOME."/.config/nvim/undo-dir", "", 0700)
endif
set undodir=~/.config/nvim/undo-dir
set undofile

"" Template:
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.java 0r ~/.config/nvim/templates/Skeleton.java
  augroup END
endif

"" ALE quick navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"" NERDtree Section: 
map <C-n> :NERDTreeToggle<CR>

"" General Shortcuts:

" Abre uma janela horizontalmente e abre um menu inicial: 
nnoremap <C-h> :new <bar> :Startify <CR>
" Abre uma janela verticalmente e abre um menu inicial:  
nnoremap <C-v> :vnew <bar> :Startify <CR>
" Abre um painel com um historico de modificacoes
nnoremap <F5> :UndotreeToggle<cr>
"" Advanced:
set ruler	                " Show row and column ruler information
 
set undolevels=1500	        " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
  



"" AutoStart:
autocmd StdinReadPre * let s:std_in=1
 
