# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

##########################################################################
# Aliases

source "${HOME}/.profiles/aliases"

##########################################################################
# ENV variables

source "${HOME}/.profiles/env"

# added by travis gem
[ -f /home/darcyabjones/.travis/travis.sh ] && source /home/darcyabjones/.travis/travis.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/darcyabjones/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/darcyabjones/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/darcyabjones/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/darcyabjones/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
