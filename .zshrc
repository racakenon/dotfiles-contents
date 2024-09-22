if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy/mm/dd"

plugins=(git poetry extract copyfile copypath fzf encode64  stack cabal zsh-interactive-cd zsh-syntax-highlighting zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias cmh="chezmoi cd"
alias cma="chezmoi add"
alias rm="rm -rf"
alias cp="cp -r"
alias gc="git clone --depth 1"
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

swap ()
{
    local TMPFILE=tmp.$$
   sudo mv "$1" $TMPFILE
   sudo mv "$2" "$1"
   sudo mv $TMPFILE "$2"
}

