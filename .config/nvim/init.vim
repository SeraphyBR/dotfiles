"=================================================================
"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
" 
" ~SeraphyBR Neovim Config
"================================================================

" Auto install vim-plug and Plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'gentoo/gentoo-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
Plug 'aperezdc/vim-template'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentline'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'
Plug 'Shougo/denite.nvim'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'Shougo/echodoc.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'iamcco/markdown-preview.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-unimpaired'
" All of your Plugins must be added before the following line
call plug#end()            " required


" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General:
set mouse=a                " Enable mouse. see :help mouse for info. 
set number	           " Show line numbers
set hidden
set relativenumber
set cursorline             " Highlight cursor line
set noshowmode
set linebreak	           " Break lines at word (requires Wrap lines)
set showbreak=+++ 	   " Wrap-broken line prefix
set textwidth=110	   " Line wrap (number of cols)
set showmatch	           " Highlight matching brace
set visualbell	           " Use visual bell (no beeping)
set encoding=utf-8         " Define o encoding exibido no terminal
set fileencoding=utf-8     " Define o encoding na escrita dos arquivos
set wildmenu
set wildmode=full
set guifont=DejaVuSansMono\ Nerd\ Font\ 12
set pumblend=18            " pseudo-transparent popup menu
set hlsearch	           " Highlight all search results
set smartcase	           " Enable smart-case search
set ignorecase	           " Always case-insensitive
set incsearch	           " Searches for strings incrementally
set splitbelow
set ve=all                 " Permite mover o cursor onde não há texto
set autoindent	           " Auto-indent new lines
set expandtab	           " Use spaces instead of tabs
set shiftwidth=4	   " Number of auto-indent spaces
set smartindent	           " Enable smart-indent
set smarttab	           " Enable smart-tabs
set softtabstop=4	   " Number of spaces per Tab
set scrolloff=3            " Always show N lines above/below the cursor
set clipboard=unnamedplus 
set shell=/bin/zsh
set spelllang=pt_br,en_us

set background=dark
set termguicolors

set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class,*.jar,*.iso
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff    
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz,*.docx,*.ppt,*.odt
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

"" Advanced:
set ruler	                " Show row and column ruler information
set undolevels=1500	        " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour  

"" Persistent Undo:
" Let's save undo info!
if !isdirectory($HOME."/.config/nvim/undo-dir")
    call mkdir($HOME."/.config/nvim/undo-dir", "", 0700)
endif
set undodir=~/.config/nvim/undo-dir
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Airline status line:
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}' 

"" ALE section:
let g:ale_linters = {
            \ 'python': ['pyls']
            \ }

"" COC section:
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = [ 
            \ 'coc-highlight',
            \ 'coc-pairs',
            \ 'coc-snippets',
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-vimtex'
            \ ]
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"" IndentLine
let g:indentLine_char= '┊'
let g:indentLine_fileTypeExclude = ['markdown']  

" Vimtex
let g:vimtex_view_general_viewer = 'zathura'

"" Prettier:
let g:prettier#config#print_width = 100
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 4

"" Disable conceal ("Hiding tag"):
let g:tex_conceal = ''
let g:vim_markdown_conceal = 0

"" Colorscheme Section:
if empty($DISPLAY)
    colorscheme default
else
    colorscheme gruvbox
    let g:gruvbox_contrast_dark='hard'
endif 

"" Syntax Hightlighting:
syntax on

"" NERDtree Section: 
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 42
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:NERDTreeRespectWildIgnore = 1

"" Startify Section:
let g:startify_files_number = 8
let g:startify_update_oldfiles = 1
let g:startify_session_autoload = 1
let g:startify_change_to_dir = 1
let g:startify_fortune_use_unicode = 1
let g:ascii = [
            \' _______                ___ ___  __ ',          
            \'|    |  |.-----..-----.|   |   ||__|.--------. ',
            \'|       ||  -__||  _  ||   |   ||  ||        |   ',
            \'|__|____||_____||_____| \_____/ |__||__|__|__|   ',
            \]
let g:startify_custom_header = 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")' 
let g:startify_bookmarks = [ {'v': '~/.config/nvim/init.vim'}, '~/.zshrc' ]
let g:startify_commands = [ {'t': ['Open a new Terminal', ':terminal']} ]
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   My most recently used files:'] },
            \ { 'type': 'dir',       'header': ['   My most recently used files in the current directory: '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions:']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks:']      },
            \ { 'type': 'commands',  'header': ['   Commands:']       },
            \ ]

"" Denite Section:
call denite#custom#option('default', {
            \ 'auto_resize': 1,
            \ 'prompt': '  :',
            \ 'direction': 'rightbelow',
            \ })

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Shortcuts:

" Abre um painel com um historico de modificacoes
nnoremap <F5> :UndotreeToggle<cr>

" Substitui a palavra sobre o cursor com a ultima palavra copiada.
" Para copiar uma palavra: yiw
nnoremap CC diw"0P

" Corrigir erros de escrita com ctrl+L (Modo de inserção)
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Fix indentation on entire file
map <F7> mzgg=G`z

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"  

" ALE quick navigate between errors:
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

map <C-n> :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" AutoStart:
autocmd FileType tex,gitcommit,text,markdown setlocal spell
autocmd TermOpen * call SetTermOptions()
autocmd StdinReadPre * let s:std_in=1
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd VimEnter *
            \   if !argc()
            \ |   setlocal nowrap
            \ |   Startify
            \ | endif 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Functions:
function SetTermOptions() 
    setlocal nonumber
    setlocal norelativenumber
    IndentLinesDisable
endfunction   

function! StartifyEntryFormat() 
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path' 
endfunction  
