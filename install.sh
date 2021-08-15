#/bin/bash

# install zsh
sudo apt update
sudo apt install -y zsh

# install oh-my-zsh
touch ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# install powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# set plugins and theme
sed -iE 's/plugins=[(]git[)]/plugins=(\
    git\
    colored-man-pages\
    jump\
    sublime\
    sudo\
    themes\
    copyfile\
    copydir\
    command-not-found\
    zsh-syntax-highlighting\
    zsh-autosuggestions\
)/g' ~/.zshrc
sed -iE 's/ZSH_THEME=.*/ZSH_THEME="dst"/g' ~/.zshrc
# restart shell
exec zsh
