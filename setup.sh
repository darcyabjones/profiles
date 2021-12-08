# Install tmux git, zsh and neovim
mv ${HOME}/.bashrc ${HOME}/.bashrc.bkp

ln -sf "${PWD}/Rprofile" "${HOME}/.Rprofile"
ln -sf "${PWD}/aliases" "${HOME}/.aliases"
ln -sf "${PWD}/bash_profile" "${HOME}/.bash_profile"
ln -sf "${PWD}/bashrc" "${HOME}/.bashrc"
ln -sf "${PWD}/condarc" "${HOME}/.condarc"
ln -sf "${PWD}/env" "${HOME}/.env"
ln -sf "${PWD}/inputrc" "${HOME}/.inputrc"
ln -sf "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
ln -sf "${PWD}/zshrc" "${HOME}/.zshrc"

sudo chsh -s "$(which zsh)" "${USER}"

curl -L git.io/antigen > "${HOME}/.antigen.zsh"

mkdir -p "${HOME}/.config/nvim"
ln -sf "${PWD}/nvim/init.vim" "${HOME}/.config/nvim/init.vim"

git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
tmux source "${HOME}/.tmux.conf"
"${HOME}"/.tmux/plugins/tpm/bin/install_plugins


sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c ":PlugInstall" -c ":q" -c ":q"
