lua require('init')

scriptencoding utf-8

" Enable true color support
set termguicolors

" ============================================================================ "
"               Heavily inspired and copy pasted from excellent                "
"                     https://github.com/ctaylo21/jarvis                       "
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
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" === FZF === "
nnoremap <leader>t :GitFiles<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>m :Marks<CR>

imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-f> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

command! -nargs=* F Rg <args>

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Transparent popup-menu
set pumblend=10

" Transparent floating windows
set winblend=10

" Editor theme
set background=dark
colorscheme gruvbox " OceanicNext

" Reload vim config after 'tt' in normal mode
nnoremap <leader>tt :so $MYVIMRC<CR>

" Add custom highlights in method that is executed every time a
" colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
" details
function! MyHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom or right
set splitbelow
set splitright

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Make background transparent for many things
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=NONE guibg=NONE
hi! SignColumn ctermfg=NONE guibg=NONE

" Try to hide vertical spit and end of buffer symbol
hi! VertSplit gui=NONE guifg=#282828 guibg=NONE
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === vim-better-whitespace === "
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

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

" Expand visual selection by pressing 'v' multiple times
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

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

" Set better diffing algorithm
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

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
