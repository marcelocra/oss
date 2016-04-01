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
        if IsDark()
            colorscheme molokai
            set background=dark
        else
            colorscheme github
            set background=light
        endif
    else
        colorscheme mustang
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
" ##### backup file settings #####
" ################################

let g:vimtempfolder = expand($HOME . "/.vim/tmp")

" Test if a backup directory exists and if not, create one.
if !isdirectory(g:vimtempfolder)
    call mkdir(g:vimtempfolder)
endif
" Set the previously created directory as the backup directory.
let &backupdir = g:vimtempfolder
" Allow creation of backup files before overwriting a file.
set backup
" Set the same backup folder for the swapfile.
let &directory = g:vimtempfolder
" Use (or not) a swap file for the buffer.
set noswapfile
" Just to make sure I get a backup file.
set writebackup

" To ignore backup.
" set nobackup
" set nowb
" set noswapfile

" ################################
" ##### GUI related settings #####
" ################################

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
            set guifont=Meslo\ LG\ M\ 10,Roboto\ Mono\ 10,Consolas\ 10,Monospace\ 10
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

" --- NERDTree ---

" Not show certain files in NERDTree.
let g:NERDTreeIgnore = ['\.pyc$', '\.class$']
" Avoid using arrows for directories.
let g:NERDTreeDirArrows = 1

" --- UltiSnips ---

" UltiSnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe..
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" --- YouCompleteMe ---

let g:ycm_error_symbol = 'EE'
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Causes YCM to avoid asking if it should load the .ycm_extra_conf.py.
let g:ycm_confirm_extra_conf = 0

" --- Python mode ---

let g:pymode_rope = 0

" --- Silver Searcher ---

if executable('ag')  " if Silver Searcher is installed.
    " Use ag over grep.
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache.
    let g:ctrlp_use_caching = 0
endif

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

