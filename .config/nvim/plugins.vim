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
" Let's be a good colleague
Plug 'editorconfig/editorconfig-vim'

" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" For better brackets operations
Plug 'tpope/vim-surround'

" For expanding and shrinking visual selection by pressing 'v' multiple times
Plug 'terryma/vim-expand-region'

" Let's make parents great again
Plug 'luochen1990/rainbow'

" auto-close plugin
Plug 'jiangmiao/auto-pairs'

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

" Tmux/Neovim movement integration
Plug 'christoomey/vim-tmux-navigator'

" Fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" === UI === "
" File explorer
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

" Colorscheme
Plug 'gruvbox-community/gruvbox'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Snippets
Plug 'honza/vim-snippets'

" Let's set up Neovim LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'

" Initialize plugin system
call plug#end()
