#/bin/bash

# install zsh
if [ -x "$(command -v apk)" ];       then installer="sudo apk add --no-cache"
elif [ -x "$(command -v apt)" ];     then installer="sudo apt update && sudo apt install -y"
elif [ -x "$(command -v dnf)" ];     then installer="sudo dnf install"
elif [ -x "$(command -v zypper)" ];  then installer="sudo zypper install"
elif [ -x "$(command -v pacman)" ];  then installer="sudo pacman --noconfirm -S"
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: zsh">&2; exit; fi

sh -c "$installer zsh"

# install oh-my-zsh
touch ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install msfvenom autocompletion plugin
git clone https://github.com/Green-m/msfvenom-zsh-completion ~/.oh-my-zsh/custom/plugins/msfvenom/
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
    pip\
    aliases\
    sublime\
    sudo\
    docker\
    copyfile\
    copydir\
    command-not-found\
    zsh-syntax-highlighting\
    zsh-autosuggestions\
    msfvenom\
)/g' ~/.zshrc
sed -iE 's/ZSH_THEME=.*/ZSH_THEME="dst"/g' ~/.zshrc
# restart shell
exec zsh
