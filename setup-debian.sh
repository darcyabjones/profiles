sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list
sudo echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list

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
	r-base r-base-dev \
	julia \
	nodejs nodejs-dev npm \
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
	xclip
	
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


sudo chsh -s $(which zsh) darcy
