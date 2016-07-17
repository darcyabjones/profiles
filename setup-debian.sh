sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list
sudo echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list

wget -q -O - https://deb.nodesource.com/setup_4.x | sudo bash -

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install -yq \
	vim \
	zsh \
	git \
	wget \
	tmux \
	gparted \
	julia \
	nodejs nodejs-dev npm nodejs-legacy \
	texlive texlive-base texlive-latex-base texlive-latex-extra texlive-latex-recommended \
	pandoc \
	nautilus-dropbox \
	grive \
	python3-dev python3-pip libpython3-dev \
	python-dev python-pip libpython-dev \
	libzmq3 libzmq3-dev \
	libfreetype6 libfreetype6-dev \
	libxft \
	pkg-config \
	openmpi-bin openmpi-common \
	parallel \
	sqlite3 libsqlite3-dev \
	xclip \
	google-chrome-stable \
	fonts-inconsolata \
	libcurl4-openssl-dev \
	openjdk-7-jdk openjdk-7-jre openjdk-7-source \
	libcairo2 libcairo2-dev \
	libtiff5 libtiff5-dev \
	libxml2-dev


sudo apt-get install -yq \
	igv \
	bedtools \
	ncbi-blast+ ncbi-blast+-legacy blast2 \
	emboss \
	hmmer \
	clustalo clustalw \
	poa \
	t-coffee \
	probcons \
	dialign dialign-tx \
	muscle \
	mafft \
	kalign \
	mummer \
	raxml \
	phyml \
	beast-mcmc \
	figtree \
	prank \
	primer3 \
	fastqc



ssh-keygen -t rsa -C "darcy.ab.jones@gmail.com" -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

git config --global user.name "Darcy Jones"
git config --global user.email "darcy.ab.jones@gmail.com"

wget https://atom.io/download/deb -O ~/Downloads/atom-amd64.deb && sudo dpkg -i ~/Downloads/atom-amd64.deb


su -c "wget -qO - ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz \
    | tar zxf - -C /usr/local && \
    /usr/local/edirect/setup.sh"

export PATH=$PATH:/usr/local/edirect


# Samtools ecosystem
sudo apt-get update && apt-get install -yq zlib1g-dev libncurses5 libncurses5-dev

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

# Rstudio
wget https://download1.rstudio.org/rstudio-0.99.902-amd64.deb -O ~/Downloads/rstudio-0.99.902-amd64.deb && sudo dpkg -i ~/Downloads/rstudio-0.99.902-amd64.deb

# setup google drive
grive -a
And follow the instructions (you will have to log into your account with a browser, confirm that you want to allow grive to access your drive and copy paste the given code to the terminal, pretty easy).

Then start the synchronisation for example like this:
grive -p $HOME/Grive

sudo pip3 install numpy pandas scipy sympy matplotlib biopython jupyter

git clone git@github.com:darcyabjones/profiles.git $HOME/.profiles

ln -sf $HOME/.profiles/aliases $HOME/.aliases
ln -sf $HOME/.profiles/bash_profile $HOME/.bash_profile
ln -sf $HOME/.profiles/bashrc $HOME/.bashrc
ln -sf $HOME/.profiles/env $HOME/.env
ln -sf $HOME/.profiles/Rprofile $HOME/.Rprofile
ln -sf $HOME/.profiles/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.profiles/zshrc $HOME/.zshrc


mkdir $HOME/bin

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

sudo perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
sudo cpan -u

# Docker

sudo apt-get install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
sudo apt-get update && sudo apt-cache policy docker-engine
sudo apt-get update && sudo apt-get install docker-engine && sudo service docker start


sudo npm install -g ijavascript

## R
wget -O - cran.ms.unimelb.edu.au/src/base/R-3/R-3.3.0.tar.gz | tar -C $HOME/bin -zxf -
cd $HOME/bin/R-3.3.0 && ./configure --enable-R-shlib && make && sudo make install
sudo ln -sf $HOME/.profiles/Rprofile /root/.Rprofile
sudo Rscript -e "install.packages(c('pbdZMQ', 'repr', 'ggplot2', 'devtools', 'dplyr', 'knitr'))"
sudo Rscript -e "devtools::install_github('IRkernel/IRdisplay', force = TRUE)"
sudo Rscript -e "devtools::install_github('IRkernel/IRkernel', force = TRUE)"
sudo Rscript -e "IRkernel::installspec(name = 'ir330', displayname = 'R 3.3.0')"
Rscript -e "IRkernel::installspec(name = 'ir330', displayname = 'R 3.3.0')"
sudo Rscript -e "source('https://bioconductor.org/biocLite.R');biocLite()"


sudo pip3 install cython
sudo pip3 install numpy scipy sympy pandas matplotlib biopython

sudo chsh -s $(which zsh) darcy
