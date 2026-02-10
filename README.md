# Welcome to my dotfiles

## macOS

Open the `Terminal` app and run:

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/zdenekkostal/dotfiles/master/bin/install-dotfiles)"
```

## Linux (Ubuntu)

First install prerequisites:

```bash
sudo apt-get update && sudo apt-get install -y git zsh curl
```

Then run the installer:

```bash
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/zdenekkostal/dotfiles/master/bin/install-dotfiles)"
```

## Usage

This is a bare repository, which has no work tree. Interact with the repository with the `dotfiles` command (specified in `.zshrc`) – use it like any other git repo (`dotfiles status`, `dotfiles add ...`, etc.).
