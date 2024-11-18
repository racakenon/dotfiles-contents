if status is-interactive
    # Commands to run in interactive sessions can go here
	starship init fish | source
	set -U LS_COLORS $(vivid generate $HOME/.config/vivid/mytilus_light.yml)
	
end
