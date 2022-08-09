# run this with whatever shell you have, should work for all, (at least with bash or sh)
# initialise the new system


cd

mkdir -p ~/.config/alacritty/ ~/installs/bin/

cp ../starship.toml ~/.config/
cp ../zshrc ~
cp ../alacritty/alacritty.yml ~/.config/
cp -r ../vimrc/nvim-lsp/ ~/.config/nvim/

# setup oh my zsh
sudo apt install -yq zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# setup tmux 
sudo apt install -yq tmux
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# add continuum and resurrect to tmux (save and resume session)
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect/
git clone https://github.com/tmux-plugins/tmux-continuum ~/.tmux/tmux-continuum/
echo <<EOF >> .tmux/.tmux.conf  
run-shell ~/.tmux/tmux-resurrect/resurrect.tmux
run-shell ~/.tmux/tmux-continuum/continuum.tmux
set -g @resurrect-strategy-nvim 'session'
set -g @continuum-restore 'on'
EOF

## install alacritty
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt install -yq alacritty

# install nvim 
bash get_nvim.sh
# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# required tools 
sudo apt install -yq golang 

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# docker
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


