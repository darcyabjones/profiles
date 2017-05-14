# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


### Paths etc
source $HOME/.aliases
source $HOME/.env


### Antigen Stuff ###
source $HOME/.antigen/antigen.zsh

#
# Load the oh-my-zsh's library.
#
antigen use oh-my-zsh
antigen bundle robbyrussell/oh-my-zsh lib/

#
# Antigen Theme
#

antigen theme darcyabjones/profiles darcy
#antigen theme https://github.com/dracula/zsh.git dracula

#
# Antigen Bundles
#
antigen bundle git
antigen bundle git-extras

# antigen bundle tmuxinator
# antigen bundle tmux
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle rupa/z
antigen bundle docker
antigen bundle ssh-agent
antigen bundle gnu-utils

#antigen bundle atom

antigen bundle node


# Python Plugins
antigen bundle pip
antigen bundle pyenv
# antigen bundle python
antigen bundle virtualenv
antigen bundle pep8

# OS specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle gem
    antigen bundle osx
elif [[ $CURRENT_OS == 'Linux' ]]; then
    # None so far...

    if [[ $DISTRO == 'CentOS' ]]; then
        antigen bundle centos
    fi
    if [[ $DISTRO == 'Fedora' ]]; then
        antigen bundle dnf
	antigen bundle fedora
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    antigen bundle cygwin
fi
antigen bundle debian

# Tell antigen that you're done.
antigen apply

# Vim style keybindings
set -o vi
bindkey -v

# Update mode change register to 0.1 sec
export KEYTIMEOUT=1
