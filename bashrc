# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

##########################################################################
# Paths

source $HOME/.paths

##########################################################################
# Aliases

source $HOME/.aliases

##########################################################################
# ENV variables

source $HOME/.env
