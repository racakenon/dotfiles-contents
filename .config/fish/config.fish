if status is-interactive
    # Commands to run in interactive sessions can go here
	starship init fish | source
	set -U LS_COLORS $(vivid generate $HOME/.config/vivid/mytilus_light.yml)
	set -U fish_greeting
	fish_add_path $HOME/.cargo/bin/
	fish_add_path $HOME/.ghcup/bin/
	fish_add_path $HOME/.cabal/bin/
	fish_add_path $HOME/.local/bin/
	set -x MANPAGER "nvim +Man!"
	set -x EDITOR "nvim"
	set -x PAGER "nvim -R -c 'nnoremap q :lclose<CR>:q<CR>'"
end

if status is-login 
	dbus-run-session niri -- --session&
end
