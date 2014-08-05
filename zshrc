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

# Paths

source $HOME/.paths

# Aliases

source $HOME/.aliases

# ENV variables

source $HOME/.env

# OH-MY-ZSH settings

plugins=(git osx python)