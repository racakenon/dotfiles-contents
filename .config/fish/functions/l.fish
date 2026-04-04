function l
	if type -q eza
		eza -lah $argv
	else
		command ls -lah $argv
	end
end
