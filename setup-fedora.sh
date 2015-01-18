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
sudo yum install -y xclip
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
ln -sf $PROFILES/emacs $HOME/.emacs
ln -sf $PROFILES/env $HOME/.env
ln -sf $PROFILES/paths $HOME/.paths
ln -sf $PROFILES/Rprofile $HOME/.Rprofile
ln -sf $PROFILES/tmux.conf $HOME/.tmux.conf
ln -sf $PROFILES/vimrc $HOME/.vimrc
ln -sf $PROFILES/zshrc $HOME/.zshrc

#
# Create some new folders
#
mkdir $HOME/bin
mkdir $HOME/bin/sources
export SOURCES=$HOME/bin/sources
mkdir $HOME/research
mkdir $HOME/data

#
# Install the basic yum packages from the fedora repo
#
sudo yum -y update
sudo yum install -y \
	alien \
	argtable argtable-devel \
	autoconf \
	automake \
	bash \
	bash-completion \
	bibutils bibutils-devel bibutils-libs \
	boost boost-devel boost-filesystem boost-build \
	cairo cairo-devel cairo-gobject cairo-gobject-devel \
	cmake \
	cpp \
	cups cups-libs \
	curl \
	docker-io \
	doxygen \
	emacs emacs-common emacs-filesystem emacs-nox \
	filezilla \
	freeglut-devel \
	gawk \
	gcc gcc-c++ gcc-gfortran \
	ghc-base ghc-base-devel \
	ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-devel ghc-pandoc-types ghc-pandoc-types-devel \
	gimp gimp-libs \
	git git-core git-extras \
	git-annex git-annex-docs \
	glibc-devel \
	gmp gmp-devel gmp-static \
	gmpc gmpc-devel \
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
	libcurl-devel \
	libgcrypt libgcrypt-devel \
	libgnome-keyring-devel \
	libmpc libmpc-devel \
	libtool libtool-ltdl-devel libtool-ltdl \
	libpng libpng-devel \
	libXi-devel libXmu-devel \
	mesa-libGLU-devel \
	mpc \
	mpfr mpfr-devel \
	nodejs \
	npm \
	opencl-filesystem opencl-headers \
	opencl-utils opencl-utils-devel \
	OpenTK \
	openmpi openmpi-devel openmpi-java-devel \
	openssh openssh-clients openssh-server \
	openssl openssl-devel openssl-libs openssl-static \
	openvpn \
	pandoc pandoc-citeproc pandoc-pdf \
	postgresql postgresql-contrib postgresql-libs postgresql-server \
	python-devel python3-devel \
	qt qt-devel qt-x11 \
	qtwebkit qtwebkit-devel \
	R-core R-core-devel \
	readline readline-devel readline-static \
	rpm rpm-build rpm-build-libs rpm-libs rpm-python \
	rpmdevtools \
	samba-client samba-common samba-libs \
	sed \
	sqlite sqlite-devel sqlite-doc sqlite-tcl \
	tcsh \
	texlive texlive-base \
	thunderbird thunderbird-lightning thunderbird-enigmail thunderbird-lightning-gdata \
	tk tk-devel \
	tkinter \
	tmux \
	transmission-common transmission-gtk \
	vim vim-common vim-enhanced vim-filesystem vim-minimal \
	vpnc \
	wget \
	xclip \
	zsh

#
# Add special repositories
#
sudo cp $PROFILES/repos/* /etc/yum.repos.d/
sudo yum update

#
# Fedy
#
su -c "curl https://satya164.github.io/fedy/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer && rm ./fedy-installer"
sudo fedy --exec \
	rpmfusion_repos \
	google_chrome \
	nautilus_dropbox \
	oracle_jdk \
	skype_linux \
	sublime_text3 \
	adobe_flash \
	disk_io_scheduler \
	dvd_playback \
	media_codecs \
	oracle_jre


#
# Spotify
#
sudo yum-config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo yum -y install spotify-client


#
# chromium
#
sudo yum install -y chromium

#
# rpmfusion ones
#
sudo yum install -y \
	rpmfusion-free-release rpmfusion-nonfree-release \
	vlc vlc-core \
	akmod-wl \
	akmods

# xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-libs

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
# CUDA
#

# Get the latest from here: https://developer.nvidia.com/cuda-toolkit
# See: http://www.r-tutor.com/gpu-computing/cuda-installation/cuda6.5-fc20
# Make sure you change .paths on update

# sudo rpm -Uhv http://developer.download.nvidia.com/compute/cuda/repos/fedora20/x86_64/cuda-repo-fedora20-6.5-14.x86_64.rpm

# sudo yum -y install cuda

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
tar -xjf $SOURCES/mendeleydesktop-x86_64.tar.bz2 -C $SOURCES && \
sudo mv $SOURCES/mendeleydesktop-1.13.1-linux-x86_64 /usr/local/mendeleydesktop && \
sudo ln -s /usr/local/mendeleydesktop/bin/mendeleydesktop /usr/local/bin/mendeleydesktop

#
# Install antigen
#
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen

#
# Install atom
#
sudo rpm -Uhv https://atom.io/download/rpm
sudo yum install atom

#
# Configure thunderbird
#
gsettings set org.gnome.desktop.default-applications.office.calendar exec thunderbird
sudo vim /usr/share/applications/mozilla-thunderbird.desktop

# Edit the line
# MimeType=message/rfc822;x-scheme-handler/mailto;text/calendar;text/x-vcard;:

#Now, close text editor and update database file:
# update-desktop-database -q

#
# Grive
#
# Yet to come

#
# Install the python distributions
#
wget -t 3 https://bootstrap.pypa.io/ez_setup.py -O $SOURCES/ez_setup.py

wget -t 3 https://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz -O $SOURCES/Python-2.6.9.tgz
tar -zxf $SOURCES/Python-2.6.9.tgz -C $SOURCES
cd $SOURCES/Python-2.6.9
$SOURCES/Python-2.6.9/configure --enable-shlib --enable-profiling --enable-ipv6 && \
make && \
sudo make altinstall
# su -c "python2.6 $SOURCES/ez_setup.py && easy_install-2.6 pip && pip2.6 install virtualenv"

wget -t 3 https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz -O $SOURCES/Python-2.7.8.tgz
tar -zxf $SOURCES/Python-2.7.8.tgz -C $SOURCES
cd $SOURCES/Python-2.7.8
$SOURCES/Python-2.7.8/configure --enable-shlib --enable-profiling --enable-ipv6 && \
make && \
sudo make install
# su -c "python2.7 $SOURCES/ez_setup.py && easy_install-2.7 pip && pip2.7 install virtualenv"

wget -t 3 https://www.python.org/ftp/python/3.1.5/Python-3.1.5.tgz -O $SOURCES/Python-3.1.5.tgz
tar -zxf $SOURCES/Python-3.1.5.tgz -C $SOURCES
cd $SOURCES/Python-3.1.5
$SOURCES/Python-3.1.5/configure --enable-shlib --enable-profiling --enable-ipv6 && \
make && \
sudo make altinstall
# su -c "python3.1 $SOURCES/ez_setup.py && easy_install-3.1 pip && pip3.1 install virtualenv"

wget -t 3 https://www.python.org/ftp/python/3.2.6/Python-3.2.6.tgz -O $SOURCES/Python-3.2.6.tgz
tar -zxf $SOURCES/Python-3.2.6.tgz -C $SOURCES
cd $SOURCES/Python-3.2.6
$SOURCES/Python-3.2.6/configure --enable-shlib --enable-profiling --enable-ipv6 && \
make && \
sudo make altinstall
# su -c "python3.2 $SOURCES/ez_setup.py && easy_install-3.2 pip && pip3.2 install virtualenv"

wget -t 3 https://www.python.org/ftp/python/3.3.6/Python-3.3.6.tgz -O $SOURCES/Python-3.3.6.tgz
tar -zxf $SOURCES/Python-3.3.6.tgz -C $SOURCES
cd $SOURCES/Python-3.3.6
$SOURCES/Python-3.3.6/configure --enable-shlib --enable-profiling --enable-ipv6 && \
make && \
sudo make altinstall
# su -c "python3.3 $SOURCES/ez_setup.py && easy_install-3.3 pip && pip3.3 install virtualenv"

wget -t 3 https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz -O $SOURCES/Python-3.4.2.tgz
tar -zxf $SOURCES/Python-3.4.2.tgz -C $SOURCES
cd $SOURCES/Python-3.4.2
$SOURCES/Python-3.4.2/configure --enable-shlib --enable-profiling --enable-ipv6 && \
make && \
sudo make install
# su -c "python3.4 $SOURCES/ez_setup.py && easy_install-3.4 pip && pip3.4 install virtualenv"

#
# Install the R distributions
#
wget -t 3 http://cran.ms.unimelb.edu.au/src/base/R-3/R-3.1.2.tar.gz -O $SOURCES/R-3.1.2.tar.gz
tar -zxf $SOURCES/R-3.1.2.tar.gz -C $SOURCES
cd $SOURCES/R-3.1.2
$SOURCES/R-3.1.2/configure --enable-R-shlib && \
make && make check && sudo make install

sudo chmod o+w -R /usr/local/lib64/R

#
# RStudio
#
wget -t 3 http://download1.rstudio.org/rstudio-0.98.1091-x86_64.rpm -O $SOURCES/rstudio-0.98.1091-x86_64.rpm
sudo yum --nogpgcheck -y localinstall $SOURCES/rstudio-0.98.1091-x86_64.rpm

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
sudo ln -sf /usr/local/julia/0.3/julia /usr/local/bin/julia
sudo ln -sf /usr/local/julia/0.3/julia /usr/local/bin/julia-0.3

#
# perl stuff
#
sudo perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
sudo cpan -u
sudo cpan -i SOAP::Lite
sudo cpan -i Archive::Tar
sudo cpan -i List::MoreUtils

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
# Install some bio-packages
#

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

# BEAST
sudo mkdir /usr/local/beast

wget -t 3 -O $SOURCES/BEAST-1.8.1.tgz http://tree.bio.ed.ac.uk/download.php?id=91\&num=3
tar -zxf $SOURCES/BEAST-1.8.1.tgz -C $SOURCES
sudo mv $SOURCES/BEASTv1.8.1 /usr/local/beast/1.8.1
sudo ln -sf /usr/local/beast/1.8.1/bin/* /usr/local/bin/
sudo ln -sf /usr/local/beast/1.8.1/bin/beast /usr/local/bin/beast-1.8.1
sudo ln -sf /usr/local/beast/1.8.1/bin/beauti /usr/local/bin/beauti-1.8.1
sudo ln -sf /usr/local/beast/1.8.1/bin/loganalyser /usr/local/bin/loganalyser-1.8.1
sudo ln -sf /usr/local/beast/1.8.1/bin/logcombiner /usr/local/bin/logcombiner-1.8.1
sudo ln -sf /usr/local/beast/1.8.1/bin/treeannotator /usr/local/bin/treeannotator-1.8.1
sudo ln -sf /usr/local/beast/1.8.1/bin/treestat /usr/local/bin/treestat-1.8.1

# Bedtools
sudo mkdir /usr/local/bedtools

wget -t 3 -O $SOURCES/Bedtools2-2.22.0.tar.gz https://github.com/arq5x/bedtools2/archive/v2.22.0.tar.gz
tar -zxf $SOURCES/Bedtools2-2.22.0.tar.gz -C $SOURCES
cd $SOURCES/bedtools2-2.22.0
make && \
sudo mv $SOURCES/bedtools2-2.22.0 /usr/local/bedtools/2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/* /usr/local/bin && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/annotateBed /usr/local/bin/annotateBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bamToBed /usr/local/bin/bamToBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bamToFastq /usr/local/bin/bamToFastq-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bed12ToBed6 /usr/local/bin/bed12ToBed6-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bedpeToBam /usr/local/bin/bedpeToBam-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bedToBam /usr/local/bin/bedToBam-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bedToIgv /usr/local/bin/bedToIgv-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/bedtools /usr/local/bin/bedtools-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/closestBed /usr/local/bin/closestBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/clusterBed /usr/local/bin/clusterBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/complementBed /usr/local/bin/complementBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/coverageBed /usr/local/bin/coverageBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/expandCols /usr/local/bin/expandCols-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/fastaFromBed /usr/local/bin/fastaFromBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/flankBed /usr/local/bin/flankBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/genomeCoverageBed /usr/local/bin/genomeCoverageBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/getOverlap /usr/local/bin/getOverlap-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/groupBy /usr/local/bin/groupBy-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/intersectBed /usr/local/bin/intersectBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/linksBed /usr/local/bin/linksBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/mapBed /usr/local/bin/mapBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/maskFastaFromBed /usr/local/bin/maskFastaFromBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/mergeBed /usr/local/bin/mergeBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/multiBamCov /usr/local/bin/multiBamCov-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/multiIntersectBed /usr/local/bin/multiIntersectBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/nucBed /usr/local/bin/nucBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/pairToBed /usr/local/bin/pairToBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/pairToPair /usr/local/bin/pairToPair-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/randomBed /usr/local/bin/randomBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/shuffleBed /usr/local/bin/shuffleBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/slopBed /usr/local/bin/slopBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/sortBed /usr/local/bin/sortBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/subtractBed /usr/local/bin/subtractBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/tagBam /usr/local/bin/tagBam-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/unionBedGraphs /usr/local/bin/unionBedGraphs-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/windowBed /usr/local/bin/windowBed-2.22.0 && \
sudo ln -sf /usr/local/bedtools/2.22.0/bin/windowMaker /usr/local/bin/windowMaker-2.22.0

# BLAST+
sudo mkdir /usr/local/blast

wget -t 3 -O $SOURCES/ncbi-blast-2.2.30+-src.tar.gz ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.30/ncbi-blast-2.2.30+-src.tar.gz
tar -zxf $SOURCES/ncbi-blast-2.2.30+-src.tar.gz -C $SOURCES
cd $SOURCES/ncbi-blast-2.2.30+-src/c++
$SOURCES/ncbi-blast-2.2.30+-src/c++/configure && \
make && \
sudo mv $SOURCES/ncbi-blast-2.2.30+-src/c++ /usr/local/blast/2.2.30+ && \
rmdir $SOURCES/ncbi-blast-2.2.30+-src && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/* /usr/local/bin && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastdb_aliastool /usr/local/bin/blastdb_aliastool-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastn /usr/local/bin/blastn-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/deltablast /usr/local/bin/deltablast-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/makembindex /usr/local/bin/makembindex-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/rpstblastn /usr/local/bin/rpstblastn-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/tblastn /usr/local/bin/tblastn-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastdbcheck /usr/local/bin/blastdbcheck-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastp /usr/local/bin/blastp-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/dustmasker /usr/local/bin/dustmasker-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/makeprofiledb /usr/local/bin/makeprofiledb-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/seedtop /usr/local/bin/seedtop-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/tblastx /usr/local/bin/tblastx-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastdbcmd /usr/local/bin/blastdbcmd-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastx /usr/local/bin/blastx-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/gene_info_reader /usr/local/bin/gene_info_reader-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/project_tree_builder /usr/local/bin/project_tree_builder-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/segmasker /usr/local/bin/segmasker-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/update_blastdb.pl /usr/local/bin/update_blastdb.pl-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blastdbcp /usr/local/bin/blastdbcp-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/convert2blastmask /usr/local/bin/convert2blastmask-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/legacy_blast.pl /usr/local/bin/legacy_blast-2.2.30+.pl && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/psiblast /usr/local/bin/psiblast-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/seqdb_demo /usr/local/bin/seqdb_demo-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/windowmasker /usr/local/bin/windowmasker-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/blast_formatter /usr/local/bin/blast_formatter-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/datatool /usr/local/bin/datatool-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/makeblastdb /usr/local/bin/makeblastdb-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/rpsblast /usr/local/bin/rpsblast-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/seqdb_perf /usr/local/bin/seqdb_perf-2.2.30+ && \
sudo ln -sf /usr/local/blast/2.2.30+/ReleaseMT/bin/windowmasker_2.2.22_adapter.py /usr/local/bin/windowmasker_2.2.22_adapter-2.2.30+.py

# BWA
sudo mkdir /usr/local/bwa

wget -t 3 -O $SOURCES/bwa-0.7.10.tar.bz2 http://sourceforge.net/projects/bio-bwa/files/bwa-0.7.10.tar.bz2/download
tar -xjf $SOURCES/bwa-0.7.10.tar.bz2 -C $SOURCES
cd $SOURCES/bwa-0.7.10
make && \
sudo mv $SOURCES/bwa-0.7.10 /usr/local/bwa/0.7.10 && \
sudo ln -sf /usr/local/bwa/0.7.10/bwa /usr/local/bin/bwa && \
sudo ln -sf /usr/local/bwa/0.7.10/bwa /usr/local/bin/bwa-0.7.10 && \
sudo ln -sf /usr/local/bwa/0.7.10/qualfa2fq.pl /usr/local/bin/qualfa2fq.pl && \
sudo ln -sf /usr/local/bwa/0.7.10/qualfa2fq.pl /usr/local/bin/qualfa2fq-0.7.10.pl && \
sudo ln -sf /usr/local/bwa/0.7.10/xa2multi.pl /usr/local/bin/xa2multi.pl && \
sudo ln -sf /usr/local/bwa/0.7.10/xa2multi.pl /usr/local/bin/xa2multi-0.7.10.pl

# Clustal-O
sudo mkdir /usr/local/clustalo

wget -t 3 -O $SOURCES/clustal-omega-1.2.1.tar.gz http://www.clustal.org/omega/clustal-omega-1.2.1.tar.gz
tar -zxf $SOURCES/clustal-omega-1.2.1.tar.gz -C $SOURCES
cd $SOURCES/clustal-omega-1.2.1
$SOURCES/clustal-omega-1.2.1/configure && \
make && \
make check && \
sudo mv $SOURCES/clustal-omega-1.2.1 /usr/local/clustalo/1.2.1 && \
sudo ln -sf /usr/local/clustalo/1.2.1/src/clustalo /usr/local/bin/clustalo && \
sudo ln -sf /usr/local/clustalo/1.2.1/src/clustalo /usr/local/bin/clustalo-1.2.1

# Clustalw2
sudo mkdir /usr/local/clustalw
wget -t 3 -O $SOURCES/clustalw-2.1.tar.gz http://www.clustal.org/download/current/clustalw-2.1.tar.gz
tar -zxf $SOURCES/clustalw-2.1.tar.gz -C $SOURCES
cd $SOURCES/clustalw-2.1
$SOURCES/clustalw-2.1/configure && \
make && \
make check && \
sudo mv $SOURCES/clustalw-2.1 /usr/local/clustalw/2.1 && \
sudo ln -sf /usr/local/clustalw/2.1/src/clustalw2 /usr/local/bin/clustalw && \
sudo ln -sf /usr/local/clustalw/2.1/src/clustalw2 /usr/local/bin/clustalw2 && \
sudo ln -sf /usr/local/clustalw/2.1/src/clustalw2 /usr/local/bin/clustalw-2.1

# Dialign
sudo mkdir /usr/local/dialign

wget -t 3 -O $SOURCES/dialign_package.tgz http://dialign.gobics.de/download/dialign_package.tgz
tar -zxf $SOURCES/dialign_package.tgz -C $SOURCES
cd $SOURCES/dialign_package/src/
make && \
sudo rm *.o && \
sudo mv $SOURCES/dialign_package /usr/local/dialign/2 && \
sudo ln -sf /usr/local/dialign/2/src/dialign2-2 /usr/local/bin/dialign && \
sudo ln -sf /usr/local/dialign/2/src/dialign2-2 /usr/local/bin/dialign2-2 && \
sudo ln -sf /usr/local/dialign/2/src/dialign2-2 /usr/local/bin/dialign2 && \
sudo ln -sf /usr/local/dialign/2/src/dialign2-2 /usr/local/bin/dialign-2

# Note that setenv DIALIGN2_DIR /your_path/dialign2_dir/ is already in the .envs file

# Dialign-TX
sudo mkdir /usr/local/dialign-tx

wget -t 3 http://dialign-tx.gobics.de/DIALIGN-TX_1.0.2.tar.gz -O $SOURCES/DIALIGN-TX_1.0.2.tar.gz
tar -zxf $SOURCES/DIALIGN-TX_1.0.2.tar.gz -C $SOURCES
mv $SOURCES/DIALIGN-TX_1.0.2/source/Makefile $SOURCES/DIALIGN-TX_1.0.2/source/Makefile.old
cat $SOURCES/DIALIGN-TX_1.0.2/source/Makefile.old | sed s/-march=i686/-march=x86-64/ > $SOURCES/DIALIGN-TX_1.0.2/source/Makefile
cd $SOURCES/DIALIGN-TX_1.0.2/source
make && \
mv $SOURCES/DIALIGN-TX_1.0.2/source/dialign-tx $SOURCES/DIALIGN-TX_1.0.2/bin/dialign-tx && \
sudo mv $SOURCES/DIALIGN-TX_1.0.2 /usr/local/dialign-tx/1.0.2 && \
sudo ln -sf /usr/local/dialign-tx/1.0.2/bin/dialign-tx /usr/local/bin/dialign-tx && \
sudo ln -sf /usr/local/dialign-tx/1.0.2/bin/dialign-tx /usr/local/bin/dialign-tx-1.0.2

# Diamond
sudo mkdir /usr/local/diamond

wget -t 3 -O $SOURCES/diamond.tar.gz http://www-ab.informatik.uni-tuebingen.de/data/software/diamond/download/public/diamond.tar.gz
tar -zxf $SOURCES/diamond.tar.gz -C $SOURCES
cd $SOURCES/diamond
$SOURCES/diamond/configure && \
make && \
make check && \
sudo mv $SOURCES/diamond /usr/local/diamond/0.6.3 && \
sudo ln -sf /usr/local/diamond/0.6.3/diamond /usr/local/bin/diamond && \
sudo ln -sf /usr/local/diamond/0.6.3/diamond /usr/local/bin/diamond-0.6.3

# Entrez Direct
wget -t 3 -O $SOURCES/edirect.tar.gz ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz
tar -zxf $SOURCES/edirect.tar.gz -C $SOURCES
sudo mv $SOURCES/edirect /usr/local/edirect && \
sudo ln -sf /usr/local/edirect/!(README) /usr/local/bin/

# Figtree
sudo mkdir /usr/local/figtree

wget -t 3 -O $SOURCES/FigTree_v1.4.2.tgz http://tree.bio.ed.ac.uk/download.php?id=90\&num=3
tar -zxf $SOURCES/FigTree_v1.4.2.tgz -C $SOURCES
chmod a+x $SOURCES/FigTree_v1.4.2/bin/figtree
sudo mv $SOURCES/FigTree_v1.4.2 /usr/local/figtree/1.4.2 && \
sudo ln -sf /usr/local/figtree/1.4.2/bin/figtree /usr/local/bin/figtree && \
sudo ln -sf /usr/local/figtree/1.4.2/bin/figtree /usr/local/bin/figtree-1.4.2

# FSA
sudo mkdir /usr/local/fsa

wget -t 3 -O $SOURCES/fsa-1.15.9.tar.gz http://downloads.sourceforge.net/project/fsa/fsa-1.15.9.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ffsa%2F\&ts=1417869476\&use_mirror=softlayer-sng
tar -zxf $SOURCES/fsa-1.15.9.tar.gz -C $SOURCES
cd $SOURCES/fsa-1.15.9
$SOURCES/fsa-1.15.9/configure && \
make && \
sudo mv $SOURCES/fsa-1.15.9 /usr/local/fsa/1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/fsa /usr/local/bin/fsa && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/gapcleaner /usr/local/bin/gapcleaner && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/isect_mercator_alignment_gff /usr/local/bin/isect_mercator_alignment_gff && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/map_coords /usr/local/bin/map_coords && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/map_gff_coords /usr/local/bin/map_gff_coords && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/percentid /usr/local/bin/percentid && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/prot2codon /usr/local/bin/prot2codon && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/slice_fasta /usr/local/bin/slice_fasta && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/slice_fasta_gff /usr/local/bin/slice_fasta_gff && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/slice_mercator_alignment /usr/local/bin/slice_mercator_alignment && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/translate /usr/local/bin/translate && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/fsa /usr/local/bin/fsa-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/gapcleaner /usr/local/bin/gapcleaner-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/isect_mercator_alignment_gff /usr/local/bin/isect_mercator_alignment_gff-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/map_coords /usr/local/bin/map_coords-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/map_gff_coords /usr/local/bin/map_gff_coords-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/percentid /usr/local/bin/percentid-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/prot2codon /usr/local/bin/prot2codon-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/slice_fasta /usr/local/bin/slice_fasta-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/slice_fasta_gff /usr/local/bin/slice_fasta_gff-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/slice_mercator_alignment /usr/local/bin/slice_mercator_alignment-1.15.9 && \
sudo ln -sf /usr/local/fsa/1.15.9/src/main/translate /usr/local/bin/translate-1.15.9

# HMMER
sudo mkdir /usr/local/hmmer

wget -t 3 -O $SOURCES/hmmer-3.1b1.tar.gz ftp://selab.janelia.org/pub/software/hmmer3/3.1b1/hmmer-3.1b1.tar.gz
tar -zxf $SOURCES/hmmer-3.1b1.tar.gz -C $SOURCES
cd $SOURCES/hmmer-3.1b1
$SOURCES/hmmer-3.1b1/configure && \
make && \
make check && \
sudo mv $SOURCES/hmmer-3.1b1 /usr/local/hmmer/3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmalign /usr/local/bin/hmmalign && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmbuild /usr/local/bin/hmmbuild && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmconvert /usr/local/bin/hmmconvert && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmemit /usr/local/bin/hmmemit && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmfetch /usr/local/bin/hmmfetch && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmpgmd /usr/local/bin/hmmpgmd && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmpress /usr/local/bin/hmmpress && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmscan /usr/local/bin/hmmscan && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmsearch /usr/local/bin/hmmsearch && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmsim /usr/local/bin/hmmsim && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmstat /usr/local/bin/hmmstat && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/jackhmmer /usr/local/bin/jackhmmer && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/phmmer /usr/local/bin/phmmer && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/nhmmer /usr/local/bin/nhmmer && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/nhmmscan /usr/local/bin/nhmmscan && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/alimask /usr/local/bin/alimask && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmalign /usr/local/bin/hmmalign-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmbuild /usr/local/bin/hmmbuild-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmconvert /usr/local/bin/hmmconvert-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmemit /usr/local/bin/hmmemit-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmfetch /usr/local/bin/hmmfetch-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmpgmd /usr/local/bin/hmmpgmd-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmpress /usr/local/bin/hmmpress-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmscan /usr/local/bin/hmmscan-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmsearch /usr/local/bin/hmmsearch-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmsim /usr/local/bin/hmmsim-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/hmmstat /usr/local/bin/hmmstat-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/jackhmmer /usr/local/bin/jackhmmer-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/phmmer /usr/local/bin/phmmer-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/nhmmer /usr/local/bin/nhmmer-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/nhmmscan /usr/local/bin/nhmmscan-3.1b1 && \
sudo ln -sf /usr/local/hmmer/3.1b1/src/alimask /usr/local/bin/alimask-3.1b1

# Kalign
sudo mkdir /usr/local/kalign

wget -t 3 -O $SOURCES/kalign-2.tar.gz http://msa.sbc.su.se/downloads/kalign/current.tar.gz

mkdir $SOURCES/kalign-2
tar -zxf $SOURCES/kalign-2.tar.gz -C $SOURCES/kalign-2
cd $SOURCES/kalign-2
$SOURCES/kalign-2/configure && \
make && \
sudo mv $SOURCES/kalign-2 /usr/local/kalign/2 && \
sudo ln -sf /usr/local/kalign/2/kalign /usr/local/bin/kalign && \
sudo ln -sf /usr/local/kalign/2/kalign /usr/local/bin/kalign2 && \
sudo ln -sf /usr/local/kalign/2/kalign /usr/local/bin/kalign-2

# Kalignvu
sudo mkdir /usr/local/kalignvu

wget -t 3 -O $SOURCES/kalignvu_2.1.tgz http://msa.sbc.su.se/downloads/kalignvu_2.1.tgz
tar -zxf $SOURCES/kalignvu_2.1.tgz -C $SOURCES
cd $SOURCES/kalignvu_2.1
make && \
sudo mv $SOURCES/kalignvu_2.1 /usr/local/kalignvu/2.1 && \
sudo ln -sf /usr/local/kalignvu/2.1/kalignvu /usr/local/bin/kalignvu && \
sudo ln -sf /usr/local/kalignvu/2.1/kalignvu /usr/local/bin/kalignvu-2.1

# Mafft
sudo mkdir /usr/local/mafft

wget -t 3 -O $SOURCES/mafft-7.212.tgz http://mafft.cbrc.jp/alignment/software/mafft-7.212-with-extensions-src.tgz
tar -zxf $SOURCES/mafft-7.212.tgz -C $SOURCES
cd $SOURCES/mafft-7.212-with-extensions/core && \
make clean  && \
make && \
cd $SOURCES/mafft-7.212-with-extensions/extensions && \
make clean && \
make && \
sudo mv $SOURCES/mafft-7.212-with-extensions /usr/local/mafft/7.212 && \
sudo ln -sf /usr/local/mafft/7.212/scripts/* /usr/local/bin && \
sudo ln -sf /usr/local/mafft/7.212/scripts/mafft /usr/local/bin/mafft-7.212 && \
sudo ln -sf /usr/local/mafft/7.212/scripts/mafft-homologs.rb /usr/local/bin/mafft-homologs-7.212.rb && \
sudo ln -sf /usr/local/mafft/7.212/scripts/mafft-sparsecore.rb /usr/local/bin/mafft-sparsecore-7.212.rb

# Mafft binaries variable is set in .env

# msaprobs
sudo mkdir /usr/local/msaprobs

wget -t 3 -O $SOURCES/MSAProbs-0.9.7.tar.gz http://sourceforge.net/projects/msaprobs/files/MSAProbs-0.9.7.tar.gz/download
tar -zxf $SOURCES/MSAProbs-0.9.7.tar.gz -C $SOURCES
cd $SOURCES/MSAProbs-0.9.7/MSAProbs
make && \
sudo mv $SOURCES/MSAProbs-0.9.7 /usr/local/msaprobs/0.9.7 && \
sudo ln -sf /usr/local/msaprobs/0.9.7/MSAProbs/msaprobs /usr/local/bin/MSAProbs && \
sudo ln -sf /usr/local/msaprobs/0.9.7/MSAProbs/msaprobs /usr/local/bin/MSAProbs-0.9.7

# mummer
sudo mkdir /usr/local/mummer

wget -t 3 -O $SOURCES/MUMmer3.23.tar.gz http://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz/download
tar -zxf $SOURCES/MUMmer3.23.tar.gz -C $SOURCES
sudo mv $SOURCES/MUMmer3.23 /usr/local/mummer/3.23
cd /usr/local/mummer/3.23
make check && \
make install && \
sudo ln -sf /usr/local/mummer/3.23/annotate /usr/local/bin/annotate && \
sudo ln -sf /usr/local/mummer/3.23/combineMUMs /usr/local/bin/combineMUMs && \
sudo ln -sf /usr/local/mummer/3.23/delta-filter /usr/local/bin/delta-filter && \
sudo ln -sf /usr/local/mummer/3.23/dnadiff /usr/local/bin/dnadiff && \
sudo ln -sf /usr/local/mummer/3.23/exact-tandems /usr/local/bin/exact-tandems && \
sudo ln -sf /usr/local/mummer/3.23/gaps /usr/local/bin/gaps && \
sudo ln -sf /usr/local/mummer/3.23/mapview /usr/local/bin/mapview && \
sudo ln -sf /usr/local/mummer/3.23/mgaps /usr/local/bin/mgaps && \
sudo ln -sf /usr/local/mummer/3.23/mummer /usr/local/bin/mummer && \
sudo ln -sf /usr/local/mummer/3.23/mummerplot /usr/local/bin/mummerplot && \
sudo ln -sf /usr/local/mummer/3.23/nucmer /usr/local/bin/nucmer && \
sudo ln -sf /usr/local/mummer/3.23/nucmer2xfig /usr/local/bin/nucmer2xfig && \
sudo ln -sf /usr/local/mummer/3.23/promer /usr/local/bin/promer && \
sudo ln -sf /usr/local/mummer/3.23/repeat-match /usr/local/bin/repeat-match && \
sudo ln -sf /usr/local/mummer/3.23/run-mummer1 /usr/local/bin/run-mummer1 && \
sudo ln -sf /usr/local/mummer/3.23/run-mummer3 /usr/local/bin/run-mummer3 && \
sudo ln -sf /usr/local/mummer/3.23/show-aligns /usr/local/bin/show-aligns && \
sudo ln -sf /usr/local/mummer/3.23/show-coords /usr/local/bin/show-coords && \
sudo ln -sf /usr/local/mummer/3.23/show-diff /usr/local/bin/show-diff && \
sudo ln -sf /usr/local/mummer/3.23/show-snps /usr/local/bin/show-snps && \
sudo ln -sf /usr/local/mummer/3.23/show-tiling /usr/local/bin/show-tiling && \
sudo ln -sf /usr/local/mummer/3.23/annotate /usr/local/bin/annotate-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/combineMUMs /usr/local/bin/combineMUMs-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/delta-filter /usr/local/bin/delta-filter-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/dnadiff /usr/local/bin/dnadiff-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/exact-tandems /usr/local/bin/exact-tandems-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/gaps /usr/local/bin/gaps-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/mapview /usr/local/bin/mapview-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/mgaps /usr/local/bin/mgaps-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/mummer /usr/local/bin/mummer-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/mummerplot /usr/local/bin/mummerplot-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/nucmer /usr/local/bin/nucmer-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/nucmer2xfig /usr/local/bin/nucmer2xfig-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/promer /usr/local/bin/promer-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/repeat-match /usr/local/bin/repeat-match-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/run-mummer1 /usr/local/bin/run-mummer1-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/run-mummer3 /usr/local/bin/run-mummer3-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/show-aligns /usr/local/bin/show-aligns-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/show-coords /usr/local/bin/show-coords-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/show-diff /usr/local/bin/show-diff-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/show-snps /usr/local/bin/show-snps-3.23 && \
sudo ln -sf /usr/local/mummer/3.23/show-tiling /usr/local/bin/show-tiling-3.23

# Mumsa
sudo mkdir /usr/local/mumsa

wget -t 3 -O $SOURCES/mumsa-1.0.tgz http://msa.sbc.su.se/downloads/mumsa-1.0.tgz
tar -zxf $SOURCES/mumsa-1.0.tgz -C $SOURCES
cd $SOURCES/mumsa-1.0
make && \
sudo mv $SOURCES/mumsa-1.0 /usr/local/mumsa/1.0 && \
sudo ln -sf /usr/local/mumsa/1.0/mumsa /usr/local/bin/mumsa && \
sudo ln -sf /usr/local/mumsa/1.0/mumsa /usr/local/bin/mumsa-1.0

# muscle
sudo mkdir /usr/local/muscle

wget -t 3 -O $SOURCES/muscle3.8.31_i86linux64.tar.gz http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86linux64.tar.gz
mkdir $SOURCES/muscle
tar -zxf $SOURCES/muscle3.8.31_i86linux64.tar.gz -C $SOURCES/muscle
sudo mv $SOURCES/muscle /usr/local/muscle/3.8.31 && \
sudo ln -sf /usr/local/muscle/3.8.31/muscle3.8.31_i86linux64 /usr/local/bin/muscle && \
sudo ln -sf /usr/local/muscle/3.8.31/muscle3.8.31_i86linux64 /usr/local/bin/muscle-3.8.31

# ninja
sudo mkdir /usr/local/ninja

wget -t 3 -O $SOURCES/ninja_1.2.2.tgz http://nimbletwist.com/software/ninja/old_distros/ninja_1.2.2.tgz
tar -zxf $SOURCES/ninja_1.2.2.tgz -C $SOURCES
sudo mv $SOURCES/ninja_1.2.2 /usr/local/ninja/1.2.2 && \
sudo ln -s /usr/local/ninja/1.2.2/ninja /usr/local/bin/ninja && \
sudo ln -s /usr/local/ninja/1.2.2/ninja /usr/local/bin/ninja-1.2.2

# Phylip
sudo mkdir /usr/local/phylip

wget -t 3 -O $SOURCES/phylip-3.696.tar.gz http://evolution.gs.washington.edu/phylip/download/phylip-3.696.tar.gz
tar -zxf $SOURCES/phylip-3.696.tar.gz -C $SOURCES
cd $SOURCES/phylip-3.696/src
make -f $SOURCES/phylip-3.696/src/Makefile.unx install && \
sudo mv $SOURCES/phylip-3.696 /usr/local/phylip/3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/* /usr/local/bin && \
sudo rm /usr/local/bin/font* && \
sudo ln -sf /usr/local/phylip/3.696/exe/clique /usr/local/bin/clique-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/consense /usr/local/bin/consense-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/contml /usr/local/bin/contml-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/contrast /usr/local/bin/contrast-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnacomp /usr/local/bin/dnacomp-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnadist /usr/local/bin/dnadist-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnainvar /usr/local/bin/dnainvar-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnaml /usr/local/bin/dnaml-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnamlk /usr/local/bin/dnamlk-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnamove /usr/local/bin/dnamove-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnapars /usr/local/bin/dnapars-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dnapenny /usr/local/bin/dnapenny-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dollop /usr/local/bin/dollop-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dolmove /usr/local/bin/dolmove-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/dolpenny /usr/local/bin/dolpenny-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/drawgram /usr/local/bin/drawgram-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/DrawGram.jar /usr/local/bin/DrawGram-3.696.jar && \
sudo ln -sf /usr/local/phylip/3.696/exe/DrawGramJava.unx /usr/local/bin/DrawGramJava-3.696.unx && \
sudo ln -sf /usr/local/phylip/3.696/exe/drawtree /usr/local/bin/drawtree-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/DrawTree.jar /usr/local/bin/DrawTree-3.696.jar && \
sudo ln -sf /usr/local/phylip/3.696/exe/DrawTreeJava.unx /usr/local/bin/DrawTreeJava-3.696.unx && \
sudo ln -sf /usr/local/phylip/3.696/exe/factor /usr/local/bin/factor-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/fitch /usr/local/bin/fitch-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/gendist /usr/local/bin/gendist-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/kitsch /usr/local/bin/kitsch-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/libdrawgram.so /usr/local/bin/libdrawgram-3.696.so && \
sudo ln -sf /usr/local/phylip/3.696/exe/libdrawtree.so /usr/local/bin/libdrawtree-3.696.so && \
sudo ln -sf /usr/local/phylip/3.696/exe/mix /usr/local/bin/mix-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/move /usr/local/bin/move-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/neighbor /usr/local/bin/neighbor-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/pars /usr/local/bin/pars-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/penny /usr/local/bin/penny-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/proml /usr/local/bin/proml-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/promlk /usr/local/bin/promlk-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/protdist /usr/local/bin/protdist-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/protpars /usr/local/bin/protpars-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/restdist /usr/local/bin/restdist-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/restml /usr/local/bin/restml-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/retree /usr/local/bin/retree-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/seqboot /usr/local/bin/seqboot-3.696 && \
sudo ln -sf /usr/local/phylip/3.696/exe/treedist /usr/local/bin/treedist-3.696

# PhyML
sudo mkdir /usr/local/phyml

wget -t 3 -O $SOURCES/phyml-20120412.tar.gz https://github.com/stephaneguindon/phyml-downloads/releases/download/stable/phyml-20120412.tar.gz
tar -zxf $SOURCES/phyml-20120412.tar.gz -C $SOURCES
cd $SOURCES/phyml-20120412
$SOURCES/phyml-20120412/configure && \
make && \
sudo mv $SOURCES/phyml-20120412 /usr/local/phyml/20120412 && \
sudo ln -sf /usr/local/phyml/20120412/src/phyml /usr/local/bin/phyml && \
sudo ln -sf /usr/local/phyml/20120412/src/phyml /usr/local/bin/phyml-20120412

# Quicktree
sudo mkdir /usr/local/quicktree

wget -t 3 -O $SOURCES/quicktree.tar.gz ftp://ftp.sanger.ac.uk/pub/resources/software/quicktree/quicktree.tar.gz
tar -zxf $SOURCES/quicktree.tar.gz -C $SOURCES
cd $SOURCES/quicktree_1.1
make quicktree && \
sudo mv $SOURCES/quicktree_1.1 /usr/local/quicktree/1.1 && \
sudo ln -sf /usr/local/quicktree/1.1/bin/quicktree /usr/local/bin/quicktree && \
sudo ln -sf /usr/local/quicktree/1.1/bin/quicktree /usr/local/bin/quicktree-1.1

# RAxML
sudo mkdir /usr/local/raxml

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
sudo mv $SOURCES/RAxML /usr/local/raxml/8.1.7 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-MPI-SSE3 /usr/local/bin/raxml-mpi-SSE3 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-MPI-SSE3 /usr/local/bin/raxml-mpi-SSE3-8.1.7 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-SSE3 /usr/local/bin/raxml-pthreads-SSE3 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-SSE3 /usr/local/bin/raxml-pthreads-SSE3-8.1.7 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-SSE3 /usr/local/bin/raxml-SSE3 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-SSE3 /usr/local/bin/raxml-SSE3-8.1.7 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-MPI-AVX /usr/local/bin/raxml-mpi-AVX && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-MPI-AVX /usr/local/bin/raxml-mpi-AVX-8.1.7 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-AVX /usr/local/bin/raxml-pthreads-AVX && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-AVX /usr/local/bin/raxml-pthreads-AVX-8.1.7 && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-PTHREADS-AVX /usr/local/bin/raxml-AVX && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-MPI-AVX /usr/local/bin/raxml && \
sudo ln -sf /usr/local/raxml/8.1.7/raxmlHPC-MPI-AVX /usr/local/bin/raxml-8.1.7

# Requires mpicc in path

# T-Coffee
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

sudo mv $SOURCES/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64 /usr/local/tcoffee/11.00.8cbe486 && \
sudo ln -sf /usr/local/tcoffee/11.00.8cbe486/bin/t_coffee /usr/local/bin/t_coffee && \
sudo ln -sf /usr/local/tcoffee/11.00.8cbe486/bin/t_coffee /usr/local/bin/t_coffee-11.00.8cbe486

# Tracer
sudo mkdir /usr/local/tracer

wget -t 3 -O $SOURCES/Tracer_v1.6.tgz http://tree.bio.ed.ac.uk/download.php?id=88\&num=3
tar -zxf $SOURCES/Tracer_v1.6.tgz -C $SOURCES
chmod a+x $SOURCES/Tracer_v1.6/bin/tracer
sudo mv $SOURCES/Tracer_v1.6 /usr/local/tracer/1.6 && \
sudo ln -sf /usr/local/tracer/1.6/bin/tracer /usr/local/bin/tracer && \
sudo ln -sf /usr/local/tracer/1.6/bin/tracer /usr/local/bin/tracer-1.6

# TrimAL
sudo mkdir /usr/local/trimal

wget -t 3 -O $SOURCES/trimal.v1.2rev59.tar.gz http://trimal.cgenomics.org/_media/trimal.v1.2rev59.tar.gz
tar -zxf $SOURCES/trimal.v1.2rev59.tar.gz -C $SOURCES
cd $SOURCES/trimAl/source
make && \
sudo mv $SOURCES/trimAl /usr/local/trimal/1.2rev59 && \
sudo ln -sf /usr/local/trimal/1.2rev59/source/trimal /usr/local/bin/trimal && \
sudo ln -sf /usr/local/trimal/1.2rev59/source/readal /usr/local/bin/readal && \
sudo ln -sf /usr/local/trimal/1.2rev59/source/trimal /usr/local/bin/trimal-1.2rev59 && \
sudo ln -sf /usr/local/trimal/1.2rev59/source/readal /usr/local/bin/readal-1.2rev59

# Velvet
sudo mkdir /usr/local/velvet

wget -t 3 -O $SOURCES/velvet_1.2.10.tgz https://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz
tar -zxf $SOURCES/velvet_1.2.10.tgz -C $SOURCES
cd $SOURCES/velvet_1.2.10
make && \
sudo mv $SOURCES/velvet_1.2.10 /usr/local/velvet/1.2.10 && \
sudo ln -sf /usr/local/velvet/1.2.10/velveth /usr/local/bin/velveth && \
sudo ln -sf /usr/local/velvet/1.2.10/velvetg /usr/local/bin/velvetg && \
sudo ln -sf /usr/local/velvet/1.2.10/velveth /usr/local/bin/velveth-1.2.10 && \
sudo ln -sf /usr/local/velvet/1.2.10/velvetg /usr/local/bin/velvetg-1.2.10

## Oases
#sudo mkdir /usr/local/oases

#wget -t 3 -O $SOURCES/oases_0.2.08.tgz http://www.ebi.ac.uk/~zerbino/oases/oases_0.2.08.tgz
#tar -zxf $SOURCES/oases_0.2.08.tgz -C $SOURCES
#cd $SOURCES/oases_0.2.8
#make
#sudo mv $SOURCES/oases_0.2.8 /usr/local/oases/0.2.8
## link executables

#cd $HOME
