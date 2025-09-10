function tree 
	if type -q eza
		eza --tree --git-ignore $argv
		complete -c tree -w eza
	else if type -q tree
		tree -I '.git' $argv
	else
		echo "Neither eza nor tree is installed"
		return 1
	end
end
