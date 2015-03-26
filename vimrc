set nocompatible               " be iMproved

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

silent! runtime bundles.vim

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

syntax enable
filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
imap jj <ESC>
set modelines=0
set history=1000
set nobackup
set nowritebackup
set noswapfile
set autoread
set undofile

"  ---------------------------------------------------------------------------
"  UI
"  ---------------------------------------------------------------------------

set title
set encoding=utf-8
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set relativenumber
set previewheight=20

set t_Co=256
set background=dark
"colorscheme desert-warm-256
colorscheme Tomorrow-Night
highlight clear SignColumn
highlight CursorLine term=NONE cterm=NONE ctermbg=236

" make vertical split bar character a space (so not visible)
set fillchars+=vert:\ 

set splitbelow splitright

" switch to relative numbers in normal mode
autocmd BufLeave * :set norelativenumber
autocmd BufEnter * :set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

"  ---------------------------------------------------------------------------
"  Text Formatting
"  ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround

set nowrap
set textwidth=79
set formatoptions=n

if exists("+colorcolumn")
  set colorcolumn=80
  highlight ColorColumn ctermbg=236
endif

" display tabs and trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅"

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------

set tildeop

"  ---------------------------------------------------------------------------
"  Status Line
"  ---------------------------------------------------------------------------

" flags
set statusline+=%m%r%h%w
" git branch
set statusline+=\ %{fugitive#statusline()}
" encoding
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]
" rvm
if exists("$rvm_path")
  set statusline+=\ %{rvm#statusline()}
end
" path
set statusline=%f
" line x of y
set statusline+=\ [line\ %l\/%L]

" Colour
hi StatusLine ctermfg=Black ctermbg=White
hi StatusLineNC ctermfg=Black ctermbg=Grey

" Change colour of statusline in insert mode
au InsertEnter * hi StatusLine ctermbg=DarkBlue
au InsertLeave * hi StatusLine ctermfg=Black ctermbg=White


"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------

" Searching / moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
" set nohlsearch

hi Search ctermfg=NONE ctermbg=NONE cterm=underline

" Toggle search highlighting
noremap <F4> :set hlsearch! hlsearch?<CR>

" search (forwards), drops a mark first
nmap <space> /
" search (backwards), drops a mark first
map <c-space> ?

" Center screen when scrolling search results
nmap n nzz
nmap N Nzz

" Turn off arrow keys (this might not be a good idea for beginners, but it is
" the best way to ween yourself of arrow keys on to hjkl)
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap j gj
nnoremap k gk

" To search in files (,a) we can use ack or ag

if executable('ag')
  nnoremap <leader>a :Ag! 
  nnoremap <leader>aa :Ag! <cword><CR>
elseif executable('ack')
  nnoremap <leader>a :Ack! 
  nnoremap <leader>a :Ack! <cword><CR>
  let g:ackprg="ack -H --nocolor --nogroup --column"
endif

" Ack settings: https://github.com/krisleech/vimfiles/wiki/Make-ack-ignore-files

" Auto format
map === gg=G

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>

" close buffer
nmap <leader>d :bd<CR>

" close all buffers
nmap <leader>D :bufdo bd<CR>

" Switch between last two buffers
nnoremap <leader><leader> <c-^>

" Edit/View files relative to current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" File to ignore for autocomplete, also used by Ctrlp
set wildignore+=*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak,*.tar,*.zip,*.tgz
set wildignore+=*/.hg/*,*/.svn/*,*/.git/*
set wildignore+=*/vendor/cache/*,*/public/system/*,*/tmp/*,*/log/*,*/solr/data/*,*/.DS_Store

" Saving and exit
nmap <leader>q :wqa!<CR>
nmap <leader>w :w!<CR>
nmap <leader><Esc> :q!<CR>

" CTAGS aka autocomplete
" Includes all gems in RVM gemset, excludes Javascript and HTML
"map <leader>rt :!ctags --sort=yes --extra=+f --languages=-javascript --exclude=.git --exclude=log --exclude=db --exclude=public --exclude=alfresco -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

map <leader>rt :call VimuxRunCommand("clear;ctags --sort=yes --extra=+f --languages=-javascript --exclude=.git --exclude=log --exclude=db --exclude=public --exclude=alfresco -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/* &")<CR>

"  ---------------------------------------------------------------------------
"  Function Keys
"  ---------------------------------------------------------------------------

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" Clojure

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Ctrlp
map <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = ',f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '/tmp/ctrlp'

" ZoomWin (toggle split to full screen)
map <leader>z :ZoomWin<CR>

" NERDTree
map <leader>p :NERDTreeToggle<cr>
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 50 
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1

" Use only current file to autocomplete from tags
set complete=.,w,b,u,t,i

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'} 
let g:AutoCloseProtectedRegions = ["Character"] 

let my_home = expand("$HOME/")

if filereadable(my_home . '.vim/bundle/vim-autocorrect/autocorrect.vim')
  source ~/.vim/bundle/vim-autocorrect/autocorrect.vim
endif

" Easy commenting
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Supertab
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" YankRing
let g:yankring_history_dir = '/tmp'

" Fugitive

nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>i

" GitGutter

let g:gitgutter_map_keys = 0

"  ---------------------------------------------------------------------------
"  Tmux/Rspec
"  ---------------------------------------------------------------------------

" default mappings ,t and ,T for running all specs in buffer and spec on
" current line.

let VimuxUseNearestPane = 1
let VimuxHeight = "40"
let VimuxOrientation = "v"

if exists('$TMUX')
  " Run shell command
  map <leader>rc :PromptVimTmuxCommand<CR>
endif

"  ---------------------------------------------------------------------------
"  GUI
"  ---------------------------------------------------------------------------

if has("gui_running")
  set guioptions-=T " no toolbar
  set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions=aiA
  set mouse=a
  set guifont=Monaco:h12
endif

" Mouse in terminal!!! (good for resizing splits)
if has('mouse')
  set mouse=a
  set ttymouse=xterm2
endif

"  ---------------------------------------------------------------------------
"  Directories
"  ---------------------------------------------------------------------------

set directory=./.vim-swap,~/tmp/vim,~/.tmp,~/tmp,/tmp
set backupdir=./.vim-backup,~/tmp/vim,~/.tmp,~/tmp,/tmp
set undodir=./.vim-undo,~/tmp/vim,~/.tmp,~/tmp,/tmp

" Ctags path
let Tlist_Ctags_Cmd = 'ctags'

" Make Vim use RVM correctly when using Zsh
" https://rvm.beginrescueend.com/integration/vim/
set shell=/bin/sh

" Finally, load custom configs
if filereadable(my_home . '.vimrc.local')
  source ~/.vimrc.local
endif

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------

" When vimrc, either directly or via symlink, is edited, automatically reload it
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %
autocmd! bufwritepost bundles.vim source %
