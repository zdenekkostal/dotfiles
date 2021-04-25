if has('nvim')
  lua require('init')
endif

scriptencoding utf-8

" Enable true color support
set termguicolors

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to ,
let g:mapleader = "\<Space>"

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamed

set hidden

" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" ============================================================================ "
" ===                               CUSTOM                                 === "

" Let me use the mouse
set mouse=a

" Try to make rendering faster
set lazyredraw
set ttyfast

" Keep at least 10 lines visible when scrolling
set scrolloff=10

" Add a background to current line
set cursorline

set nofoldenable          " no folding at all
set foldlevelstart=50 " Files open expanded

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

if has("nvim")
  " Transparent popup-menu
  set pumblend=10

  " Transparent floating windows
  set winblend=10
endif

" Editor theme
" This is set automatically via dark-notify, but let's fallback to dark
" to make sure light theme does not damage my eyes when opening nvim during
" the night
set background=dark
colorscheme gruvbox

" Reload vim config after 'tt' in normal mode
nnoremap <leader>tt :so $MYVIMRC<CR>

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom or right
set splitbelow
set splitright

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Search shorcuts === "
"   <leader>h - Find and replace
map <leader>h :%s/

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" ============================================================================ "
" ===                               CUSTOM                                 === "
" ============================================================================ "

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

" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>

" Select pasted text
noremap gV `[v`]

" Make writing and quitting easier
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" === Add sane mapping for resolving conflicts === "

" get from REMOTE
nmap <leader>dr :diffg RE<CR>

" get from BASE
nmap <leader>db :diffg BA<CR>

" get from LOCAL
nmap <leader>dl :diffg LO<CR>

" write everything and quit, marking the conlict as resolved
nmap <leader>dq :wqa<CR>

" Clear search highlight
nnoremap <silent> _ :nohl<CR>

" https://github.com/wincent/wincent
" Toggle fold at current position.
nnoremap <leader><Tab> za

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "
"
if has("nvim")
  " Set better diffing algorithm
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set number

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

" Live substitute for neovim
if has("nvim")
  set inccommand=split
endif

" Automatically load a session if there is one
if has('autocmd')
  autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') && !&modified |
        \   source Session.vim |
        \ endif
endif
