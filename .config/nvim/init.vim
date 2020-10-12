scriptencoding utf-8
source ~/.config/nvim/plugins.vim

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
set foldmethod=indent " Use decent folding

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

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* F call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" --colors "path:fg:blue" --colors "match:fg:white" --colors "match:bg:yellow" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" command! -bang -nargs=* F
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
"   \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
"   \   <bang>0)

" https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294
" let $FZF_DEFAULT_OPTS='--layout=reverse'
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" function! FloatingFZF()
"   let buf = nvim_create_buf(v:false, v:true)
"   call setbufvar(buf, '&signcolumn', 'no')

"   let height = 20
"   let width = float2nr(&columns - (&columns * 2 / 10))
"   let col = float2nr((&columns - width) / 2)

"   let opts = {
"         \ 'relative': 'editor',
"         \ 'row': 1,
"         \ 'col': col,
"         \ 'width': width,
"         \ 'height': height
"         \ }

"   call nvim_open_win(buf, v:true, opts)
" endfunction

" === JSDoc === "
let g:jsdoc_enable_es6 = 1
let g:jsdoc_allow_input_prompt = 0
let g:jsdoc_input_description = 1
let g:jsdoc_param_description_separator = ': '
let g:jsdoc_additional_descriptions = 1
let g:jsdoc_enable_es6 = 1

" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" === Vim airline ==== "
" Enable extensions
let g:airline_theme='gruvbox'

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Disable vim-airline in preview mode
let g:airline_exclude_preview = 1

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

" === vim-javascript === "
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" === vim-jsx === "
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 0

" === Signify === "
let g:signify_sign_delete = '-'

" Rainbow Parentheses
let g:rainbow_active = 1

let s:rainbow_conf = {
\	'guifgs': ['Green', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['Green', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'contains_prefix': 'TOP',
\       'after': ['syn clear typescriptObjectLiteral'],
\	'parentheses_options': 'containedin=typescriptMember,typescriptBlock',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained',
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\		},
\		'tex': {
\			'parentheses_options': 'containedin=texDocZone',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody,vimExecute',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
\		},
\		'xml': {
\			'syn_name_prefix': 'xmlRainbow',
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'xhtml': {
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow',
\		},
\		'php': {
\			'syn_name_prefix': 'phpBlockRainbow',
\			'contains_prefix': '',
\			'parentheses': ['start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold contains_prefix=TOP'],
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\		},
\		'css': 0,
\		'sh': 0,
\	}
\}

nnoremap <f1> :echo synIDattr(synID(line('.'), col('.'), 0), 'name')<cr>
nnoremap <f2> :echo ("hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">")<cr>
nnoremap <f3> :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>
nnoremap <f4> :exec 'syn list '.synIDattr(synID(line('.'), col('.'), 0), 'name')<cr>

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Editor theme
set background=dark
colorscheme gruvbox " OceanicNext

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'medium'
let g:gruvbox_invert_selection = 0

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
hi! VertSplit gui=NONE guifg=#17252c guibg=NONE
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
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" === Search shorcuts === "
"   <leader>h - Find and replace
map <leader>h :%s/

" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>w <Plug>(easymotion-bd-w)

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
" nmap <leader>z :JsDoc<CR>

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

" Add common CHADTree commands for location a current file or just toggling it
nmap <leader>nt :CHADopen<CR>

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

nnoremap <leader>g :Gblame<CR>

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

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

" ============================================================================ "
" ===                                 LSP                                  === "
" ============================================================================ "

" Recommended settings for nvim-lua/completion-nvim
let g:completion_enable_snippet = 'UltiSnips'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

lua << EOF

local lspconfig = require("lspconfig")
local completion = require("completion")

local on_attach = function(client, bufnr)
    print("'" .. client.name .. "' language server started" )
    completion.on_attach()

    -- Avoid TSServer clashing with Prettier
    client.resolved_capabilities.document_formatting = false

    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.goto_next({ severity = "Error" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.goto_prev({ severity = "Error" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rr', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
end

-- https://github.com/neovim/neovim/pull/12655
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

lspconfig.tsserver.setup{ on_attach = on_attach }
lspconfig.html.setup{ on_attach = on_attach }
lspconfig.gopls.setup{ on_attach = on_attach }
lspconfig.cssls.setup{ on_attach = on_attach }


vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end

  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_command("noautocmd :update")
    end
  end
end

local efm_on_attach = function(client)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.api.nvim_command [[augroup END]]
  end
end

lspconfig.efm.setup{ on_attach = efm_on_attach }

EOF

" ============================================================================ "
" ===                                 TEST.                                === "
" ============================================================================ "

" neovim 0.4.0+: transparent popup-menu
if exists('&pumblend')
    set pumblend=10
endif

" neovim 0.4.0+: transparent floating windows
if exists('&winblend')
    set winblend=10
endif

let g:echodoc_enable_at_startup=1

if has("nvim-0.4.0")
    let g:echodoc#type="floating"
else
    let g:echodoc#type="echo"
endif

" https://www.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim
if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif
