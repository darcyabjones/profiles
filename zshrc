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

### AWS autocompletion
source ~/.local/bin/aws_zsh_completer.sh


### Antigen Stuff ###
source $HOME/.antigen/antigen.zsh

#
# Load the oh-my-zsh's library.
#
antigen use oh-my-zsh
antigen bundle robbyrussell/oh-my-zsh lib/

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
antigen bundle history-substring-search

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


# Temporary fix for mv cannot stat error.
# See: https://github.com/robbyrussell/oh-my-zsh/issues/7094
if [ "$_Z_NO_RESOLVE_SYMLINKS" ]; then
    _z_precmd() {
        (_z --add "${PWD:a}" &)
		: $RANDOM
    }
else
    _z_precmd() {
        (_z --add "${PWD:A}" &)
		: $RANDOM
    }
fi

# Vim style keybindings
#set -o vi
#bindkey -v

# Update mode change register to 0.1 sec
#export KEYTIMEOUT=1

#bindkey -M viins "^[[1;5C" forward-word
#bindkey -M viins "^[[1;5D" backward-word
#bindkey -M vicmd "^[[1;5C" forward-word
#bindkey -M vicmd "^[[1;5D" backward-word

# Re-enable default UP/Down history search

#bindkey '^R' history-incremental-search-backward

#bindkey -M viins '^[[A' up-line-or-search
#bindkey -M viins '^[[B' down-line-or-search

#
# Antigen Theme
#

antigen theme darcyabjones/profiles darcy
#antigen theme https://github.com/dracula/zsh.git dracula

# Tell antigen that you're done.
antigen apply
