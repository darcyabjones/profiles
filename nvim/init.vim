call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim',{'as':'dracula'}

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
let &colorcolumn=join(range(81,999),",")

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

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1

" Deoplete - autocompletion
let g:deoplete#enable_at_startup = 1

" Airline settings
" Enables status bar to be always on
set laststatus=2

let g:airline_theme='dracula'

" invisible character colours
highlight NonText ctermfg=59 guifg=#697098
highlight SpecialKey ctermfg=59 ctermbg=none guifg=#697098
highlight ColorColumn ctermbg=59 guibg=#282a36
