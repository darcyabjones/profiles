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
	atlas atlas-devel atlas-sse2 atlas-sse3 \
	binutils \
	blas blas-devel \
	cairo cairo-devel cairo-tools \
	curl \
	emacs emacs-common emacs-filesystem emacs-nox \
	gawk \
	gcc gcc-c++ gcc-gfortran \
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
	postgresql postgresql-contrib postgresql-libs postgresql-server \
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
	vlc vlc-core \
	dropbox

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
wget -O $HOME/bin/sources/atom.rpm https://github.com/atom/atom/releases/download/v1.8.0/atom.x86_64.rpm
sudo dnf -y install $HOME/bin/sources/atom.rpm



sudo perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
sudo cpan -u

# Samtools

sudo dnf install -yq ncurses ncurses-libs ncurses-devel

su -c "wget -qO - https://github.com/samtools/htslib/releases/download/1.3.1/htslib-1.3.1.tar.bz2 \
    | tar xjf - -C /root && \
    cd /root/htslib-1.3.1 && \
    ./configure && make && make install"

su -c "wget -qO - https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2 \
    | tar xjf - -C /root && \
    cd /root/samtools-1.3.1 && \
    ./configure && make && make install"

su -c "wget -qO - https://github.com/samtools/bcftools/releases/download/1.3.1/bcftools-1.3.1.tar.bz2 \
    | tar xjf - -C /root && \
    cd /root/bcftools-1.3.1 && \
    make && make install"

# Bedtools

sudo mkdir /usr/local/bedtools
wget -O- https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz | tar -C $HOME/bin -zxf - && \
    cd $HOME/bin/bedtools2 && \
    make && \
    cd $HOME/bin && \
    sudo cp -r $HOME/bin/bedtools2 /usr/local/bedtools/2.25.0 && \
    sudo ln -s /usr/local/bedtools/2.25.0/bin/* /usr/local/bin

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

#
# Python
#


sudo pip3 install --upgrade pip
sudo pip2 install --upgrade pip

sudo pip3 install cython
sudo pip3 install numpy pandas scipy sympy matplotlib biopython jupyter virtualenv
sudo pip2 install cython
sudo pip2 install numpy pandas scipy sympy matplotlib biopython ipykernel ipython

sudo python2 -m ipykernel.kernelspec


#
# Nodejs
#
sudo dnf install -yq nodejs

sudo npm install -g ijavascript

#
# R
#
sudo dnf install -yq R-core R-core-devel libcurl libcurl-devel

sudo ln -sf $HOME/.profiles/Rprofile /root/.Rprofile
sudo Rscript -e "install.packages(c('pbdZMQ', 'repr', 'ggplot2', 'devtools', 'dplyr', 'knitr'))"
sudo Rscript -e "devtools::install_github('IRkernel/IRdisplay', force = TRUE)"
sudo Rscript -e "devtools::install_github('IRkernel/IRkernel', force = TRUE)"
sudo Rscript -e "IRkernel::installspec(name = 'ir330', displayname = 'R 3.3.0')"
Rscript -e "IRkernel::installspec(name = 'ir330', displayname = 'R 3.3.0')"
sudo Rscript -e "source('https://bioconductor.org/biocLite.R');biocLite()"
