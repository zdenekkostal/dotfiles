# Welcome to my dotfiles 

To install everything from scratch just open the `Terminal` app and run the following:

```bash
# Install brew - yeah, Macports would be nicer but it's missing a lot of packages I use :(
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Oh my ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh my ZSH's Powerlevel 10k theme has a separate repository
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

brew install asdf git tmux fzf direnv diff-so-fancy docker ripgrep gnupg
brew cask install alacritty 
brew install --HEAD neovim # when 0.5.0 is oficially released this can be moved to the first line
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

This is a bare repository, which has no work tree:

```bash
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:zdenekkostal/dotfiles.git $HOME/.dotfiles-tmp
rm -r $HOME/.dotfiles-tmp
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

# Beware if your home folder is not empty and you don't won't to override everything
dotfiles restore .
```

Interact with the repository with the `dotfiles` command (specified in `.zshrc`) – use it like any other git repo (`dotfiles status`, `dotfiles add ...`, etc.).

Also, don't forget to download excellent [Fira Code](https://github.com/tonsky/FiraCode).

List of applications I use:
- 1Password
- Notion
- Choosy (open links in the right browser)
- Keka
- Dash
- Karabiner
- Muzzle
- PixelSnap 2
- CleanShot X
- ProtonVPN
- Spotify
- LayAuto
- TripMode
- Dictionaries (dictionaries.io)
- BeardedSpice
- Trailer app
