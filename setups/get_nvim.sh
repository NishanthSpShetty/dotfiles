BLUE='\033[0;34m'

RED='\033[0;31m'
NC='\033[0m'

TEMP=~/update_nvim
mkdir $TEMP

echo -e "${BLUE}downloading latest nightly from repo ${NC}"

curl -L -o $TEMP/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

echo -e "${BLUE}extracting tar${NC}"
tar -xzf $TEMP/nvim-linux64.tar.gz -C $TEMP/

echo -e "${BLUE}copying binary${NC}"
mv $TEMP/nvim-linux64 $HOME/installs/
echo -e "${BLUE}done${NC}"
