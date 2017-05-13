# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export DIR_4_TCOFFEE="/home/darcy/.tcoffee/Version_11.00.8cbe486"

export MAFFT_BINARIES="$DIR_4_TCOFFEE/plugins/linux/"

export CACHE_4_TCOFFEE="/home/darcy/.t_coffee/cache/"

export TMP_4_TCOFFEE="$DIR_4_TCOFFEE/tmp/"

export LOCKDIR_4_TCOFFEE="$DIR_4_TCOFFEE/lck/"

export PERL5LIB="$PERL5LIB:$DIR_4_TCOFFEE/perl/lib/perl5"

export EMAIL_4_TCOFFEE="darcy.ab.jones@gmail.com"

export PATH="$DIR_4_TCOFFEE/bin:$PATH"
