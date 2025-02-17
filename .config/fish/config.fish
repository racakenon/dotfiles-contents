if status is-interactive
	# Commands to run in interactive sessions can go here
	if type -q starship
		starship init fish | source
	end
	if type -q vivid
		set -U LS_COLORS $(vivid generate $HOME/.config/vivid/mytilus_light.yml)
	end
	if type -q fnm
		fnm env --use-on-cd --shell fish | source
	end
	set -U fish_greeting
	fish_add_path $HOME/.cargo/bin/
	fish_add_path $HOME/.ghcup/bin/
	fish_add_path $HOME/.cabal/bin/
	fish_add_path $HOME/.local/bin/
	fish_add_path $HOME/.local/racket/bin
	fish_add_path $HOME/.local/ttfautohint/bin
	set -x MANPAGER "nvim +Man!"
	set -x EDITOR "nvim"
	set -x PAGER "nvim -R -c 'nnoremap q :lclose<CR>:q<CR>'"
end

if status is-login 
	if type -q nirii
		niri --session
	end
end
