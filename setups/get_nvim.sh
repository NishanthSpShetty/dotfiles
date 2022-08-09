BLUE='\033[0;34m'

RED='\033[0;31m'
NC='\033[0m'
echo -e "${BLUE}downloading latest nightly from repo ${NC}"

sudo curl -LOs /tmp/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

echo -e "${BLUE}extracting tar${NC}"
sudo tar -xzf /tmp/nvim-linux64.tar.gz -C /tmp/

echo -e "${BLUE}copying binary${NC}"
sudo cp -rf /tmp/nvim-linux64/ /home/nishanth/installs/
echo -e "${BLUE}done${NC}"
