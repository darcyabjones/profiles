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


#
# clone my own git repos
#
git clone git@github.com:darcyabjones/bioutils.git $HOME/bin/bioutils
git clone git@github.com:darcyabjones/darcyabjones.github.io.git $HOME/bin/darcyabjones.github.io
git clone git@github.com:darcyabjones/darcyabjones.net.git $HOME/bin/darcyabjones.net
git clone git@github.com:darcyabjones/phylomake.git $HOME/bin/phylomake
git clone git@github.com:XenoProject/Xenophyle.git $HOME/bin/Xenophyle
git clone git@github.com:XenoProject/xenophyle.com.git $HOME/bin/xenophyle.com

git clone git@github.com:darcyabjones/markdown.git $HOME/Templates/markdown
git clone git@github.com:darcyabjones/tex.git $HOME/Templates/tex


#
# Antigen
#
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen


#
# Atom
#
sudo rpm -Uhv https://atom.io/download/rpm
sudo dnf -y install atom


#
# GCC
#
sudo mkdir -p /usr/local/gcc

wget -t 3 ftp://ftp.gnu.org/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.gz -O $SOURCES/gcc-5.3.0.tar.gz
tar -zxf $SOURCES/gcc-5.3.0.tar.gz -C $SOURCES
cd $SOURCES/gcc-5.3.0

wget -t 3 ftp://ftp.gnu.org/gnu/gcc/gcc-4.9.3/gcc-4.9.3.tar.gz -O $SOURCES/gcc-4.9.3.tar.gz
tar -zxf $SOURCES/gcc-4.9.3.tar.gz -C $SOURCES
cd $SOURCES/gcc-4.9.3


#
# openmpi
#
sudo mkdir -p /usp/local/openmpi

wget -t 3 http://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.1.tar.gz -O $SOURCE/openmpi-1.10.1.tar.gz
tar -zxf $SOURCES/openmpi-1.10.1.tar.gz -C $SOURCES
cd $SOURCES/openmpi-1.10.1


#
# openblas
#
sudo mkdir -p /usr/local/openblas

wget -t 3 http://github.com/xianyi/OpenBLAS/archive/v0.2.15.tar.gz -O $SOURCE/v0.2.15.tar.gz
tar -zxf $SOURCE/v0.2.15.tar.gz -C $SOURCES
cd $SOURCE/v0.2.15


#
# ATLAS
#
sudo mkdir -p /usr/local/atlas

wget -t 3 http://downloads.sourceforge.net/project/math-atlas/Stable/3.10.2/atlas3.10.2.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmath-atlas%2Ffiles%2FStable%2F3.10.2%2F&ts=1450322771&use_mirror=internode -O $SOURCES/atlas3.10.2.tar.bz2
tar -jxf $SOURCES/atlas3.10.2.tar.bz2 -C $SOURCES
cd $SOURCES/atlas3.10.2


#
# LAPACK
#
sudo mkdir -p /usr/local/lapack

wget -t 3 http://www.netlib.org/lapack/lapack-3.6.0.tgz -O $SOURCES/lapack-3.6.0.tgz
tar -zxf $SOURCES/lapack-3.6.0.tgz -C $SOURCES
cd $SOURCES/lapack-3.6.0


#
# Parallel
#
sudo mkdir -p /usr/local/parallel

wget -t 3 ftp://ftp.gnu.org/gnu/parallel/parallel-20151122.tar.bz2 -O $SOURCES/parallel-20151122.tar.bz2
tar -jxf $SOURCES/parallel-20151122.tar.bz2 -C $SOURCES
cd $SOURCES/parallel-20151122


#
# boost
#
sudo mkdir -p /usr/local/boost

wget -t 3 http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.59.0%2F&ts=1450326319&use_mirror=internode -O $SOURCES/boost_1_59_0.tar.gz
tar -zxf $SOURCES/boost_1_59_0.tar.gz -C $SOURCES
cd $SOURCES/boost_1_59_0


#
# R
#
sudo mkdir -p /usr/local/R

wget -t 3 http://cran.ms.unimelb.edu.au/src/base/R-3/R-3.2.3.tar.gz -O $SOURCES/R-3.2.3.tar.gz
tar -zxf $SOURCES/R-3.2.3.tar.gz -C $SOURCES
cd $SOURCES/R-3.2.3


#
# RStudio
#
sudo mkdir -p /usr/local/rstudio
#https://download1.rstudio.org/rstudio-0.99.489-x86_64-fedora.tar.gz
wget -t 3 https://download1.rstudio.org/rstudio-0.99.467-x86_64.rpm -O $SOURCES/rstudio-0.99.467-x86_64.rpm
sudo yum --nogpgcheck -y localinstall $SOURCES/rstudio-0.99.467-x86_64.rpm


#
# Python
#
sudo mkdir -p /usr/local/python

wget -t 3 https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz -O $SOURCES/Python-3.5.1.tgz
tar -zxf $SOURCES/Python-3.5.1.tgz -C $SOURCES
cd $SOURCES/Python-3.5.1 &&

wget -t 3 https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz -O $SOURCES/Python-3.4.3.tgz
tar -zxf $SOURCES/Python-3.4.3.tgz -C $SOURCES
cd $SOURCES/Python-3.4.3 &&

wget -t 3 https://www.python.org/ftp/python/3.3.6/Python-3.3.6.tgz -O $SOURCES/Python-3.3.6.tgz
tar -zxf $SOURCES/Python-3.3.6.tgz -C $SOURCES
cd $SOURCES/Python-3.3.6 &&

wget -t 3 https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz -0 $SOURCES/Python-2.7.11.tgz
tar -zxf $SOURCES/Python-2.7.11.tgz -C $SOURCES
cd $SOURCES/Python-2.7.11 &&

wget -t 3 https://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz -0 $SOURCES/Python-2.6.9.tgz
tar -zxf $SOURCES/Python-2.6.9.tgz -C $SOURCES
cd $SOURCES/Python-2.6.9 &&


#
# Julia
#
sudo mkdir -p /usr/local/julia
wget -t 3 https://github.com/JuliaLang/julia/releases/download/v0.4.2/julia-0.4.2-full.tar.gz -O $SOURCES/julia-0.4.2-full.tar.gz
tar -zxf $SOURCES/julia-0.4.2-full.tar.gz -C $SOURCES
cd $SOURCES/julia-0.4.2-full


#
# Perl
#
sudo mkdir -p /usr/local/perl

wget -t 3 http://www.cpan.org/src/5.0/perl-5.22.1.tar.gz -O $SOURCES/perl-5.22.1.tar.gz
tar -xzf $SOURCES/perl-5.22.1.tar.gz -C $SOURCES
cd $SOURCES/perl-5.22.1 && ./Configure -des -Dprefix=/usr/local/perl/5.22.1 && make && make test && sudo make install

#sudo perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
#sudo cpan -u
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

#
# GCC 4.8
#
# Beagle requires this#

#mkdir $SOURCES/gcc
#mkdir $HOME/bin/gcc
#svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_4_8_3_release $SOURCES/gcc/4.8
#mkdir $SOURCES/gcc/objdir
#cd $SOURCES/gcc/objdir
#$SOURCES/gcc/4.8/configure -prefix=$HOME/bin/gcc/4.8.3
#make
#cd $HOME


# BEAGLE

#svn checkout http://beagle-lib.googlecode.com/svn/trunk/ $SOURCES/beagle-lib
#cd $SOURCES/beagle-lib
#$SOURCES/beagle-lib/autogen.sh
#$SOURCES/beagle-lib/configure
#sudo make install
## export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH

#
# BEAST
#
sudo mkdir -p /usr/local/beast

wget -t 3 -O $SOURCES/BEAST-1.8.1.tgz http://tree.bio.ed.ac.uk/download.php?id=91\&num=3
tar -zxf $SOURCES/BEAST-1.8.1.tgz -C $SOURCES
sudo mv $SOURCES/BEASTv1.8.1 /usr/local/beast/1.8.1


#
# Bedtools
#
sudo mkdir -p /usr/local/bedtools

wget -t 3 -O $SOURCES/Bedtools2-2.22.0.tar.gz https://github.com/arq5x/bedtools2/archive/v2.22.0.tar.gz
tar -zxf $SOURCES/Bedtools2-2.22.0.tar.gz -C $SOURCES
cd $SOURCES/bedtools2-2.22.0
make && \
sudo mv $SOURCES/bedtools2-2.22.0 /usr/local/bedtools/2.22.0


#
# BLAST
#
sudo mkdir -p /usr/local/blast

wget -t 3 -O $SOURCES/ncbi-blast-2.2.30+-src.tar.gz ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.30/ncbi-blast-2.2.30+-src.tar.gz
tar -zxf $SOURCES/ncbi-blast-2.2.30+-src.tar.gz -C $SOURCES
cd $SOURCES/ncbi-blast-2.2.30+-src/c++
$SOURCES/ncbi-blast-2.2.30+-src/c++/configure && \
make && \
sudo mv $SOURCES/ncbi-blast-2.2.30+-src /usr/local/blast/2.2.30+

wget -t 3 -O $SOURCES/blast-2.2.26-x64-linux.tar.gz ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/LATEST/blast-2.2.26-x64-linux.tar.gz
tar -zxf $SOURCES/blast-2.2.26-x64-linux.tar.gz -C $SOURCES
cd $SOURCES/blast-2.2.26-x64-linux


#
# Clustal-O
#
sudo mkdir -p /usr/local/clustalo

wget -t 3 -O $SOURCES/clustal-omega-1.2.1.tar.gz http://www.clustal.org/omega/clustal-omega-1.2.1.tar.gz
tar -zxf $SOURCES/clustal-omega-1.2.1.tar.gz -C $SOURCES
cd $SOURCES/clustal-omega-1.2.1
$SOURCES/clustal-omega-1.2.1/configure && \
make && \
make check && \
sudo mv $SOURCES/clustal-omega-1.2.1 /usr/local/clustalo/1.2.1


#
# Clustalw2
#
sudo mkdir -p /usr/local/clustalw

wget -t 3 -O $SOURCES/clustalw-2.1.tar.gz http://www.clustal.org/download/current/clustalw-2.1.tar.gz
tar -zxf $SOURCES/clustalw-2.1.tar.gz -C $SOURCES
cd $SOURCES/clustalw-2.1
$SOURCES/clustalw-2.1/configure && \
make && \
make check && \
sudo mv $SOURCES/clustalw-2.1 /usr/local/clustalw/2.1


#
# Dialign
#
sudo mkdir -p /usr/local/dialign

wget -t 3 -O $SOURCES/dialign_package.tgz http://dialign.gobics.de/download/dialign_package.tgz
tar -zxf $SOURCES/dialign_package.tgz -C $SOURCES
cd $SOURCES/dialign_package/src/
make && \
sudo rm *.o && \
sudo mv $SOURCES/dialign_package /usr/local/dialign/2

# Note that setenv DIALIGN2_DIR /your_path/dialign2_dir/ is already in the .envs file

#
# Dialign-TX
#
sudo mkdir -p /usr/local/dialign-tx

wget -t 3 http://dialign-tx.gobics.de/DIALIGN-TX_1.0.2.tar.gz -O $SOURCES/DIALIGN-TX_1.0.2.tar.gz
tar -zxf $SOURCES/DIALIGN-TX_1.0.2.tar.gz -C $SOURCES
mv $SOURCES/DIALIGN-TX_1.0.2/source/Makefile $SOURCES/DIALIGN-TX_1.0.2/source/Makefile.old
cat $SOURCES/DIALIGN-TX_1.0.2/source/Makefile.old | sed s/-march=i686/-march=x86-64/ > $SOURCES/DIALIGN-TX_1.0.2/source/Makefile
cd $SOURCES/DIALIGN-TX_1.0.2/source
make && \
mv $SOURCES/DIALIGN-TX_1.0.2/source/dialign-tx $SOURCES/DIALIGN-TX_1.0.2/bin/dialign-tx && \
sudo mv $SOURCES/DIALIGN-TX_1.0.2 /usr/local/dialign-tx/1.0.2


#
# Diamond
#
sudo mkdir -p /usr/local/diamond

wget -t 3 -O $SOURCES/diamond.tar.gz http://www-ab.informatik.uni-tuebingen.de/data/software/diamond/download/public/diamond.tar.gz
tar -zxf $SOURCES/diamond.tar.gz -C $SOURCES
cd $SOURCES/diamond
$SOURCES/diamond/configure && \
make && \
make check && \
sudo mv $SOURCES/diamond /usr/local/diamond/0.6.3


#
# Entrez Direct
#

wget -t 3 -O $SOURCES/edirect.tar.gz ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz
tar -zxf $SOURCES/edirect.tar.gz -C $SOURCES
sudo mv $SOURCES/edirect /usr/local/edirect


#
# Figtree
#
sudo mkdir -p /usr/local/figtree

wget -t 3 -O $SOURCES/FigTree_v1.4.2.tgz http://tree.bio.ed.ac.uk/download.php?id=90\&num=3
tar -zxf $SOURCES/FigTree_v1.4.2.tgz -C $SOURCES
chmod a+x $SOURCES/FigTree_v1.4.2/bin/figtree
sudo mv $SOURCES/FigTree_v1.4.2 /usr/local/figtree/1.4.2


#
# FSA
#
sudo mkdir -p /usr/local/fsa

wget -t 3 -O $SOURCES/fsa-1.15.9.tar.gz http://downloads.sourceforge.net/project/fsa/fsa-1.15.9.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ffsa%2F\&ts=1417869476\&use_mirror=softlayer-sng
tar -zxf $SOURCES/fsa-1.15.9.tar.gz -C $SOURCES
cd $SOURCES/fsa-1.15.9
$SOURCES/fsa-1.15.9/configure && \
make && \
sudo mv $SOURCES/fsa-1.15.9 /usr/local/fsa/1.15.9


#
# HMMER
#
sudo mkdir -p /usr/local/hmmer

wget -t 3 -O $SOURCES/hmmer-3.1b1.tar.gz ftp://selab.janelia.org/pub/software/hmmer3/3.1b1/hmmer-3.1b1.tar.gz
tar -zxf $SOURCES/hmmer-3.1b1.tar.gz -C $SOURCES
cd $SOURCES/hmmer-3.1b1
$SOURCES/hmmer-3.1b1/configure && \
make && \
make check && \
sudo mv $SOURCES/hmmer-3.1b1 /usr/local/hmmer/3.1b1


#
# Kalign
#
sudo mkdir -p /usr/local/kalign

wget -t 3 -O $SOURCES/kalign-2.tar.gz http://msa.sbc.su.se/downloads/kalign/current.tar.gz
mkdir $SOURCES/kalign-2
tar -zxf $SOURCES/kalign-2.tar.gz -C $SOURCES/kalign-2
cd $SOURCES/kalign-2
$SOURCES/kalign-2/configure && \
make && \
sudo mv $SOURCES/kalign-2 /usr/local/kalign/2


#
# Kalignvu
#
sudo mkdir -p /usr/local/kalignvu

wget -t 3 -O $SOURCES/kalignvu_2.1.tgz http://msa.sbc.su.se/downloads/kalignvu_2.1.tgz
tar -zxf $SOURCES/kalignvu_2.1.tgz -C $SOURCES
cd $SOURCES/kalignvu_2.1
make && \
sudo mv $SOURCES/kalignvu_2.1 /usr/local/kalignvu/2.1


#
# Mafft
#
sudo mkdir -p /usr/local/mafft

wget -t 3 -O $SOURCES/mafft-7.212.tgz http://mafft.cbrc.jp/alignment/software/mafft-7.212-with-extensions-src.tgz
tar -zxf $SOURCES/mafft-7.212.tgz -C $SOURCES
cd $SOURCES/mafft-7.212-with-extensions/core && \
make clean  && \
make && \
cd $SOURCES/mafft-7.212-with-extensions/extensions && \
make clean && \
make && \
sudo mv $SOURCES/mafft-7.212-with-extensions /usr/local/mafft/7.212


#
# msaprobs
#
sudo mkdir -p /usr/local/msaprobs

wget -t 3 -O $SOURCES/MSAProbs-0.9.7.tar.gz http://sourceforge.net/projects/msaprobs/files/MSAProbs-0.9.7.tar.gz/download
tar -zxf $SOURCES/MSAProbs-0.9.7.tar.gz -C $SOURCES
cd $SOURCES/MSAProbs-0.9.7/MSAProbs
make && \
sudo mv $SOURCES/MSAProbs-0.9.7 /usr/local/msaprobs/0.9.7


#
# mummer
#
sudo mkdir -p /usr/local/mummer

wget -t 3 -O $SOURCES/MUMmer3.23.tar.gz http://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz/download
tar -zxf $SOURCES/MUMmer3.23.tar.gz -C $SOURCES
sudo mv $SOURCES/MUMmer3.23 /usr/local/mummer/3.23
cd /usr/local/mummer/3.23
make check && \
make install


#
# muscle
#
sudo mkdir -p /usr/local/muscle

wget -t 3 -O $SOURCES/muscle3.8.31_i86linux64.tar.gz http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86linux64.tar.gz
mkdir $SOURCES/muscle
tar -zxf $SOURCES/muscle3.8.31_i86linux64.tar.gz -C $SOURCES/muscle
sudo mv $SOURCES/muscle /usr/local/muscle/3.8.31


#
# ninja
#
sudo mkdir -p /usr/local/ninja

wget -t 3 -O $SOURCES/ninja_1.2.2.tgz http://nimbletwist.com/software/ninja/old_distros/ninja_1.2.2.tgz
tar -zxf $SOURCES/ninja_1.2.2.tgz -C $SOURCES
sudo mv $SOURCES/ninja_1.2.2 /usr/local/ninja/1.2.2


#
# Phylip
#
sudo mkdir -p /usr/local/phylip

wget -t 3 -O $SOURCES/phylip-3.696.tar.gz http://evolution.gs.washington.edu/phylip/download/phylip-3.696.tar.gz
tar -zxf $SOURCES/phylip-3.696.tar.gz -C $SOURCES
cd $SOURCES/phylip-3.696/src
make -f $SOURCES/phylip-3.696/src/Makefile.unx install && \
sudo mv $SOURCES/phylip-3.696 /usr/local/phylip/3.696 && \


#
# PhyML
#
sudo mkdir -p /usr/local/phyml

wget -t 3 -O $SOURCES/phyml-20120412.tar.gz https://github.com/stephaneguindon/phyml-downloads/releases/download/stable/phyml-20120412.tar.gz
tar -zxf $SOURCES/phyml-20120412.tar.gz -C $SOURCES
cd $SOURCES/phyml-20120412
$SOURCES/phyml-20120412/configure && \
make && \
sudo mv $SOURCES/phyml-20120412 /usr/local/phyml/20120412


#
# Quicktree
#
sudo mkdir -p /usr/local/quicktree

wget -t 3 -O $SOURCES/quicktree.tar.gz ftp://ftp.sanger.ac.uk/pub/resources/software/quicktree/quicktree.tar.gz
tar -zxf $SOURCES/quicktree.tar.gz -C $SOURCES
cd $SOURCES/quicktree_1.1
make quicktree && \
sudo mv $SOURCES/quicktree_1.1 /usr/local/quicktree/1.1


#
# RAxML
#
sudo mkdir -p /usr/local/raxml

cd $HOME
git clone git@github.com:stamatak/standard-RAxML.git $SOURCES/RAxML
cd $SOURCES/RAxML
git checkout v8.1.7
make -f Makefile.SSE3.PTHREADS.gcc && \
rm *.o && \
make -f Makefile.SSE3.MPI.gcc  && \
rm *.o && \
make -f Makefile.AVX.PTHREADS.gcc && \
rm *.o && \
make -f Makefile.AVX.MPI.gcc && \
rm *.o && \
sudo mv $SOURCES/RAxML /usr/local/raxml/8.1.7

# Requires mpicc in path


#
# T-Coffee
#
sudo mkdir /usr/local/tcoffee

#wget -t 3 -O $SOURCES/T-COFFEE_distribution_Version_11.00.8cbe486.tar.gz http://www.tcoffee.org/Packages/Stable/Version_11.00.8cbe486/T-COFFEE_distribution_Version_11.00.8cbe486.tar.gz
#tar -zxf $SOURCES/T-COFFEE_distribution_Version_11.00.8cbe486.tar.gz -C $SOURCES
#cd $SOURCES/T-COFFEE_distribution_Version_11.00.8cbe486
#$SOURCES/T-COFFEE_distribution_Version_11.00.8cbe486/install all

wget -t 3 -O $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz http://www.tcoffee.org/Packages/Stable/Version_11.00.8cbe486/linux/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz
tar -zxf $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz -C $SOURCES
cd $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64

mkdir $HOME/.t_coffee
cp -R $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64/plugins $HOME/.t_coffee/plugins
cp -R $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64/methods $HOME/.t_coffee/methods
cp -R $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64/mcoffee $HOME/.t_coffee/mcoffee

sudo mv $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64 /usr/local/tcoffee/11.00.8cbe486


#
# Tracer
#
sudo mkdir /usr/local/tracer

wget -t 3 -O $SOURCES/Tracer_v1.6.tgz http://tree.bio.ed.ac.uk/download.php?id=88\&num=3
tar -zxf $SOURCES/Tracer_v1.6.tgz -C $SOURCES
chmod a+x $SOURCES/Tracer_v1.6/bin/tracer
sudo mv $SOURCES/Tracer_v1.6 /usr/local/tracer/1.6


#
# TrimAL
#
sudo mkdir /usr/local/trimal

wget -t 3 -O $SOURCES/trimal.v1.2rev59.tar.gz http://trimal.cgenomics.org/_media/trimal.v1.2rev59.tar.gz
tar -zxf $SOURCES/trimal.v1.2rev59.tar.gz -C $SOURCES
cd $SOURCES/trimAl/source
make && \
sudo mv $SOURCES/trimAl /usr/local/trimal/1.2rev59
