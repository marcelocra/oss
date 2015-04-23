" ############################
" ##### VUNDLE REQUIRED! #####
" ############################

" Find where is your Vim folder.
if $HOME == fnamemodify($MYVIMRC, ':h')
    if isdirectory($HOME . '/.vim')
        let g:myvimfolder = expand($HOME . '/.vim')
    elseif isdirectory($HOME . '/vimfiles')
        let g:myvimfolder = expand($HOME . '/vimfiles')
    else
        echom "Vim default directories are not present in your computer. Create either a ~/.vim (unix) or a ~/vimfiles (win) before trying again."
        exit
    endif
else
    let g:myvimfolder = expand(fnamemodify($MYVIMRC, ':h'))
endif

set nocompatible              " be iMproved, required
filetype off                  " required
let &rtp.=','.expand(g:myvimfolder . '/bundle/Vundle.vim')

" Plugins go after this line
call vundle#begin(g:myvimfolder . "/bundle")

" The plugin manager - should always be here
Plugin 'gmarik/Vundle.vim'

" --- Colorschemes ---

Plugin 'tomasr/molokai'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'chriskempson/base16-vim'
"Plugin 'endel/vim-github-colorscheme'
"Plugin 'flazz/vim-colorschemes'
"Plugin 'goatslacker/mango.vim'
"Plugin 'jpo/vim-railscasts-theme'
"Plugin 'marcus/vim-mustang'
"Plugin 'sjl/badwolf'
"Plugin 'tpope/vim-vividchalk'

" --- General plugins ---

Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'benmills/vimux'
"Plugin 'bling/vim-airline'
"Plugin 'honza/vim-snippets'
"Plugin 'kien/ctrlp.vim'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'mhinz/vim-startify'
"Plugin 'Raimondi/delimitMate'
"Plugin 'rking/ag.vim'
"Plugin 'scrooloose/syntastic'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'tpope/vim-surround'
"Plugin 'vim-scripts/CSApprox'
"Plugin 'Yggdroot/indentLine'
"if has('python')
    "Plugin 'SirVer/ultisnips'
"endif
"if has('unix')
    "Plugin 'Valloric/YouCompleteMe'
"endif

" --- Language or framework specific plugins ---

"Plugin 'mattn/emmet-vim'
"Plugin 'derekwyatt/vim-scala'
"Plugin 'wlangstroth/vim-racket'
"Plugin 'Slava/tern-meteor'
"Plugin 'vim-scripts/bash-support.vim'

" + Javascript

"Plugin 'moll/vim-node'
"Plugin 'kchmck/vim-coffee-script'
"Plugin 'pangloss/vim-javascript'
"Plugin 'digitaltoad/vim-jade'
"Plugin 'jelera/vim-javascript-syntax'
"Plugin 'mustache/vim-mustache-handlebars'

" + Python

"Plugin 'klen/python-mode'

" + Clojure

"Plugin 'tpope/vim-fireplace'
"Plugin 'tpope/vim-leiningen'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

" #####################
" ##### functions #####
" #####################

" Convert current file from DOS format to UNIX format
function! ConvertDosFileToUnix ()
    :update
    :e ++ff=dos
    :setlocal ff=unix
    :w
endfunction

" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

" Remove trailing spaces without moving the cursor from current
" place
function! RemoveTrailingSpaces ()
    call CommandToExecuteWithoutMovingCursor(":%s/\\s\\+$//e")
endfunction

" Function that allow other functions to be executed without
" changing the cursor position
function! CommandToExecuteWithoutMovingCursor(command)
    let cp=getpos('.')
    exec a:command
    call cursor(cp[1],cp[2])
endfunction

" Indent file without moving cursor
function! IndentCurrentFile()
    call CommandToExecuteWithoutMovingCursor("normal gg=G\<CR>")
    exec "normal zz"
endfunction

" ############################
" ##### general settings #####
" ############################

" When inserting a tab in the beggining of the line, it will be N spaces long
" and a <BS> will go back N spaces also (where N is the chosen number)
set smarttab
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set tabstop=4

" Automatically insert a linebreak after the selected width
set textwidth=0  " no line breaks for me
set wrapmargin=0  " I really don't want you to wrap, VIM

" Indentation
set autoindent
set wrap  " Wrap lines

" Disable annoying error noise (now it blinks)
set vb t_vb=

" Lines with number and with a particular width (no variation when increasing)
set number
" set numberwidth=5

" Show line and column
set ruler

" Syntax highlighting
syntax enable

" Highlight search matches as you type
set hlsearch
set incsearch

" Always show the status line
set laststatus=2

" Use utf-8 encoding
set encoding=utf-8

" Change tab and trail characters
set listchars=eol:$,tab:»-,trail:.,extends:>,precedes:<,nbsp:_
" set listchars=eol:¬,tab:»˽,trail:~,extends:>,precedes:<,nbsp:_

" Highlight the cursor line
set cursorline

" Allow backspace to work like in every text editor
set backspace=2

" Visual autocomplete for command menu
set wildmenu

" Redraw only when needed to
set lazyredraw

" Change VIM default splits (to bottom right)
set splitbelow
set splitright

" Set line endings. Prefer Unix, but also accept DOS
set fileformats=unix,dos

" Set proper colors
set t_Co=256

" Avoid folding
set nofoldenable

try
    colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme slate
endtry

" Set ruler - TODO: adapt for different filetypes
"set colorcolumn=80

" Set how the status line will be shown in the bottom of Vim
set statusline=%<%F\ %m%r%h\ %{fugitive#statusline()}%=lines:%l/%L\ col:%c%V

set guicursor+=i:ver10-iCursor

"autocmd BufNewFile,BufRead *.ejs set filetype=html
"set term=xterm-256color

" ################################
" ##### backup file settings #####
" ################################

let g:vimtempfolder = g:myvimfolder . "/tmp"

" Test if a backup directory exists and if not, create one
if !isdirectory(g:vimtempfolder)
    call mkdir(g:vimtempfolder)
endif
" Set the previously created directory as the backup directory
let &backupdir = g:vimtempfolder
" Allow creation of backup files before overwriting a file
set backup
" Set the same backup folder for the swapfile
let &directory = g:vimtempfolder
" Use (or not) a swap file for the buffer
set noswapfile
" Just to make sure I get a backup file
set writebackup

" To ignore backup
" set nobackup
" set nowb
" set noswapfile

" ################################
" ##### GUI related settings #####
" ################################

if has('win32')
    " Windows specific settings
    if has('gui_running')
        " Windows GUI settings
        set guifont=Consolas:h10:cANSI
    endif
    " Yank to clipboard
    set clipboard=unnamed
else
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
        " Do Mac stuff here
        if has('gui_running')
            set guifont=Menlo\ Regular:h10
        endif
        set clipboard=unnamed
    else
        " Do Linux stuff here
        if has('gui_running')
            " Set font according to the list (if one is not present, try the next)
            set guifont=DejaVu\ Sans\ Mono\ 10,Consolas\ 12,Monospace\ 12
        endif
        " Yank to clipboard
        set clipboard=unnamedplus
    endif
endif

" If using Powerline patched fonts, include them in Airline
if &guifont =~ "Meslo LG S for Powerline"
    let g:airline_powerline_fonts = 1
elseif &guifont =~ "Source Code Pro for Powerline"
    let g:airline_powerline_fonts = 1
endif

" General GUI specific settings
if has('gui_running')
    " Remove menus (don't like them)
    set guioptions-=m  " remove menubar
    set guioptions-=T  " remove toolbar
    set guioptions-=r  " remove right-hand scroll bar
    set guioptions-=L  " remove left-hand scroll bar
endif

" ###########################
" ##### plugin settings #####
" ###########################

" --- NERDTree ---

" Not show certain files in NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\.class$']
" Avoid using arrows for directories
let g:NERDTreeDirArrows = 1

" --- UltiSnips ---

" UltiSnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" --- Python mode ---

let g:pymode_rope = 0

" --- Silver Searcher ---

if executable('ag')  " if Silver Searcher is installed
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" --- Molokai ---

let g:molokai_original = 1  " Original monokai background color
" For terminal, with 256 colors
if !has('gui_running')
    let g:rehash256 = 1
endif

" --- Plugin specific mappings ---

augroup plugin_initialize
    autocmd!
    autocmd VimEnter * call LoadPluginSpecificMappings()
augroup END

function! LoadPluginSpecificMappings()
    if exists(':NERDTree')
        " Open current working directory in NERDTree
        nnoremap <silent> <Leader><Leader>d :NERDTreeCWD<CR>
    endif

    if has('python')
        if exists(':UltiSnipsEdit')
            " SuperTab / YouCompleteMe
            "autocmd InsertEnter * :exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<CR>"
            "autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
        endif
    endif

    if exists(':CtrlP')
        " CtrlP
        " Mix all results CtrlP provides, either from buffer, file or MRU
        nnoremap <C-p> :CtrlPMixed<CR>
    endif
endfunction

" ############################
" ##### general mappings #####
" ############################

" Use normal regex
nnoremap / /\v
vnoremap / /\v

" execute macro saved in register q with space
nnoremap <Space> @q

" From insert mode to command mode with <kj>
inoremap jj <Esc>
inoremap kk <Esc>

" Quicker window movement
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>

" Remove trailing character from Java files
autocmd BufWritePre * :call RemoveTrailingSpaces()

" Move vertically by visual line (not jumping long lines)
nnoremap j gj
nnoremap k gk

" Highlight last inserted text
nnoremap gV `[v`]

" Toogle showing extra chars
noremap <F10> :set list!<CR>
" List buffers and wait for buffer number to switch
nnoremap <F5> :buffers<CR>:b
" Reindent the file (see functions.vim)
nnoremap <F12> :call IndentCurrentFile()<CR>

" Allow indent using Tab and Shift Tab when there is a chunck of text selected
vnoremap < <gv
vnoremap > >gv

" New line and indentation when inside braces
inoremap {<CR> {<CR>}<Esc>O

" Easy way to change between tabs
nnoremap [g :tabprevious<CR>
nnoremap ]g :tabnext<CR>

" Fast pane resizing
nnoremap <kPlus> <C-w>+
nnoremap <kMinus> <C-w>-
nnoremap + <C-w>+
nnoremap - <C-w>-

" ###########################
" ##### leader mappings #####
" ###########################

" Change leader from '\' (default) to ','
let mapleader = ","

" Shift the line below by one line (downwards)
nnoremap <silent> <Leader>o :let cp=getpos('.')<CR>o<Esc>k:call cursor(cp[1],cp[2])<CR>
nnoremap <silent> <Leader>O :let cp=getpos('.')<CR>O<Esc>j:call cursor(cp[1] + 1,cp[2]) <CR>

" Easily source my vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>
" Easily edit my vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>

" Clear last search
nnoremap <silent> <Leader><Leader>e :let @/ = ""<CR>

" Save while in insert mode without leaving insert mode
nnoremap <Leader>w :w<CR>
inoremap <Leader>w <Esc>:w<CR>

" Quit easily
nnoremap <Leader>q :q<CR>
inoremap <Leader>q <Esc>:q<CR>

" Save and quit easily
inoremap <Leader>x <Esc>:x<CR>
nnoremap <Leader>x :x<CR>

" Select all
nnoremap <Leader>a ggVG
