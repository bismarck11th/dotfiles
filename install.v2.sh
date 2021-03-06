#!/bin/sh

cd ~

## ----------------------------------------
##  System Preferences
## ----------------------------------------
echo 'start: setup System Preferences'
# ブート時のサウンドを無効化する
sudo nvram SystemAudioVolume=" "

# 動きを高速化
defaults write -g com.apple.trackpad.scaling 3 && \
defaults write -g com.apple.mouse.scaling 1.5 && \
defaults write -g KeyRepeat -int 1 && \
defaults write -g InitialKeyRepeat -int 10

# タップしたときクリック
defaults write -g com.apple.mouse.tapBehavior -int 1

# 三本指でドラッグ
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

## スクロールバーを常時表示
defaults write -g AppleShowScrollBars -string "Always"

# Finder:隠しファイル/フォルダを表示
defaults write com.apple.finder AppleShowAllFiles tree

# Finder:拡張子を表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## Finder のタイトルバーにフルパスを表示する
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

## 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder _FXSortFoldersFirst -bool true

## ネットを早くする
networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8
echo 'complete: setup System Preferences'


## ----------------------------------------
##  Clean setting files
## ----------------------------------------
echo 'start: Clean setting files'
[ -f ~/.zshrc ] && rm ~/.zshrc
[ -f ~/.zprofile ] && rm ~/.zprofile
[ -f ~/.bashrc ] && rm ~/.bashrc
[ -f ~/.bash_profile ] && rm ~/.bash_profile
[ -f ~/.vimrc ] && rm ~/.vimrc
[ -d ~/.vim ] && rm -r ~/.vim
echo 'complete: Clean setting files'


## ----------------------------------------
##  Homebrew
## ----------------------------------------
echo 'start: Install HomeBrew'
if [ ! -x "`which brew`" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
fi
echo 'complete: Install Homebrew'

# install app store app
# mas-cliのインストール
echo 'start: Install mas-cli'
if [ ! -x "`which mas`" ]; then
  brew install mas
fi
echo 'complete: Install mas-cli'

# 先にApple IDでiCloudやAppStoreにログインしておく必要あり。
echo 'start: Install App Store Applications by mas-cli'
mas install 539883307   # LINE
mas install 803453959   # Slack
mas install 417375580   # BetterSnapTool
mas install 967805235   # Paste
# mas install 1278508951  # Trello 
echo 'complete: Install App Store Applications by mas-cli'

# install gui app
# brew install caskroom/cask/brew-cask // 今は自動インストールされるので不要
# brew cask コマンドは2.6から非推奨になり、2.7から無効化。(brew install --cask ~ を使う)
casks=(
    dropbox
    discord 
    google-chrome
    slack
    deepl
    alfred
    iterm2
    visual-studio-code
    pycharm
    phpstorm
    docker
    dbeaver-community
)
echo "start: brew install gui apps"
for cask in "${casks[@]}"; do
    brew install --cask $cask
done
echo "complete: brew install gui apps"

# install formura
formulas=(
    go
    rust
    deno
    mysql
    sqlite
    zsh
    zsh-completions
    git
    nodebrew
    bat
    exa
    fzf
    ghq
    heroku
    heroku-node
    tig
    tmux 
    vim
    ranger
)
echo "start: brew install formulas"
for formula in "${formulas[@]}"; do
    brew install formula
done
echo "start: brew install formulas"


## ----------------------------------------
##  Git clone dotfiles
## ----------------------------------------
echo 'start: git clone dotfiles'
git clone https://github.com/kazuki827/dotfiles.git ~/dotfiles
echo 'complete: git clone dotfiles'


## ----------------------------------------
##  Deploy (set symbolic links)
## ----------------------------------------
echo 'start: setup Symbolic Links'
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tigrc ~/.tigrc
ln -sf ~/dotfiles/.dein ~/.dein
ln -sf ~/dotfiles/.ranger/rc.conf ~/.config/ranger
ln -sf ~/dotfiles/.ranger/rifile.conf ~/.config/ranger
ln -sf ~/dotfiles/.ranger/scope.sh ~/.config/ranger
# for f in .??*
# do
#     [[ "$f" == ".git" ]] && continue
#     [[ "$f" == ".DS_Store" ]] && continue

#     echo "$f"
# done
source ~/.zshrc
echo 'complete: setup Symbolic Links'