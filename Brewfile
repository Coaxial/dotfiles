# Usage `brew bundle Brewfile`

# Make sure everything is up to date
update

# Upgrade anything already installed
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install bash
install bash-completion

# Add extra repos
tap homebrew/dupes
tap homebrew/versions
tap telemachus/homebrew-desc

# Install the essentials
install git
install hub
install tree
install wget --enable-iri
install vim
install macvim --with-override-system-vim
install ssh-copy-id
install mobile-shell
install nvm 
install openssl
install wget
install tree
install android-platform-tools
install tmux
install mackup
install webkit2png

# Install cask
tap caskroom/cask
tap caskroom/versions
install brew-cask

# And my favourite apps
cask install airmail-beta
cask install alfred
cask install dockertoolbox
cask install caffeine
cask install flux
cask install gfxcardstatus
cask install google-chrome
cask install iterm2
cask install jumpcut
cask install lastpass
cask install limechat
cask install postbox
cask install sublime-text3
cask install telegram
cask install vlc
cask install copy
cask install keka
cask install menumeters
cask install spotify
cask install xquartz
cask install vagrant
cask install virtualbox
cask install mac2imgur
cask install spectacle
cask install imageoptim
cask install google-drive

# Add casks to Alfred
cask alfred link

# Create symlinks in ~/Applications
linkapps

# Remove outdated versions
cask cleanup
cleanup
