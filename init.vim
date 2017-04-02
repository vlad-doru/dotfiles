set nocompatible              " be iMproved, required
filetype off                  " required

set mouse=a
syntax on
syntax enable

let mapleader=","
set showmatch
set hidden
set nowrap              " don't wrap lines
set tabstop=2           " 2 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 2 space tab
set shiftwidth=2

set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile
set pastetoggle=<F2>

" Vim splits awesome navigation
if has('nvim')
  nnoremap <BS> <C-W>h
endif
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Map write to shortcuts
map <Esc><Esc> :w<CR>
map <C-s> :w<CR>
map <leader>w :w<CR>
nnoremap ; :

" Find and replace the word under the cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" VIM PLUGINS 
call plug#begin('~/.vim/plugged')

" Amazing fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git gutter
Plug 'airblade/vim-gitgutter'
" Tmux seamless navigation
Plug 'christoomey/vim-tmux-navigator'
" Easy motion plugin
Plug 'easymotion/vim-easymotion'
" Pairing brackets sucks
Plug 'jiangmiao/auto-pairs'
" Supertab to make completions only with tabs
Plug 'ervandew/supertab'
" Powerline fonts
Plug 'powerline/fonts'
" Rainbow paranthesis
Plug 'luochen1990/rainbow'
" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Vim onedark themes
Plug 'flazz/vim-colorschemes'

call plug#end()

" Plugins customization and bindings

" FZF fuzzy finder which is fast as hell.
map <C-p> :Files .<CR>
map <C-f> :Lines <CR>
map <C-b> :Buffers <CR>
map <C-c> :BLines <CR>
let g:fzf_layout = { 'down': '~40%' }

" Airline configuration.
let g:airline_theme='wombat'
let g:airline_powerline_fonts = 1
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

" Navigate buffers easily
set hidden
nnoremap <S-k> :bnext<CR>
nnoremap <S-j> :bprev<CR>

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

" Rainbow Paranthesis
let g:rainbow_active = 1 

" Colorscheme
colorscheme DevC++
hi Normal guibg=NONE ctermbg=NONE

