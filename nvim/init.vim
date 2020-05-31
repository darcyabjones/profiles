call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'kassio/neoterm'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'plasticboy/vim-markdown'

call plug#end()

" Basic stuff

" be iMproved
set nocompatible

" Use system clipboard by default
set clipboard=unnamedplus

syntax on

" mouse stuff
set mouse=a

" Line numbers
set number

set ruler " Always show cursor

"Refresh rate in milliseconds
set updatetime=250

set incsearch " do incremental searching
set showcmd " display incomplete commands

" this enables "visual" wrapping
set wrap

" make it obvious where 80 chars is
set colorcolumn=80
"let &colorcolumn=join(range(81,999),",")

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0
set wrapmargin=0


" Open new splits to right and bottom
set splitbelow
set splitright

" Slightly nicer tab completion in ex
set wildmenu

" Enable invisible characters
set list
set listchars=tab:˒\ ,trail:-


" Indentation defaults
" by default, the indent is 4 spaces.
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" for html/rb files, 2 spaces
autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" for html/rb files, 2 spaces
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" for html/rb files, 2 spaces
autocmd Filetype r setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Disable weird R indentation
let r_indent_align_args = 0

" Set vim-r-plugin to mimics ess :
let r_indent_ess_comments = 0
let r_indent_ess_compatible = 0

" Disable automatic folding of markdown
let g:vim_markdown_folding_disabled = 1

" Colour and font settings
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme dracula "palenight

" Deoplete - autocompletion
let g:deoplete#enable_at_startup = 1

filetype off
let &runtimepath.=',~/.vim/bundle/neoterm'
filetype plugin on

" Use gx{text-object} in normal mode
nmap gf <Plug>(neoterm-repl-send)

" Send selected contents in visual mode.
xmap gf <Plug>(neoterm-repl-send)

nmap gff <Plug>(neoterm-repl-send-line)
let g:neoterm_autoinsert = 0
let g:neoterm_autoscroll = 1

tnoremap <Esc> <C-\><C-n>


" Airline settings
" Enables status bar to be always on
set laststatus=2

let g:airline_theme='dracula'

" invisible character colours
highlight NonText ctermfg=59 guifg=#697098
highlight SpecialKey ctermfg=59 ctermbg=none guifg=#697098
highlight ColorColumn ctermbg=236 guibg=#44475a


silent! helptags ALL
