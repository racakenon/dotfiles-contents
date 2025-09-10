function la 
	if type -q eza
		eza -lAh $argv
	else
		command ls -lAh $argv
	end
end
