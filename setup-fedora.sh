#! /usr/bin/env bash

#
# Generate an ssh key
#
ssh-keygen -t rsa -C "darcy.ab.jones@gmail.com" -N ""


# Creates a new ssh key, using the provided email as a label
# nb the spaces here are important because they use the default ssh location.
# start the ssh-agent in the background
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo "Add your SSH key to your account"
sudo dnf install -y xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard

#
# Setup git
#

git config --global user.name "Darcy Jones"
git config --global user.email darcy.ab.jones@gmail.com

export PROFILES=$HOME/.profiles

#
# Clone this repository
#
git clone git@github.com:darcyabjones/profiles.git $PROFILES

#
# Link the profile files to the home dir
#
ln -sf $PROFILES/aliases $HOME/.aliases
ln -sf $PROFILES/bash_profile $HOME/.bash_profile
ln -sf $PROFILES/bashrc $HOME/.bashrc
ln -sf $PROFILES/env $HOME/.env
ln -sf $PROFILES/Rprofile $HOME/.Rprofile
ln -sf $PROFILES/tmux.conf $HOME/.tmux.conf
ln -sf $PROFILES/zshrc $HOME/.zshrc

#
# Create some new folders
#
mkdir $HOME/bin
mkdir $HOME/bin/sources
export SOURCES=$HOME/bin/sources
mkdir $HOME/projects
mkdir $HOME/communication
mkdir $HOME/data

#
# Install the basic packages from the fedora repo
#
sudo dnf -y update
sudo dnf install -y \
	bibutils* \
	cups cups-libs \
	curl \
	docker-io \
	emacs emacs-common emacs-filesystem emacs-nox \
	gawk \
	ghc-base ghc-base-devel \
	ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-devel ghc-pandoc-types ghc-pandoc-types-devel \
	gimp gimp-libs \
	git git-core git-extras \
	git-annex git-annex-docs \
	gnome-tweak-tool \
	gparted \
	gpgme gpgme-devel pygpgme \
	graphviz graphviz-devel \
	htop \
	inkscape \
	java \
	json-c-devel \
	kernel-devel \
	latexmk \
	levien-inconsolata-fonts \
	libgnome-keyring-devel \
	gmp gmp-devel \
	mpfr mpfr-devel \
	libmpc libmpc-devel \
	openssh openssh-* \
	openssl openssl-* \
	openvpn \
	pandoc pandoc-citeproc pandoc-pdf \
	postgresql postgresql-contrib postgresql-libs postgresql-server \
	qt qt-devel qt-x11 \
	qtwebkit qtwebkit-devel \
	rpm rpm-build rpm-build-libs rpm-libs rpm-python \
	rpmdevtools \
	samba-client samba-common samba-libs \
	sed \
	tcsh \
	texlive texlive-* \
	tmux \
	transmission-common transmission-gtk \
	vim vim-common vim-enhanced vim-filesystem vim-minimal \
	vpnc \
	wget \
	xclip \
	zsh

#
# rpmfusion ones
#
su -c 'dnf install -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
sudo dnf install -y \
	rpmfusion-free-release rpmfusion-nonfree-release \
	vlc vlc-core \
	dropbox


#
# clone my own git repos
#
git clone git@github.com:darcyabjones/bioutils.git $HOME/bin/bioutils
git clone git@github.com:darcyabjones/darcyabjones.github.io.git $HOME/bin/darcyabjones.github.io
git clone git@github.com:darcyabjones/darcyabjones.net.git $HOME/bin/darcyabjones.net
git clone git@github.com:darcyabjones/phylomake.git $HOME/bin/phylomake
git clone git@github.com:XenoProject/Xenophyle.git $HOME/bin/Xenophyle
git clone git@github.com:XenoProject/xenophyle.com.git $HOME/bin/xenophyle.com
git clone git@github.com:darcyabjones/module-install.git $HOME/bin/module-install
git clone git@github.com:darcyabjones/gi-to-tax.git $HOME/bin/gi-to-tax
git clone git@github.com:darcyabjones/bioplotlib.git $HOME/bin/bioplotlib
git clone git@github.com:darcyabjones/lcthw.git $HOME/bin/lcthw
git clone git@github.com:darcyabjones/pannot.git $HOME/bin/pannot
git clone git@github.com:darcyabjones/gannot.git $HOME/bin/gannot

#
# Antigen
#
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen


#
# Atom
#
sudo rpm -Uhv https://atom.io/download/rpm
sudo dnf -y install atom



sudo perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
sudo cpan -u
#sudo cpan -i SOAP::Lite
#sudo cpan -i Archive::Tar
#sudo cpan -i List::MoreUtils

#
# Heroku
#
wget -qO- https://toolbelt.heroku.com/install.sh | sudo sh
sudo ln -sf /usr/local/heroku/bin/heroku /usr/local/bin/heroku

#
# Change the default shell to zsh
#
sudo chsh -s /usr/bin/zsh $USER

