# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/darcy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


### Paths etc
source $HOME/.aliases
source $HOME/.env
source $HOME/.paths


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
antigen theme darcy 

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
antigen bundle emacs
antigen bundle postgres
antigen bundle atom


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
        antigen bundle yum
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    antigen bundle cygwin
fi

# Tell antigen that you're done.
antigen apply


