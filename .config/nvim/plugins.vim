" ============================================================================ "
"               Heavily inspired and copy pasted from excellent                "
"                     https://github.com/ctaylo21/jarvis                       "
" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" For better brackets closing
Plug 'tpope/vim-surround'

" For expanding and shrinking visual selection by pressing 'v' multiple times
Plug 'terryma/vim-expand-region'

" Let's make parents great again
Plug 'luochen1990/rainbow'

" auto-close plugin
Plug 'rstacruz/vim-closer'

" Make commenting great again
Plug 'tpope/vim-commentary'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Display marks
Plug 'kshenoy/vim-signature'

" For tmux-resurrect to be able to save sessions
Plug 'tpope/vim-obsession'

" Let's visualize the undolist "
Plug 'mbbill/undotree'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tmux/Neovim movement integration
Plug 'christoomey/vim-tmux-navigator'

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" Because denite is slow
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc'

" === Syntax Highlighting === "

Plug 'sheerun/vim-polyglot'
Plug 'jparise/vim-graphql', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'

" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'gruvbox-community/gruvbox'
Plug 'mhartington/oceanic-next'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Initialize plugin system
call plug#end()
