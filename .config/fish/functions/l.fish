function l
	if type -q eza
		eza -lah $argv
	else
		command l -lah $argv
	end
end
