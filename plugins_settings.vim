" ############################
" ##### VUNDLE REQUIRED! #####
" ############################

set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
" Plugins go after this line.
call vundle#begin()

" The plugin manager - should always be here.
Plugin 'VundleVim/Vundle.vim'

" --- Colorschemes ---

Plugin 'altercation/vim-colors-solarized'
Plugin 'endel/vim-github-colorscheme'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'marcus/vim-mustang'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-vividchalk'
Plugin 'goatslacker/mango.vim'
"Plugin 'flazz/vim-colorschemes'
"Plugin 'chriskempson/base16-vim'

" --- General plugins ---

" Changes default Vim autocomplete to use the <Tab> key.
"Plugin 'ervandew/supertab'

" Makes commenting easier on Vim.
Plugin 'scrooloose/nerdcommenter'

" Shows a tree like structure of the current directory.
Plugin 'scrooloose/nerdtree'

" Handles Git wonderfully from within Vim.
Plugin 'tpope/vim-fugitive'

" Provides a few more mappings to facilitate some tasks.
Plugin 'tpope/vim-unimpaired'

" Shows Git changes in the gutter (left of line number).
"Plugin 'airblade/vim-gitgutter'

" Integrates Vim to tmux.
"Plugin 'benmills/vimux'

" Changes Vim's status bar to a fancy one.
"Plugin 'bling/vim-airline'

" Provides fuzzy search for files in current directory|buffer|MRU.
Plugin 'kien/ctrlp.vim'

" Allows one to easily traverse files.
Plugin 'Lokaltog/vim-easymotion'

" Shows a small list of recent used files on Vim startup.
"Plugin 'mhinz/vim-startify'

" Creates the matching delimiter of current delimiter.
"Plugin 'Raimondi/delimitMate'

" Adds integration with Silver searcher.
"Plugin 'rking/ag.vim'

" Supports syntax checking for several languages.
"Plugin 'scrooloose/syntastic'

" Provides multiple cursors.
"Plugin 'terryma/vim-multiple-cursors'

" Provides an easy way to surround text with characters.
Plugin 'tpope/vim-surround'

if has('python')
    " Provides support for snippets.
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
endif

if has('unix')
    " Provides an awesome autocomplete for Vim.
    Plugin 'Valloric/YouCompleteMe'
endif

" --- Language or framework specific plugins ---

"Plugin 'mattn/emmet-vim'
"Plugin 'derekwyatt/vim-scala'
"Plugin 'wlangstroth/vim-racket'
"Plugin 'Slava/tern-meteor'
"Plugin 'vim-scripts/bash-support.vim'

" + Rust
Plugin 'rust-lang/rust.vim'
"Plugin 'phildawes/racer'

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

Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-leiningen'

" All of your Plugins must be added before the following line.
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line.

