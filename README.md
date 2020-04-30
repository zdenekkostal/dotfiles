# Welcome to my dotfiles 

This is a bare repository, which needs to be cloned this way (it has no work tree).

```bash
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:zdenekkostal/dotfiles.git $HOME/.dotfiles-tmp
rm -r $HOME/.dotfiles-tmp
dotfiles config status.showUntrackedFiles no
```

Interact with the repository with the `dotfiles` command (specified in `.zshrc`) – use it like any other git repo (`dotfiles status`, `dotfiles add ...`, etc.).
