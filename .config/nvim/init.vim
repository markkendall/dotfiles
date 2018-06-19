" Use vim-plug to manage plugins
call plug#begin('~/.nvim/plugged')

Plug 'airblade/vim-rooter'
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'
Plug 'danro/rename.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'janko-m/vim-test'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'kassio/neoterm'
Plug 'kchmck/vim-coffee-script'
Plug 'lambdatoast/elm.vim'
Plug 'pangloss/vim-javascript'
Plug 'benekastah/neomake'
Plug 'mhinz/vim-mix-format'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vimwiki/vimwiki'
Plug 'mxw/vim-jsx'

if !exists('g:gui_oni')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'kien/ctrlp.vim'
  Plug 'mhinz/vim-startify'
  Plug 'ngmy/vim-rubocop'
  Plug 'rking/ag.vim'
endif

call plug#end()

" Show position in file
set ruler
set number

set novisualbell  " No blinking .
set noerrorbells  " No noise.
set vb t_vb=
set laststatus=2  " Always show status line.

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" No swap files or backups
set nobackup
set nowritebackup
set noswapfile

" Turn on highlighted search and syntax highlighting
syntax enable
filetype plugin indent on

" Always use the system clipboard
set clipboard+=unnamedplus

" Color scheme
set background=dark
colorscheme solarized

" airline config
let g:airline_powerline_fonts = 1

" Set leader to comma
let mapleader = ","

" ack config
map <leader>a :Ack<space>

" Toggle invisible chars"
map <leader>i :set list!<CR>

" Min/max window sizes
set winwidth=84
set winheight=10
set winminheight=10
set winheight=999

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" navigation between tabs
map <leader>tt :tabnew \| :term<CR>
map <leader>tl :tabnext<CR>
map <leader>th :tabprevious<CR>

" move from the neovim terminal window to somewhere else
tnoremap <c-h> <C-\><C-n><C-w>h
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-l> <C-\><C-n><C-w>l

" exit terminal window insert mode with ESC
tnoremap <esc> <C-\><C-n>

" put terminal buffers into insert mode when activated
autocmd WinEnter term://* startinsert

" Allow terminal buffers to be closed
autocmd TermOpen * set bufhidden=hide

" file finding
set wildignore+=.git,node_modules/**,*/tmp/*,*/bower_components/*,*/node_modules/*
map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gp :CtrlP app/presenters<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gj :CtrlP app/assets/javascripts<cr>
map <leader>gs :CtrlP app/assets/stylesheets<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>gt :CtrlP spec<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>f :CtrlP<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CtrlP %%<cr>

" Back to previous buffer
nnoremap <leader><leader> <c-^>

" Remove whitespace at the ends of lines
:map <leader>w :FixWhitespace<cr>

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Make searches case-insensitive
set ignorecase
set smartcase

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Invisible characters
set listchars=tab:▸\ ,eol:¬
set nolist

" Soft tabs, 2 spaces
set binary
set expandtab
set shiftwidth=2
set softtabstop=2

" Bring back vim-commentary's old single line comment shortcut
nmap \\\ <Plug>CommentaryLine<CR>

let g:netrw_dirhistmax=0

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use neomake for linting files on save
" autocmd! BufWritePost,BufEnter * Neomake
" let g:neomake_open_list = 2

" Neoterm test runner config
let g:neoterm_shell = 'zsh'
" let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'

nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSend<cr>
vnoremap <silent> <f9> :TREPLSend<cr>

" test runner config
let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Useful maps
" hide/close all terminals
nnoremap <silent> ,th :call neoterm#close_all()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

" Git commands
command! -nargs=+ Tg :T git <args>

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Allow JSX in normal JS files
let g:jsx_ext_required = 0

" Format Elixir files on save
let g:mix_format_on_save = 1

" Oni
if exists('g:gui_oni')
  set number
  set noswapfile
  set smartcase

  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd

  set mouse=a

  set list
  set listchars=trail:·
endif
