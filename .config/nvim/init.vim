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
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/denite.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentline'
Plug 'aperezdc/vim-template'
Plug 'gentoo/gentoo-syntax'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General:

set autoindent               " Auto-indent new lines
set background=dark
set clipboard=unnamedplus
set cursorline              " Highlight cursor line
set encoding=utf-8          " Define o encoding exibido no terminal
set expandtab               " Use spaces instead of tabs
set fileencoding=utf-8      " Define o encoding na escrita dos arquivos
set guifont=DejaVuSansMono\ Nerd\ Font\ 12
set hidden
set hlsearch                " Highlight all search results
set ignorecase              " Always case-insensitive
set inccommand=split
set incsearch                     " Searches for strings incrementally
set list listchars=trail:·,tab:>· " Show trailing spaces as dots
set linebreak                     " Break lines at word (requires Wrap lines)
set mouse=a                 " Enable mouse. see :help mouse for info.
set noshowmode
set number                  " Show line numbers
"set pumblend=18            " pseudo-transparent popup menu
set relativenumber
set scrolloff=999           " Always show N lines above/below the cursor
set shell=/bin/zsh
set shiftwidth=4            " Number of auto-indent spaces
set showbreak=+++           " Wrap-broken line prefix
set showmatch               " Highlight matching brace
set smartcase               " Enable smart-case search
set smartindent             " Enable smart-indent
set smarttab                " Enable smart-tabs
set softtabstop=4           " Number of spaces per Tab
set spelllang=pt_br,en_us
set splitbelow
set termguicolors
set textwidth=110                    " Line wrap (number of cols)
set virtualedit=insert,block,onemore " Permite mover o cursor onde não há texto
set visualbell                       " Use visual bell (no beeping)
set wildmenu
set wildmode=full

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
set ruler                      " Show row and column ruler information
set undolevels=1500            " Number of undo levels
set backspace=indent,eol,start " Backspace behaviour

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
            \ 'coc-css',
            \ 'coc-git',
            \ 'coc-highlight',
            \ 'coc-html',
            \ 'coc-java',
            \ 'coc-json',
            \ 'coc-marketplace',
            \ 'coc-pairs',
            \ 'coc-prettier',
            \ 'coc-project',
            \ 'coc-rls',
            \ 'coc-snippets',
            \ 'coc-tabnine',
            \ 'coc-vimlsp',
            \ 'coc-vimtex',
            \ 'coc-yaml',
            \ 'coc-yank'
            \ ]
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"" Rainbow Parentheses Improved
let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['#FFD700','#C466C0','#7AB9E0']}

"" Vista:
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = "coc"

"" IndentLine:
let g:indentLine_char= '│'
let g:indentLine_fileTypeExclude = ['markdown']

"" Custom Templates:
if !isdirectory($HOME."/.config/nvim/templates")
    call mkdir($HOME."/.config/nvim/templates", "", 0700)
endif
let g:templates_directory = [ '~/.config/nvim/templates' ]

" Vimtex:
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
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
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

" Coc-yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Corrigir erros de escrita com ctrl+L (Modo de inserção)
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Fix indentation on entire file
noremap <F7> mzgg=G`z

" Remove trailing whitespaces at the end of each line
command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F6>   m`:TrimSpaces<CR>``


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
    startinsert
endfunction

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

"" https://vim.fandom.com/wiki/Remove_unwanted_spaces
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

"" https://vim.fandom.com/wiki/Remove_unwanted_spaces
function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction
