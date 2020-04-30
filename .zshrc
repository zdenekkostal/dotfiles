# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh my ZSH stuff
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  asdf
  docker
  fzf
  gcloud
  gitfast
  mix
  ssh-agent
  tmux
)

source $ZSH/oh-my-zsh.sh

####################################################

# Enable direnv - sets shell variables per directory
eval "$(direnv hook zsh)"

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env

# Reload .profile stuff which would be loaded otherwise just after logging in
[ -f ~/.profile ] && source ~/.profile

####################################################
# Functions

function tmux-colors {
  for i in {0..255}; do
      printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
}

function test-colors {
  awk 'BEGIN{
      s="/\\/\\/\\/\\/\\"; s=s s s s s s s s s s s s s s s s s s s s s s s;
      for (colnum = 0; colnum<256; colnum++) {
          r = 255-(colnum*255/255);
          g = (colnum*510/255);
          b = (colnum*255/255);
          if (g>255) g = 510-g;
          printf "\033[48;2;%d;%d;%dm", r,g,b;
          printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
          printf "%s\033[0m", substr(s,colnum+1,1);
      }
      printf "\n";
  }'
}

function terminal-scheme {
  sed -i '' -e "s#^colors:.*#colors: \*$1#g" ~/.config/alacritty/alacritty.yml
  sed -i '' -e "s#^set background=.*#set background=$1#g" ~/dotfiles/config/nvim/init.vim
}

function to-gif {
  file_name="${1##*/}"
  output_file_name="${file_name%%.*}.gif"
  ffmpeg -i $1 -pix_fmt rgb8 -r 10 $output_file_name && gifsicle -O3 $output_file_name -o $output_file_name
}

alias light="terminal-scheme light"
alias dark="terminal-scheme dark"

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias apply-patch="pbpaste | sed -e '$a' | git apply"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

