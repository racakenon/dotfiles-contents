function vi --wraps=vim --wraps=nvim --description 'alias vi=nvim'
	nvim $argv
	complete -c vi -w nvim
end
