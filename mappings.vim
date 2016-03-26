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

" New line and indentation when inside braces.
inoremap {<CR> {<CR>}<Esc>O

" Easy way to change between tabs.
nnoremap [g :tabprevious<CR>
nnoremap ]g :tabnext<CR>

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

