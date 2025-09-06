if status is-interactive
	# Commands to run in interactive sessions can go here
	if type -q starship
		starship init fish | source
	end
	if type -q vivid
		set -x LS_COLORS $(vivid generate $HOME/.config/vivid/mytilus_light.yml)
	end
	if type -q fnm
		fnm env --use-on-cd --shell fish | source
	end
	if type -q zoxide
		zoxide init fish --cmd cd | source
	end
	if type -q sccache
		set -x CC "sc-gcc"
		set -x CXX "sc-g++"
	end
	set -U fish_greeting
	fish_add_path $HOME/.cargo/bin/
	fish_add_path $HOME/.yarn/bin/
	fish_add_path $HOME/.ghcup/bin/
	fish_add_path $HOME/.cabal/bin/
	fish_add_path $HOME/.local/bin/
	fish_add_path $HOME/.local/racket/bin
	fish_add_path $HOME/.local/ttfautohint/bin
	set -x MANPAGER "nvim +Man!"
	set -x EDITOR "nvim"
	set -x PAGER "nvim -R -" 
	set -x XMODIFIERS @im=kime

	# pnpm
	set -gx PNPM_HOME "/home/raca/.local/share/pnpm"
	if not string match -q -- $PNPM_HOME $PATH
		set -gx PATH "$PNPM_HOME" $PATH
	end
	# pnpm end
end

if status is-login 
	if type -q niri
		niri --session
	end
end

