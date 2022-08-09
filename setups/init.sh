# run this with whatever shell you have, should work for all, (at least with bash or sh)
# initialise the new system

GREEN='\033[0;32m'
NC='\033[0m'
RED='\033[0;31m'


DOT_PATH=${PWD}

mkdir -p ~/.config/alacritty/ ~/installs/bin/

cp ../starship.toml ~/.config/
cp ../alacritty/alacritty.yml ~/.config/alacritty/
cp -r ../vimrc/nvim-lsp/ ~/.config/nvim/


cd
sudo apt -qq update
echo -e "${GREEN}installing git ${NC}"
sudo apt -qq install -yq git

# setup oh my zsh
echo -e "${GREEN}installing zsh${NC}"
sudo apt -qq install -yq zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# copy zshrc 

cp ${DOT_PATH}/../.zshrc ~/
# setup tmux 

echo -e "${GREEN}installing tmux${NC}"
sudo apt -qq install -yq tmux
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# add continuum and resurrect to tmux (save and resume session)
echo -e "${GREEN}installing tmux plugins${NC}"
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect/
git clone https://github.com/tmux-plugins/tmux-continuum ~/.tmux/tmux-continuum/
cat <<EOF >> ~/.tmux/.tmux.conf  
run-shell ~/.tmux/tmux-resurrect/resurrect.tmux
run-shell ~/.tmux/tmux-continuum/continuum.tmux
set -g @resurrect-strategy-nvim 'session'
set -g @continuum-restore 'on'
EOF

## install alacritty
echo -e "${GREEN}installing alacritty${NC}"
sudo add-apt -qq-repository ppa:mmstick76/alacritty
sudo apt -qq install -yq alacritty

# install nvim 
echo -e "${GREEN}installing nvim...${NC}"
bash ./get_nvim.sh
# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# required tools 
echo -e "${GREEN}installing golang${NC}"
sudo apt -qq -qq install -yq golang 

echo -e "${GREEN}installing rust${NC}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo -e "${GREEN}installing starship${NC}"
curl -sS https://starship.rs/install.sh | sh -s -- -y
# docker
echo -e "${GREEN}installing docker${NC}"
sudo apt -qq install -yq \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -qq update && sudo apt -qq get install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo -e "${GREEN}installing nerd fonts${NC}"
curl -LOs https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Agave.zip
unzip Agave.zip -d ~/.local/share/fonts/
fc-cache -fv

echo -e "${RED} Setup completed, hack away${NC}"
