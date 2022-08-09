BLUE='\033[0;34m'

RED='\033[0;31m'
NC='\033[0m'
echo "${BLUE}downloading latest nightly from repo ${NC}"

curl -LOs /tmp/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

echo "${BLUE}extracting tar${NC}"
tar -xzf /tmp/nvim-linux64.tar.gz -C /tmp/

cp -rf /tmp/nvim-linux64/ /home/nishanth/installs/
echo "${BLUE}copying binary${NC}"
echo "${BLUE}done${NC}"
