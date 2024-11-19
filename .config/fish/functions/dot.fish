function dot --wraps='git --git-dir ~/.dotfiles --work-tree -' --wraps='git --git-dir ~/.dotfiles --work-tree ~' --description 'alias dot=git --git-dir ~/.dotfiles --work-tree ~'
  git --git-dir ~/.dotfiles --work-tree ~ $argv
        
end
