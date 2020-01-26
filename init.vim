" ---------
" Vim Plug.
" ---------

call plug#begin('~/.config/nvim/plugged')

" Colorschemes.
Plug 'altercation/vim-colors-solarized'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'tpope/vim-vividchalk'

" Makes commenting easier on Vim.
Plug 'scrooloose/nerdcommenter'

" Handles Git wonderfully from within Vim.
Plug 'tpope/vim-fugitive'

" Provides a few more mappings to facilitate some tasks.
Plug 'tpope/vim-unimpaired'

" Changes Vim's status bar to a fancy one.
"Plug 'bling/vim-airline'

" Provides fuzzy search for files in current directory|buffer|MRU.
Plug 'ctrlpvim/ctrlp.vim'

" Allows one to easily traverse files.
Plug 'Lokaltog/vim-easymotion'

" Provides an easy way to surround text with characters.
Plug 'tpope/vim-surround'

" Plugin outside ~/.vim/plugged with post-update hook.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()

" ############################
" ##### general settings #####
" ############################

" When inserting a tab in the beggining of the line, it will be N spaces long
" and a <BS> will go back N spaces also (where N is the chosen number).
set smarttab
set shiftwidth=4

" Use spaces instead of tabs.
set expandtab

" 1 tab == 4 spaces.
set tabstop=4

" Automatically insert a linebreak after the selected width.
set textwidth=0   " No line breaks for me.
set wrapmargin=0  " I really don't want you to wrap, VIM.

" Indentation.
set autoindent
set nowrap  " Don't wrap lines.

" Disable annoying error noise (now it blinks).
set vb t_vb=

" Lines with number and with a particular width (no variation when
" increasing).
set number
" set numberwidth=5

" Show line and column.
set ruler

" Syntax highlighting.
syntax enable

" Highlight search matches as you type.
set hlsearch
set incsearch

" Always show the status line.
set laststatus=2

" Use utf-8 encoding.
set encoding=utf-8

" Change tab and trail characters.
set listchars=eol:$,tab:»-,trail:.,extends:>,precedes:<,nbsp:_
" set listchars=eol:¬,tab:»˽,trail:~,extends:>,precedes:<,nbsp:_

" Highlight the cursor line.
set cursorline

" Allow backspace to work like in every text editor.
set backspace=2

" Visual autocomplete for command menu.
set wildmenu

" Redraw only when needed to.
set lazyredraw

" Change VIM default splits (to bottom right).
set splitbelow
set splitright

" Set line endings. Prefer Unix, but also accept DOS.
set fileformats=unix,dos

" Set proper colors.
set t_Co=256

" Avoid folding. Note: 'za' to unfold.
set nofoldenable

try
    if has('gui_running')
        colorscheme molokai
        set background=dark
    else
        colorscheme badwolf
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
    set background=dark
endtry

" Set ruler.
" TODO: adapt for different filetypes.
set colorcolumn=79

" Set how the status line will be shown in the bottom of Vim.
set statusline=%<%F\ %m%r%h\ %=lines:%l/%L\ col:%c%V

set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor30-Cursor
set guicursor+=i-ci:ver10-Cursor
set guicursor+=r-cr:hor10-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

"autocmd BufNewFile,BufRead *.ejs set filetype=html
"set term=xterm-256color

" ################################
" ##### GUI related settings #####
" ################################
" For NVim, check the ~/.config/nvim/ginit.vim.

if has('win32')
    " Windows specific settings.
    if has('gui_running')
        " Windows GUI settings.
        set guifont=Consolas:h10:cANSI
    endif
    " Yank to clipboard.
    set clipboard=unnamed
else
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
        " Do Mac stuff here.
        if has('gui_running')
            set guifont=Menlo\ Regular:h10
        endif
        set clipboard=unnamed
    else
        " Do Linux stuff here.
        if has('gui_running')
            " Set font according to the list (if one is not present, the next
            " one is used).
            set guifont=Meslo\ LG\ M\ 10,Roboto\ Mono\ 12,Consolas\ 10,Monospace\ 10
        endif
        " Yank to clipboard
        set clipboard=unnamedplus
    endif
endif

" General GUI specific settings.
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

" --- Molokai ---

let g:molokai_original = 1  " Original monokai background color.
" For terminal, with 256 colors.
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
        " Open current working directory in NERDTree.
        nnoremap <silent> <Leader><Leader>d :NERDTreeCWD<CR>
    endif
endfunction

" ############################
" ##### general mappings #####
" ############################

" Use normal regex.
nnoremap / /\v
vnoremap / /\v

" Simpler way to go to command mode from insert mode.
inoremap jf <Esc>
inoremap fj <Esc>

" Quicker window movement.
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>

" Move vertically by visual line (not jumping long lines).
nnoremap j gj
nnoremap k gk

" Highlight last inserted text.
nnoremap gV `[v`]

" Allow fast indenting when there is a chunck of text selected.
vnoremap < <gv
vnoremap > >gv

" Easy way to change between tabs.
nnoremap <a-k> :tabnext<cr>
nnoremap <a-j> :tabprevious<cr>

" ###########################
" ##### leader mappings #####
" ###########################

" Change leader.
let mapleader = ","

" Execute last macro recorded in register 'q'.
nnoremap <Space> @q

" Shift the line below by one line (downwards).
nnoremap <silent> <Leader>o :let cp=getpos('.')<CR>o<Esc>k:call cursor(cp[1],cp[2])<CR>
nnoremap <silent> <Leader>O :let cp=getpos('.')<CR>O<Esc>j:call cursor(cp[1] + 1,cp[2]) <CR>

" Easily source my vimrc.
nnoremap <Leader><Leader>sv :source $MYVIMRC<CR>
" Easily edit my vimrc.
nnoremap <Leader><Leader>ev :tabe $MYVIMRC<CR>

" Clear last search.
nnoremap <silent> <Leader><Leader>e :let @/ = ""<CR>

" Save while in insert mode without leaving insert mode.
nnoremap <Leader>w :w<CR>
inoremap <Leader>w <Esc>:w<CR>

" Quit easily.
nnoremap <Leader>q :q<CR>
inoremap <Leader>q <Esc>:q<CR>

" Save and quit easily.
inoremap <Leader>x <Esc>:x<CR>
nnoremap <Leader>x :x<CR>

" Select all.
nnoremap <Leader>a ggVG

