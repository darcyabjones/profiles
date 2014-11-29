#! /usr/bin/env bash

#
# Link the profile files to the home dir
#
ln -s $PWD/aliases $HOME/.aliases
ln -s $PWD/bash_profile $HOME/.bash_profile
ln -s $PWD/bashrc $HOME/.bashrc
ln -s $PWD/emacs $HOME/.emacs
ln -s $PWD/env $HOME/.env
ln -s $PWD/paths $HOME/.paths
ln -s $PWD/tmux.conf $HOME/.tmux.conf
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/zshrc $HOME/.zshrc

#
# Install the basic yum packages from the fedora repo
#
sudo yum update
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
sudo yum install -y emacs emacs-common emacs-filesystem emacs-nox
sudo yum install -y gawk
sudo yum install -y gcc gcc-c++ gcc-gfortran
sudo yum install -y ghc-base
sudo yum install -y ghc-base-devel
sudo yum install -y ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-devel ghc-pandoc-types ghc-pandoc-types-devel
sudo yum install -y gimp gimp_libs
sudo yum install -y git git-extras
sudo yum install -y git-annex git-annex-docs
sudo yum install -y htop
sudo yum install -y inkscape
sudo yum install -y java
sudo yum install -y kernel-devel
sudo yum install -y latexmk
sudo yum install -y levien-inconsolata-fonts
sudo yum install -y libpng libpng-devel
sudo yum install -y nodejs
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
sudo cp ./repos/* /etc/yum.repos.d/
sudo yum update

#
# Fedy
#
su -c "curl https://satya164.github.io/fedy/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer"
sudo fedy --exex rpmfusion_repos
sudo fedy --exec google_chrome
sudo fedy --exec nautilus_dropbox
sudo fedy --exec oracle_jdk
sudo fedy --exec skype_linux
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


## Grive etc

#
# Install antigen
#
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen

#
# Install the python distributions
#
wget -N -t 3 https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz -O $HOME/Downloads/Python-3.4.2.tgz
tar zxvf $HOME/Downloads/Python-3.4.2.tgz
cd $HOME/Downloads/Python-3.4.2
./configure
make
sudo make install
cd $HOME

wget -N -t 3 https://www.python.org/ftp/python/3.3.6/Python-3.3.6.tgz -O $HOME/Downloads/Python-3.3.6.tgz
tar zxvf $HOME/Downloads/Python-3.3.6.tgz
cd $HOME/Downloads/Python-3.3.6
./configure
make
sudo make altinstall
cd $HOME

wget -N -t 3 https://www.python.org/ftp/python/3.2.6/Python-3.2.6.tgz -O $HOME/Downloads/Python-3.2.6.tgz
tar zxvf $HOME/Downloads/Python-3.2.6.tgz
cd $HOME/Downloads/Python-3.2.6
./configure
make
sudo make altinstall
cd $HOME

wget -N -t 3 https://www.python.org/ftp/python/3.1.5/Python-3.1.5.tgz -O $HOME/Downloads/Python-3.1.5.tgz
tar zxvf $HOME/Downloads/Python-3.1.5.tgz
cd $HOME/Downloads/Python-3.1.5
./configure
make
sudo make altinstall
cd $HOME

wget -N -t 3 https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz -O $HOME/Downloads/Python-2.7.8.tgz
tar zxvf $HOME/Downloads/Python-2.7.8.tgz
cd $HOME/Downloads/Python-2.7.8
./configure
make
sudo make altinstall
cd $HOME

wget -N -t 3 https://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz -O $HOME/Downloads/Python-2.6.9.tgz
tar zxvf $HOME/Downloads/Python-2.6.9.tgz
cd $HOME/Downloads/Python-2.6.9
./configure
make
sudo make altinstall
cd $HOME

#
# Install the R distributions
#
wget -N -t 3 http://cran.ms.unimelb.edu.au/src/base/R-3/R-3.1.2.tar.gz -O $HOME/Downloads/R-3.1.2.tar.gz
tar zxvf $HOME/Downloads/R-3.1.2.tar.gz
cd $HOME/Downloads/R-3.1.2
./configure
make && make check && sudo make install
cd $HOME

#
# Julia
#
sudo mkdir /usr/local/julia

git clone git@github.com:JuliaLang/julia.git $HOME/Downloads/julia
cd $HOME/Downloads/julia
git checkout release-0.3
make
cd $HOME
sudo mv $HOME/Downloads/julia /usr/local/julia/0.3
sudo ln -s /usr/local/julia/0.3/ /usr/local/bin/julia
sudo ln -s /usr/local/julia/0.3/ /usr/local/bin/julia-0.3

#
# Install some bio-packages
#

# BLAST+
cd $HOME/Downloads
sudo mkdir /usr/local/blast

wget -t 3 ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.30/ncbi-blast-2.2.30+-src.tar.gz -O $HOME/Downloads/ncbi-blast-2.2.30+-src.tar.gz
tar zxvf $HOME/Downloads/ncbi-blast-2.2.30+-src.tar.gz

cd $HOME

# Clustal-O
cd $HOME/Downloads
sudo mkdir /usr/local/clustalo

wget -t 3 http://www.clustal.org/omega/clustal-omega-1.2.1.tar.gz -O $HOME/Downloads/clustal-omega-1.2.1.tar.gz
tar zxvf $HOME/Downloads/clustal-omega-1.2.1.tar.gz
cd $HOME/Downloads/clustal-omega-1.2.1
./configure
make && make check
#sudo mv $HOME/Downloads/clustal-omega-1.2.1 /usr/local/clustalo/1.2.1
#sudo ln -s /usr/local/clustalo/1.2.1 /usr/local/bin/clustalo
#sudo ln -s /usr/local/clustalo/1.2.1 /usr/local/bin/clustalo-1.2.1

cd $HOME

# Clustalw2
cd $HOME/Downloads
sudo mkdir /usr/local/clustalw
wget -t 3 http://www.clustal.org/download/current/clustalw-2.1.tar.gz -O $HOME/Downloads/clustalw-2.1.tar.gz
tar zxvf $HOME/Downloads/clustalw-2.1.tar.gz
cd $HOME/Downloads/clustalw-2.1
./configure
make && make check
sudo mv $HOME/Downloads/clustalw-2.1 /usr/local/clustalw/2.1
#sudo ln -s /usr/local/clustalw/2.1/ /usr/local/bin/clustalw
#sudo ln -s /usr/local/clustalw/2.1/ /usr/local/bin/clustalw2
#sudo ln -s /usr/local/clustalw/2.1/ /usr/local/bin/clustalw-2.1
cd $HOME

# Dialign
cd $HOME/Downloads
sudo mkdir /usr/local/dialign

wget -t 3 http://dialign.gobics.de/download/dialign_package.tgz -O $HOME/dialign_package.tgz
tar zxvf $HOME/dialign_package.tgz

cd $HOME

# Dialign-TX
cd $HOME/Downloads
sudo mkdir /usr/local/dialign-tx

wget -t 3 http://dialign-tx.gobics.de/DIALIGN-TX_1.0.2.tar.gz -O $HOME/Downloads/DIALIGN-TX_1.0.2.tar.gz
tar zxvf $HOME/Downloads/DIALIGN-TX_1.0.2.tar.gz

cd $HOME

# Entrez Direct
cd $HOME/Downloads
sudo mkdir /usr/local/edirect

wget -t 3 ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz -O $HOME/Downloads/edirect.tar.gz
tar zxvf $HOME/Downloads/edirect.tar.gz

cd $HOME

# HMMER
cd $HOME/Downloads
sudo mkdir /usr/local/hmmer

wget -t 3 ftp://selab.janelia.org/pub/software/hmmer3/3.1b1/hmmer-3.1b1.tar.gz -O $HOME/Downloads/hmmer-3.1b1.tar.gz
tar zxvf $HOME/Downloads/hmmer-3.1b1.tar.gz

cd $HOME

# Kalign
cd $HOME/Downloads
sudo mkdir /usr/local/kalign

wget -t 3 http://msa.sbc.su.se/downloads/kalign/current.tar.gz -O $HOME/Downloads/kalign-2.tar.gz
tar zxvf $HOME/Downloads/kalign-2.tar.gz

cd $HOME

# Kalignvu
cd $HOME/Downloads
sudo mkdir /usr/local/kalignvu

wget -t 3 http://msa.sbc.su.se/downloads/kalignvu_2.1.tgz -O $HOME/Downloads/kalignvu_2.1.tgz
tar zxvf $HOME/Downloads/kalignvu_2.1.tgz

cd $HOME

# Mafft
cd $HOME/Downloads
sudo mkdir /usr/local/mafft

wget -t 3 http://mafft.cbrc.jp/alignment/software/mafft-7.212-with-extensions-src.tgz -O $HOME/Downloads/mafft-7.212.tgz
tar zxvf $HOME/Downloads/mafft-7.212.tgz

cd $HOME

# msaprobs
cd $HOME/Downloads
sudo mkdir /usr/local/msaprobs

wget -t 3 wget http://sourceforge.net/projects/msaprobs/files/MSAProbs-0.9.7.tar.gz/download -O $HOME/Downloads/MSAProbs-0.9.7.tar.gz
tar zxvf $HOME/Downloads/MSAProbs-0.9.7.tar.gz

cd $HOME

# mummer
cd $HOME/Downloads
sudo mkdir /usr/local/mummer

wget -t 3 http://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz/download -O $HOME/Downloads/MUMmer3.23.tar.gz
tar zxvf $HOME/Downloads/MUMmer3.23.tar.gz

cd $HOME

# Mumsa
cd $HOME/Downloads
sudo mkdir /usr/local/mumsa

wget -t 3 http://msa.sbc.su.se/downloads/mumsa-1.0.tgz -O $HOME/Downloads/mumsa-1.0.tgz
tar zxvf $HOME/Downloads/mumsa-1.0.tgz

cd $HOME

# muscle
cd $HOME/Downloads
sudo mkdir /usr/local/muscle

wget -t 3 http://drive5.com/muscle/muscle3.8.425_src.tar.gz -O $HOME/Downloads/muscle3.8.425_src.tar.gz
tar zxvf $HOME/Downloads/muscle3.8.425_src.tar.gz

# see also http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_src.tar.gz

cd $HOME

# ninja
cd $HOME/Downloads
sudo mkdir /usr/local/ninja

wget -t 3 http://nimbletwist.com/software/ninja/old_distros/ninja_1.2.2.tgz -O $HOME/Downloads/ninja_1.2.2.tgz
tar zxvf $HOME/Downloads/ninja_1.2.2.tgz

cd $HOME

# Phylip
cd $HOME/Downloads
sudo mkdir /usr/local/phylip

wget -t 3 http://evolution.gs.washington.edu/phylip/download/phylip-3.696.tar.gz -O $HOME/Downloads/phylip-3.696.tar.gz
tar zxvf $HOME/Downloads/phylip-3.696.tar.gz

cd $HOME

# Quicktree
cd $HOME/Downloads
sudo mkdir /usr/local/quicktree

wget -t 3 ftp://ftp.sanger.ac.uk/pub/resources/software/quicktree/quicktree.tar.gz -O $HOME/Downloads/quicktree.tar.gz
tar zxvf $HOME/Downloads/quicktree.tar.gz

cd $HOME

# RAxML
cd $HOME/Downloads
sudo mkdir /usr/local/raxml

git clone git@github.com:stamatak/standard-RAxML.git $HOME/Downloads/RAxML
git checkout v8.1.7
cd $HOME/Downloads/RAxML
make -f Makefile.SSE3.PTHREADS.gcc
# make -f Makefile.AVX.PTHREADS.gcc
rm *.o
make -f Makefile.SSE3.MPI.gcc
# make -f Makefile.AVX.MPI.gcc
rm *.o



# T-Coffee
cd $HOME/Downloads
wget -t 3 http://www.tcoffee.org/Packages/Stable/Latest/linux/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz -O $HOME/Downloads/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz
tar zxvf $HOME/Downloads/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz
#Do something

cd $HOME
