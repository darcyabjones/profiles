#! /usr/bin/env bash

# This isn't really intended to be run as a script, you should run the commands 
# yourself to catch the various errors etc.

exit 1

#
# Generate an ssh key
#
ssh-keygen -t rsa -C "darcy.ab.jones@gmail.com"


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
ln -sf $PROFILES/inputrc $HOME/.inputrc
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
	atlas atlas-devel atlas-sse2 atlas-sse3 \
	binutils \
	blas blas-devel \
	cairo cairo-devel cairo-tools \
	curl \
	gawk \
	gcc gcc-c++ gcc-gfortran \
	ghc-base ghc-base-devel \
	ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-devel ghc-pandoc-types ghc-pandoc-types-devel \
	gimp gimp-libs \
	git git-core git-extras \
	gnome-tweak-tool \
	gparted \
	gpgme gpgme-devel pygpgme \
	graphviz graphviz-devel \
	htop \
	inkscape \
	java \
	libpng libpng-devel libpng-tools \
	libtiff libtiff-devel libtiff-tools \
	json-c-devel \
	kernel-devel \
	kernel-tools \
	latexmk \
	lapack lapack-devel \
	levien-inconsolata-fonts \
	libgnome-keyring-devel \
	gcc gcc-* \
	gmp gmp-devel \
	mpfr mpfr-devel \
	libmpc libmpc-devel \
	openssh openssh-* \
	openssl openssl-* \
	openvpn \
	pandoc pandoc-citeproc pandoc-pdf \
	qt qt-devel qt-x11 \
	qtwebkit qtwebkit-devel \
	redhat-lsb-core \
	rpm rpm-build rpm-build-libs rpm-libs rpm-python \
	rpmdevtools \
	samba-client samba-common samba-libs \
	sed \
	sqlite-devel \
	tcsh \
	texlive texlive-* \
	tmux \
	transmission-common transmission-gtk \
	vim vim-common vim-enhanced vim-filesystem vim-minimal \
	vpnc \
	wget \
	xclip \
	zeromq zeromq-devel \
	zsh

#
# rpmfusion ones
#
su -c 'dnf install -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
sudo dnf install -y \
	rpmfusion-free-release rpmfusion-nonfree-release \
	vlc vlc-core


#
# Docker
#

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/fedora/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo dnf install -yq docker-engine
sudo systemctl enable docker.socket docker.service
sudo systemctl start docker


#
# Antigen
#
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen

#
# Bit of perl config
#

sudo perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
sudo cpan -u


# install chrome
su -c "cat << EOF > /etc/yum.repos.d/google-chrome.repo \
[google-chrome] \
name=google-chrome - \$basearch \
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch \
enabled=1 \
gpgcheck=1 \
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub \
EOF \
"
sudo dnf install -yq google-chrome-stable


