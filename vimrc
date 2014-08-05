" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


"set autoindent		" always set autoindenting on
set history=50		" keep 50 lines of command line history
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wrap
set linebreak "tells Vim to only wrap at a character in the breakat option (by default, this includes  ^I!@*-+;:,./?
set nolist "list disables linebreak
set nospell 		" turns off spell check for all files
" autocmd BufNewFile,BufRead *.txt,*.html,README set spell "turns on spell check only for specified files
set paste		" turns on traditional pasting of text
set number 		" turns line numbering on
colorscheme elflord	" sets color scheme;  default (black bkgr), torte (black bgr), murphy (black bkgr), elflord (black bkgr), blue (blue bkgr), morning (white bkgr), shine (white bkgr) 
set ruler		" show the cursor position all the time

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Map custom keys how i want

imap [F <esc>wi
imap [H <esc>bi
vmap [F w
vmap [H b
nmap [F w
nmap [H b
