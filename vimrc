" Basic stuff

" Use system clipboard by default
set clipboard=unnamedplus

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
set listchars=tab:˒\ ,eol:¬,trail:-

" Search into subfolders
" Tab completion when matching files in buffer
"set path+=**

" Enable xterm style C-Arrow cursor movements when in TMUX
" See https://sunaku.github.io/vim-256color-bce.html for more
if &term =~ '^screen'
	" tmux will send xterm-style keys when its xterm-keys option is on
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
	
	" Page Keys
	" Seems to work without these
	" execute "set t_kP=\e[5;*~"
	" execute "set t_kN=\e[6;*~"
endif

" Clean up some colour stuff that gets weird in xterm-256 envs
if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

" Setup Vundle package manager 

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9}

Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'dracula/vim' " Colour theme
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'jpalardy/vim-slime'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline settings
" Enables status bar to be always on
set laststatus=2

" Set slime target to be tmux terminal by default
" Requires that a tmux session be active
let g:slime_target = "tmux"

" Set theme
syntax on
color dracula
		

" invisible character colours
highlight NonText ctermfg=61
highlight SpecialKey ctermfg=61 ctermbg=none


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
