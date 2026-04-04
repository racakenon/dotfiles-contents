function tree
	if type -q eza
		eza --tree --git-ignore $argv
	else if type -q tree
		tree -I '.git' $argv
	else
		echo "Neither eza nor tree is installed"
		return 1
	end
end
