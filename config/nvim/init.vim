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
set nobackup
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
set foldlevelstart=50 " Files open expanded
set foldmethod=indent " Use decent folding
set hidden                " Hide buffers instead of closing them

if has("nvim")
  set inccommand=split " Live substitute for neovim
endif

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
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx']}
Plug 'jparise/vim-graphql', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

" Themes
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
Plug 'w0rp/ale'

Plug 'kshenoy/vim-signature'
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }
Plug 'sbdchd/neoformat'

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

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

filetype plugin indent on " required!
syntax enable

" theme and background
set background=light
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
  nmap ,cl :let @*=substitute(expand("%:p"), getcwd()."/", "", "g")<CR>
endif

let g:jsx_ext_required = 0

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

" https://github.com/wincent/wincent
" Toggle fold at current position.
nnoremap <Tab> za

" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>

" fzf
nnoremap <leader>t :GitFiles<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>m :Marks<CR>

imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-f> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Run neoformat on save
" autocmd BufWritePre *.js Neoformat

" augroup fmt
"   autocmd!
"   autocmd BufWritePre * Neoformat
" augroup END
" Redefine :Ag command
autocmd VimEnter * command! -nargs=* Ag
      \ call fzf#vim#ag(<q-args>, '--color-path "33;1"', fzf#vim#default_layout)
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow "always"'
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

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
let NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '├'
let g:NERDTreeDirArrowCollapsible = '└'
let g:NERDTreeMapActivateNode = '<tab>'

" some leader shortcuts for common commands
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
" nmap <leader>e :e<CR>

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

" Setup autocompletion
" https://www.gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/

let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"  tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript,javascript.jsx setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1

  autocmd FileType javascript,javascript.jsx setlocal omnifunc=tern#Complete
  autocmd FileType javascript,javascript.jsx nnoremap <silent> <buffer> gb :TernDef<CR>
endif

" Setup Airline
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='gruvbox' " oceanicnext
let g:airline_powerline_fonts = 1
let g:airline_section_b = ''

let g:airline_section_x = ''
let g:airline_section_y = ''

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_fixers = {'javascript': ['prettier_standard']}
let g:ale_linters = {'javascript': ['standard']}
let g:ale_fix_on_save = 1

nmap <Leader>E <Plug>(ale_previous_wrap)
nmap <Leader>e <Plug>(ale_next_wrap)

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
  augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END
endif
