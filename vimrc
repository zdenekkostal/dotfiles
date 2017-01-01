set nocompatible               " be iMproved
filetype off                   " required!

set number

" wrap text at nearest space and show + at the beginning of the next line
" set wrap
" set showbreak=+
" set linebreak

set ff=unix

set nowrap

" use system clipboard on Mac
" doesn't work with system vim
" (brew macvim)
set clipboard=unnamed
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set scrolloff=10          " Keep at least 10 lines visible when scrolling
set shiftround            " always indent/outdent to the nearest tabstop
set hls                   " highlight search
set noswapfile            " no backups, we have git
set autowrite             " Automatically :write before running commands
set autoread              " Automatically reload changed files
set nofoldenable          " no folding at all
set expandtab
set tabstop=2
set shiftwidth=2
set ruler
set laststatus=2
set cursorline
set showcmd
set mouse=a
set lazyredraw
set ttyfast

" search
set ignorecase
set smartcase

" visualize leading tab and trailing whitespace
set list lcs=tab\:\'\ ,trail:·

" Split windows verticaly rather than horizontaly
set splitright
set splitbelow
set diffopt+=vertical

if has("termguicolors")
  set termguicolors
endif

" remove trailing whitespace before save
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin('~/.vim/plugged')

" Syntax highlighting
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'nono/vim-handlebars', { 'for': 'handlebars' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
" Plug 'edkolev/tmuxline.vim'

" Additionals
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

Plug 'Syntastic'
Plug 'pmsorhaindo/syntastic-local-eslint.vim', { 'for': 'javascript' }
Plug 'kshenoy/vim-signature'
Plug 'Lokaltog/vim-easymotion'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-expand-region'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
" Plug 'SirVer/ultisnips'

call plug#end()

filetype plugin indent on " required!
syntax enable

" theme and background
set background=dark
colorscheme gruvbox " OceanicNext

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'medium'
let g:gruvbox_invert_selection = 0

" Copy path to clipboard
" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  "nmap ,cl :let @*=expand("%:p")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), getcwd()."/", "", "g")<CR>
endif

" Handlebars
au BufRead,BufNewFile *.hbs set filetype=handlebars

" Markdown syntax
au BufRead,BufNewFile *.md,*.mdown set filetype=markdown
au BufRead,BufNewFile *.md,*.mdown setlocal wrap

" Add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set filetype=ruby

au BufNewFile,BufRead *.ejs set filetype=html

" Make
autocmd filetype make setlocal noexpandtab

" Commit msgs
autocmd Filetype gitcommit setlocal colorcolumn=50
autocmd Filetype gitcommit setlocal spell textwidth=72

let mapleader = "\<Space>"
inoremap jj <esc>

" fzf
nnoremap <leader>t :GitFiles<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>m :Marks<CR>

imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-f> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Redefine :Ag command
autocmd VimEnter * command! -nargs=* Ag
      \ call fzf#vim#ag(<q-args>, '--color-path "33;1"', fzf#vim#default_layout)

" fix nvim
" https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Select pasted text
noremap gV `[v`]

" Nerdtree
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" some leader shortcuts for common commands
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>e :e<CR>

nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>
nmap <leader>nw :set nowrap!<CR>

" Add sane mapping for resolving conflicts
" get from REMOTE
nmap <leader>dr :diffg RE<CR>
" get from BASE
nmap <leader>db :diffg BA<CR>
" get from LOCAL
nmap <leader>dl :diffg LO<CR>
nmap <leader>dq :wqa<CR>

" Clear search highlight
nnoremap <silent> _ :nohl<CR>

" Setup Airline
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='gruvbox' " oceanicnext
let g:airline_powerline_fonts = 1
let g:airline_section_b = ''

let g:airline_section_x = ''
let g:airline_section_y = ''

"" Setup syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" do not fold markdown sections
let g:vim_markdown_folding_disabled = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" auto reload vimrc once changed
if has("autocmd")
  autocmd! BufWritePost .vimrc source $MYVIMRC

  " This fixes the color changes and things not working :D
  autocmd! BufWritePost .vimrc filetype plugin indent on
endif
