#! /usr/bin/env bash

export $PROFILES=$HOME/.profiles
#
# Link the profile files to the home dir
#
ln -s $PROFILES/aliases $HOME/.aliases
ln -s $PROFILES/bash_profile $HOME/.bash_profile
ln -s $PROFILES/bashrc $HOME/.bashrc
ln -s $PROFILES/emacs $HOME/.emacs
ln -s $PROFILES/env $HOME/.env
ln -s $PROFILES/paths $HOME/.paths
ln -s $PROFILES/Rprofile $HOME/.Rprofile
ln -s $PROFILES/tmux.conf $HOME/.tmux.conf
ln -s $PROFILES/vimrc $HOME/.vimrc
ln -s $PROFILES/zshrc $HOME/.zshrc

#
# Create some new folders
#
mkdir $HOME/bin
mkdir $HOME/bin/sources
export SOURCES=$HOME/bin/sources
mkdir $HOME/bib
mkdir $HOME/research
mkdir $HOME/data

#
# Install the basic yum packages from the fedora repo
#
sudo yum -y update
sudo yum install -y alien
sudo yum install -y argtable argtable-devel
sudo yum install -y autoconf
sudo yum install -y automake
sudo yum install -y bash
sudo yum install -y bash-completion
sudo yum install -y bibutils bibutils-devel bibutils-libs
sudo yum install -y cairo cairo-devel cairo-gobject cairo-gobject-devel
sudo yum install -y cmake
sudo yum install -y cpp
sudo yum install -y cups cups-libs
sudo yum install -y curl
sudo yum install -y docker-io
sudo yum install -y emacs emacs-common emacs-filesystem emacs-nox
sudo yum install -y gawk
sudo yum install -y gcc gcc-c++ gcc-gfortran
sudo yum install -y ghc-base
sudo yum install -y ghc-base-devel
sudo yum install -y ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-devel ghc-pandoc-types ghc-pandoc-types-devel
sudo yum install -y gimp gimp_libs
sudo yum install -y git git-core git-extras
sudo yum install -y git-annex git-annex-docs
sudo yum install -y glibc-devel
sudo yum install -y htop
sudo yum install -y inkscape
sudo yum install -y java
sudo yum install -y kernel-devel
sudo yum install -y latexmk
sudo yum install -y levien-inconsolata-fonts
sudo yum install -y libgcrypt libgcrypt-devel
sudo yum install -y libgnome-keyring-devel
sudo yum install -y libpng libpng-devel
sudo yum install -y nodejs
sudo yum install -y npm
sudo yum install -y openmpi openmpi-devel
sudo yum install -y openssh openssh-clients openssh-server
sudo yum install -y openssl openssl-devel openssl-libs openssl-static
sudo yum install -y openvpn
sudo yum install -y pandoc pandoc-citeproc pandoc-pdf
sudo yum install -y postgresql postgresql-contrib postgresql-libs postgresql-server
sudo yum install -y qt qt-devel qt-x11
sudo yum install -y qtwebkit qtwebkit-devel
sudo yum install -y readline readline-devel readline-static
sudo yum install -y rpm rpm-build rpm-build-libs rpm-libs rpm-python
sudo yum install -y rpmdevtools
sudo yum install -y samba-client samba-common samba-libs
sudo yum install -y sed
sudo yum install -y sqlite sqlite-devel sqlite-doc sqlite-tcl
sudo yum install -y texlive texlive-base
sudo yum install -y tk tk-devel
sudo yum install -y tkinker
sudo yum install -y tmux
sudo yum install -y transmission-common transmission-gtk
sudo yum install -y vim vim-common vim-enhanced vim-filesystem vim-minimal
sudo yum install -y vpnc
sudo yum install -y wget
sudo yum install -y xclip
sudo yum install -y zsh

#
# Add special repositories
#
sudo cp $PROFILES/repos/* /etc/yum.repos.d/
sudo yum update

#
# Spotify
#
sudo yum-config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo yum -y install spotify-client
#
# Fedy
#
su -c "curl https://satya164.github.io/fedy/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer && rm ./fedy-installer"
sudo fedy --exex rpmfusion_repos
sudo fedy --exec google_chrome
sudo fedy --exec nautilus_dropbox
sudo fedy --exec oracle_jdk
sudo fedy --exec skype_linux
sudo fedy --exec sublime_text3
sudo fedy --exec adobe_flash
sudo fedy --exec disk_io_scheduler
sudo fedy --exec dvd_playback
sudo fedy --exec media_codecs
sudo fedy --exec oracle_jre

#
# chromium
#
sudo yum install -y chromium

#
# rpmfusion ones
#
sudo yum install -y rpmfusion-free-release rpmfusion-nonfree-release 
sudo yum install -y akmod-wl
sudo yum install -y akmods
sudo yum install -y vlc vlc-core

#
# Check that broadcom drivers are running
#
# Make sure the module built for your kernel
sudo akmods
# See if the module is loaded (if no results, it's not)
sudo lsmod | grep wl
# Manually load the module
sudo modprobe wl

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
xclip -sel clip < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard

#
# Setup git
#
git config --global user.name "Darcy Jones"
git config --global user.email darcy.ab.jones@gmail.com

#
# clone my own git repos
#
git clone git@github.com:darcyabjones/bioutils.git $HOME/bin/bioutils
git clone git@github.com:darcyabjones/code-seq-name.git $HOME/bin/code-seq-name
git clone git@github.com:darcyabjones/concatenate-phylip.git $HOME/bin/concatenate-phylip
git clone git@github.com:darcyabjones/darcyabjones.github.io.git $HOME/bin/darcyabjones.github.io
git clone git@github.com:darcyabjones/darcyabjones.net.git $HOME/bin/darcyabjones.net
git clone git@github.com:darcyabjones/deduplicate.git $HOME/bin/deduplicate
git clone git@github.com:darcyabjones/gi-to-tax.git $HOME/bin/gi-to-tax
git clone git@github.com:darcyabjones/headwater.git $HOME/bin/headwater
git clone git@github.com:darcyabjones/inverseGFF.git $HOME/bin/inverseGFF
git clone git@github.com:darcyabjones/mcl-to-kaks.git $HOME/bin/mcl-to-kaks
git clone git@github.com:darcyabjones/phylomake.git $HOME/bin/phylomake
git clone git@github.com:darcyabjones/quick-ortho-fetch.git $HOME/bin/quick-ortho-fetch
git clone git@github.com:XenoProject/Xenophyle.git $HOME/bin/Xenophyle
git clone git@github.com:XenoProject/xenophyle.com.git $HOME/bin/xenophyle.com

git clone git@github.com:darcyabjones/markdown.git $HOME/Templates/markdown
git clone git@github.com:darcyabjones/tex.git $HOME/Templates/tex

#
# mendeley
#
wget -t 3 http://www.mendeley.com/client/get/100-2 -O $SOURCES/mendeleydesktop-x86_64.tar.bz2
tar -xjf $SOURCES/mendeleydesktop-x86_64.tar.bz2 -C $SOURCES
sudo mv $SOURCES/mendeleydesktop-x86_64 /usr/local/mendeleydesktop
sudo ln -s /usr/local/mendeleydesktop/bin/mendeleydesktop /usr/local/bin/mendeleydesktop

#
# Install antigen
#
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen

#
# Install atom
#
cd $HOME/Downloads

git clone https://github.com/atom/atom $SOURCES/atom
cd $SOURCES/atom
git fetch -p
git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
script/build
script/grunt install

cd $HOME

#
# Install the python distributions
#
wget -t 3 https://bootstrap.pypa.io/ez_setup.py -O $SOURCES/ez_setup.py

wget -t 3 https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz -O $SOURCES/Python-3.4.2.tgz
tar -zxf $SOURCES/Python-3.4.2.tgz -C $SOURCES
cd $SOURCES/Python-3.4.2
./configure
make
sudo make install
sudo python3.4 $SOURCES/ez_setup.py
sudo easy_install-3.4 pip 
sudo pip3.4 install virtualenv
cd $HOME

wget -t 3 https://www.python.org/ftp/python/3.3.6/Python-3.3.6.tgz -O $SOURCES/Python-3.3.6.tgz
tar -zxf $SOURCES/Python-3.3.6.tgz -C $SOURCES
cd $SOURCES/Python-3.3.6
./configure
make
sudo make altinstall
sudo python3.3 $SOURCES/ez_setup.py
sudo easy_install-3.3 pip 
sudo pip3.3 install virtualenv
cd $HOME

wget -t 3 https://www.python.org/ftp/python/3.2.6/Python-3.2.6.tgz -O $SOURCES/Python-3.2.6.tgz
tar -zxf $SOURCES/Python-3.2.6.tgz -C $SOURCES
cd $SOURCES/Python-3.2.6
./configure
make
sudo make altinstall
sudo python3.2 $SOURCES/ez_setup.py
sudo easy_install-3.2 pip 
sudo pip3.2 install virtualenv
cd $HOME

wget -t 3 https://www.python.org/ftp/python/3.1.5/Python-3.1.5.tgz -O $SOURCES/Python-3.1.5.tgz
tar -zxf $SOURCES/Python-3.1.5.tgz -C $SOURCES
cd $SOURCES/Python-3.1.5
./configure
make
sudo make altinstall
sudo python3.1 $SOURCES/ez_setup.py
sudo easy_install-3.1 pip 
sudo pip3.1 install virtualenv
cd $HOME

wget -t 3 https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz -O $SOURCES/Python-2.7.8.tgz
tar -zxf $SOURCES/Python-2.7.8.tgz -C $SOURCES
cd $SOURCES/Python-2.7.8
./configure
make
sudo make altinstall
sudo python2.7 $SOURCES/ez_setup.py
sudo easy_install-2.7 pip 
sudo pip2.7 install virtualenv
cd $HOME

wget -t 3 https://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz -O $SOURCES/Python-2.6.9.tgz
tar -zxf $SOURCES/Python-2.6.9.tgz -C $SOURCES
cd $SOURCES/Python-2.6.9
./configure
make
sudo make altinstall
sudo python2.6 $SOURCES/ez_setup.py
sudo easy_install-2.6 pip 
sudo pip2.6 install virtualenv
cd $HOME

#
# Install the R distributions
#
wget -t 3 http://cran.ms.unimelb.edu.au/src/base/R-3/R-3.1.2.tar.gz -O $SOURCES/R-3.1.2.tar.gz
tar -zxf $SOURCES/R-3.1.2.tar.gz -C $SOURCES
cd $SOURCES/R-3.1.2
./configure
make && make check && sudo make install

sudo chmod o+w -R /usr/local/lib64/R/

cd $HOME

#
# RStudio
#
cd $HOME/Downloads
wget -t 3 http://download1.rstudio.org/rstudio-0.98.1091-x86_64.rpm -O $SOURCES/rstudio-0.98.1091-x86_64
sudo yum --nogpgcheck localinstall $SOURCES/rstudio-0.98.1091-x86_64

#
# Julia
#
sudo mkdir /usr/local/julia

git clone git@github.com:JuliaLang/julia.git $SOURCES/julia
cd $SOURCES/julia
git checkout release-0.3
make
cd $HOME
sudo mv $SOURCES/julia /usr/local/julia/0.3
sudo ln -s /usr/local/julia/0.3/julia /usr/local/bin/julia
sudo ln -s /usr/local/julia/0.3/julia /usr/local/bin/julia-0.3

#
# Heroku
#
cd $HOME/Downloads
wget -qO- https://toolbelt.heroku.com/install.sh | sudo sh

cd $HOME

#
# Install some bio-packages
#

# BEAGLE
cd $HOME/Downloads
svn checkout http://beagle-lib.googlecode.com/svn/trunk/ beagle-lib
cd beagle-lib
./autogen.sh
./configure
make install
# export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH

cd $HOME

# BEAST
cd $HOME/Downloads
sudo mkdir /usr/local/beast

wget -t 3 http://tree.bio.ed.ac.uk/download.php?id=91&num=3 -O $SOURCES/BEAST-1.8.1.tgz
tar -zxf $SOURCES/BEAST-1.8.1.tgz -C $SOURCES

cd $HOME

# BLAST+
cd $HOME/Downloads
sudo mkdir /usr/local/blast

wget -t 3 ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.30/ncbi-blast-2.2.30+-src.tar.gz -O $SOURCES/ncbi-blast-2.2.30+-src.tar.gz
tar -zxf $SOURCES/ncbi-blast-2.2.30+-src.tar.gz -C $SOURCES

cd $HOME

# BWA
cd $HOME/Downloads
sudo mkdir /usr/local/bwa

wget -t 3 http://sourceforge.net/projects/bio-bwa/files/bwa-0.7.10.tar.bz2/download -O bwa-0.7.10.tar.bz2
tar -xjf $SOURCES/bwa-0.7.10.tar.bz2 -C $SOURCES

cd $HOME

# Clustal-O
cd $HOME/Downloads
sudo mkdir /usr/local/clustalo

wget -t 3 http://www.clustal.org/omega/clustal-omega-1.2.1.tar.gz -O $SOURCES/clustal-omega-1.2.1.tar.gz
tar -zxf $SOURCES/clustal-omega-1.2.1.tar.gz -C $SOURCES
cd $SOURCES/clustal-omega-1.2.1
./configure
make && make check
#sudo mv $SOURCES/clustal-omega-1.2.1 /usr/local/clustalo/1.2.1
#sudo ln -s /usr/local/clustalo/1.2.1 /usr/local/bin/clustalo
#sudo ln -s /usr/local/clustalo/1.2.1 /usr/local/bin/clustalo-1.2.1

cd $HOME

# Clustalw2
cd $HOME/Downloads
sudo mkdir /usr/local/clustalw
wget -t 3 http://www.clustal.org/download/current/clustalw-2.1.tar.gz -O $SOURCES/clustalw-2.1.tar.gz
tar -zxf $SOURCES/clustalw-2.1.tar.gz -C $SOURCES
cd $SOURCES/clustalw-2.1
./configure
make && make check
sudo mv $SOURCES/clustalw-2.1 /usr/local/clustalw/2.1
#sudo ln -s /usr/local/clustalw/2.1/ /usr/local/bin/clustalw
#sudo ln -s /usr/local/clustalw/2.1/ /usr/local/bin/clustalw2
#sudo ln -s /usr/local/clustalw/2.1/ /usr/local/bin/clustalw-2.1
cd $HOME

# Dialign
cd $HOME/Downloads
sudo mkdir /usr/local/dialign

wget -t 3 http://dialign.gobics.de/download/dialign_package.tgz -O $HOME/dialign_package.tgz
tar -zxf $HOME/dialign_package.tgz -C $SOURCES

cd $HOME

# Dialign-TX
cd $HOME/Downloads
sudo mkdir /usr/local/dialign-tx

wget -t 3 http://dialign-tx.gobics.de/DIALIGN-TX_1.0.2.tar.gz -O $SOURCES/DIALIGN-TX_1.0.2.tar.gz
tar -zxf $SOURCES/DIALIGN-TX_1.0.2.tar.gz -C $SOURCES

cd $HOME

# Diamond
cd $HOME/Downloads
sudo mkdir /usr/local/diamond

wget -t 3 http://www-ab.informatik.uni-tuebingen.de/data/software/diamond/download/public/diamond.tar.gz -O $SOURCES/diamond.tar.gz
tar -zxf $SOURCES/diamond.tar.gz -C $SOURCES

# Entrez Direct
cd $HOME/Downloads
sudo mkdir /usr/local/edirect

wget -t 3 ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz -O $SOURCES/edirect.tar.gz
tar -zxf $SOURCES/edirect.tar.gz -C $SOURCES

cd $HOME

# Figtree
cd $HOME/Downloads
sudo mkdir /usr/local/figtree

wget -t 3 http://tree.bio.ed.ac.uk/download.php?id=90&num=3 -O $SOURCES/FigTree_v1.4.2.tgz
tar -zxf $SOURCES/FigTree_v1.4.2.tgz -C $SOURCES

cd $HOME

# HMMER
cd $HOME/Downloads
sudo mkdir /usr/local/hmmer

wget -t 3 ftp://selab.janelia.org/pub/software/hmmer3/3.1b1/hmmer-3.1b1.tar.gz -O $SOURCES/hmmer-3.1b1.tar.gz
tar -zxf $SOURCES/hmmer-3.1b1.tar.gz -C $SOURCES

cd $HOME

# Kalign
cd $HOME/Downloads
sudo mkdir /usr/local/kalign

wget -t 3 http://msa.sbc.su.se/bin/sources/kalign/current.tar.gz -O $SOURCES/kalign-2.tar.gz
tar -zxf $SOURCES/kalign-2.tar.gz -C $SOURCES

cd $HOME

# Kalignvu
cd $HOME/Downloads
sudo mkdir /usr/local/kalignvu

wget -t 3 http://msa.sbc.su.se/bin/sources/kalignvu_2.1.tgz -O $SOURCES/kalignvu_2.1.tgz
tar -zxf $SOURCES/kalignvu_2.1.tgz -C $SOURCES

cd $HOME

# Mafft
cd $HOME/Downloads
sudo mkdir /usr/local/mafft

wget -t 3 http://mafft.cbrc.jp/alignment/software/mafft-7.212-with-extensions-src.tgz -O $SOURCES/mafft-7.212.tgz
tar -zxf $SOURCES/mafft-7.212.tgz -C $SOURCES

cd $HOME

# msaprobs
cd $HOME/Downloads
sudo mkdir /usr/local/msaprobs

wget -t 3 wget http://sourceforge.net/projects/msaprobs/files/MSAProbs-0.9.7.tar.gz/download -O $SOURCES/MSAProbs-0.9.7.tar.gz
tar -zxf $SOURCES/MSAProbs-0.9.7.tar.gz -C $SOURCES

cd $HOME

# mummer
cd $HOME/Downloads
sudo mkdir /usr/local/mummer

wget -t 3 http://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz/download -O $SOURCES/MUMmer3.23.tar.gz
tar -zxf $SOURCES/MUMmer3.23.tar.gz -C $SOURCES

cd $HOME

# Mumsa
cd $HOME/Downloads
sudo mkdir /usr/local/mumsa

wget -t 3 http://msa.sbc.su.se/bin/sources/mumsa-1.0.tgz -O $SOURCES/mumsa-1.0.tgz
tar -zxf $SOURCES/mumsa-1.0.tgz -C $SOURCES

cd $HOME

# muscle
cd $HOME/Downloads
sudo mkdir /usr/local/muscle

wget -t 3 http://drive5.com/muscle/muscle3.8.425_src.tar.gz -O $SOURCES/muscle3.8.425_src.tar.gz
tar -zxf $SOURCES/muscle3.8.425_src.tar.gz -C $SOURCES

# see also http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_src.tar.gz

cd $HOME

# ninja
cd $HOME/Downloads
sudo mkdir /usr/local/ninja

wget -t 3 http://nimbletwist.com/software/ninja/old_distros/ninja_1.2.2.tgz -O $SOURCES/ninja_1.2.2.tgz
tar -zxf $SOURCES/ninja_1.2.2.tgz -C $SOURCES

cd $HOME

# Phylip
cd $HOME/Downloads
sudo mkdir /usr/local/phylip

wget -t 3 http://evolution.gs.washington.edu/phylip/download/phylip-3.696.tar.gz -O $SOURCES/phylip-3.696.tar.gz
tar -zxf $SOURCES/phylip-3.696.tar.gz -C $SOURCES

cd $HOME

# PhyML
cd $HOME/Downloads
sudo mkdir /usr/local/phyml

wget -t 3 https://github.com/stephaneguindon/phyml-downloads/releases/download/stable/phyml-20120412.tar.gz -O $SOURCES/phyml-20120412.tar.gz
tar -zxf $SOURCES/phyml-20120412.tar.gz -C $SOURCES

cd $HOME

# Quicktree
cd $HOME/Downloads
sudo mkdir /usr/local/quicktree

wget -t 3 ftp://ftp.sanger.ac.uk/pub/resources/software/quicktree/quicktree.tar.gz -O $SOURCES/quicktree.tar.gz
tar -zxf $SOURCES/quicktree.tar.gz -C $SOURCES

cd $HOME

# RAxML
cd $HOME/Downloads
sudo mkdir /usr/local/raxml

git clone git@github.com:stamatak/standard-RAxML.git $SOURCES/RAxML
git checkout v8.1.7
cd $SOURCES/RAxML
make -f Makefile.SSE3.PTHREADS.gcc
# make -f Makefile.AVX.PTHREADS.gcc
rm *.o
make -f Makefile.SSE3.MPI.gcc
# make -f Makefile.AVX.MPI.gcc
rm *.o

cd $HOME

# T-Coffee
cd $HOME/Downloads
sudo mkdir /usr/local/tcoffee

wget -t 3 http://www.tcoffee.org/Packages/Stable/Latest/linux/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz -O $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz
tar -zxf $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz -C $SOURCES
#Do something

cd $HOME

# Tracer
cd $HOME/Downloads
sudo mkdir /usr/local/tracer

wget -t 3 http://tree.bio.ed.ac.uk/download.php?id=88&num=3 -O $SOURCES/Tracer_v1.6.tgz
tar -zxf $SOURCES/Tracer_v1.6.tgz -C $SOURCES

cd $HOME

# TrimAL
cd $HOME/Downloads
sudo mkdir /usr/local/trimal

wget -t 3 http://trimal.cgenomics.org/_media/trimal.v1.2rev59.tar.gz -O $SOURCES/trimal.v1.2rev59.tar.gz
tar -zxf $SOURCES/trimal.v1.2rev59.tar.gz -C $SOURCES

cd $HOME

# Velvet
cd $HOME/Downloads
sudo mkdir /usr/local/velvet

wget -t 3 https://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz -O $SOURCES/velvet_1.2.10.tgz
tar -zxf $SOURCES/velvet_1.2.10.tgz -C $SOURCES

cd $HOME

## Oases 
cd $HOME/Downloads
sudo mkdir /usr/local/oases

wget -t 3 http://www.ebi.ac.uk/~zerbino/oases/oases_0.2.08.tgz -O $SOURCES/oases_0.2.08.tgz
tar -zxf $SOURCES/oases_0.2.08.tgz -C $SOURCES

cd $HOME