# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/home/darcyabjones/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

# Paths

source /home/darcyabjones/.paths

# Aliases

source /home/darcyabjones/.aliases

PERL_MB_OPT="--install_base \"/home/darcyabjones/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/darcyabjones/perl5"; export PERL_MM_OPT;
