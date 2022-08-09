# run this with whatever shell you have, should work for all, (at least with bash or sh)
# initialise the new system

GREEN='\033[0;32m'
RED='\033[0;31m'



mkdir -p ~/.config/alacritty/ ~/installs/bin/

cp ../starship.toml ~/.config/
cp ../.zshrc ~
cp ../alacritty/alacritty.yml ~/.config/alacritty/
cp -r ../vimrc/nvim-lsp/ ~/.config/nvim/

cd
sudo apt update
echo "${GREEN}installing git"
sudo apt install -yq git

# setup oh my zsh
echo "${GREEN}installing zsh"
sudo apt install -yq zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# setup tmux 

echo "${GREEN}installing tmux"
sudo apt install -yq tmux
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# add continuum and resurrect to tmux (save and resume session)
echo "${GREEN}installing tmux plugins"
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect/
git clone https://github.com/tmux-plugins/tmux-continuum ~/.tmux/tmux-continuum/
echo <<EOF >> .tmux/.tmux.conf  
run-shell ~/.tmux/tmux-resurrect/resurrect.tmux
run-shell ~/.tmux/tmux-continuum/continuum.tmux
set -g @resurrect-strategy-nvim 'session'
set -g @continuum-restore 'on'
EOF

## install alacritty
echo "${GREEN}installing alacritty"
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt install -yq alacritty

# install nvim 
echo "${GREEN}installing nvim..."
bash get_nvim.sh
# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# required tools 
echo "${GREEN}installing golang"
sudo apt install -yq golang 

echo "${GREEN}installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo "${GREEN}installing starship"
curl -sS https://starship.rs/install.sh | sh -s -- -y
# docker
echo "${GREEN}installing docker"
sudo apt install -yq \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt get install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "${GREEN}installing nerd fonts"
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Agave.zip
unzip Agave.zip -d ~/.local/share/fonts/
fc-cache -fv

echo "${RED} Setup completed, hack away"
