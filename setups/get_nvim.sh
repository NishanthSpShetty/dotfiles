echo "downloading latest nightly from repo"

curl -L -o /tmp/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

echo "extracting tar"
tar -xzf /tmp/nvim-linux64.tar.gz -C /tmp/

echo "copying binary"
cp -rf /tmp/nvim-linux64/ /home/nishanth/installs/
echo "done"
