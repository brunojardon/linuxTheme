#!/bin/bash

# Full upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get full-upgrade -y

# Install dependences
sudo apt-get install -fy git curl wget make zsh nemo inkscape dconf-cli uuid-runtime libsass1 sassc gnome-themes-extra gtk2-engines-murrine feh

# Download themes
git clone https://github.com/vinceliuice/Orchis-theme.git "$HOME/Orchis-theme"
git clone https://github.com/vinceliuice/Tela-icon-theme.git "$HOME/Tela-icon"
git clone https://github.com/varlesh/volantes-cursors.git "$HOME/Volantes-cursor"

# Install Orchis theme
cd $HOME/Orchis-theme
sudo ./install.sh -d /usr/share/themes -t default -c dark -s compact --tweaks compact
# Install Tela icons
cd $HOME/Tela-icon
sudo ./install.sh -d /usr/share/icons
# Install Volantes cursors
cd $HOME/Volantes-cursors
make build
sudo make install

# Remove installers
rm -rf $HOME/Orchis-theme $HOME/Tela-icon $HOME/Volantes-cursors
gsettings set org.gnome.shell.extensions.user-theme name "Orchis-Dark-Compact"
gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Dark-Compact"
gsettings set org.gnome.desktop.interface icon-theme "Tela-dark"
gsettings set org.gnome.desktop.interface cursor-theme "volantes_cursors"

# Download fonts
# Roboto Regular
sudo wget "https://github.com/google/fonts/raw/main/apache/roboto/Roboto%5Bwdth%2Cwght%5D.ttf" /usr/share/fonts/

# Roboto Mono
sudo wget "https://github.com/google/fonts/raw/main/apache/robotomono/RobotoMono%5Bwght%5D.ttf" /usr/share/fonts/

# Inconsolata Nerd Font
sudo curl 'https://objects.githubusercontent.com/github-production-release-asset-2e65be/27574418/a81d82a9-d27c-448c-a68e-eb4270281808?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230727%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230727T131408Z&X-Amz-Expires=300&X-Amz-Signature=ec44386a57f83fec4d15b029995502636fc73088ed4ec08bf13cc660c10f2313&X-Amz-SignedHeaders=host&actor_id=84813771&key_id=0&repo_id=27574418&response-content-disposition=attachment%3B%20filename%3DInconsolata.zip&response-content-type=application%2Foctet-stream' /usr/share/fonts/
sudo unzip /usr/share/fonts/Inconsolata.zip
sudo rm -rf /usr/share/fonts/Inconsolata.zip

# Set fonts
gsettings set org.gnome.desktop.interface font-name "Roboto Regular 10"
gsettings set org.gnome.desktop.interface document-font-name "Roboto Regular 10"
gsettings set org.gnome.desktop.interface monospace-font-name "Roboto Mono Regular 10"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Regular 10"

# Download background
sudo wget 'https://w.wallhaven.cc/full/x8/wallhaven-x8893d.png' /usr/share/backgrounds/ -o "debianWallpaper.png"
# Set background
feh --bg-fill "/usr/share/backgrounds/debianWallpaper.png"

# Set zsh default shell
chsh -s /usr/bin/zsh $USER

# ohMyZsh! install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Powerlevel10k install
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Removing iusses dependences
sudo apt remove --purge -y feh inkscape

# Cleanup
sudo apt autoremove -y
sudo apt autoclean
