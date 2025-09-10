function vim --wraps=nvim --description 'alias vim=nvim'
	nvim $argv
	complete -c vim -w nvim        
end
