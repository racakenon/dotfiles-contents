if status is-interactive
	set fish_greeting ""
	if type -q starship
		starship init fish | source
	end
	if type -q vivid
		if test -f "$HOME/.config/vivid/mytilus_light.yml"
			set -x LS_COLORS (vivid generate "$HOME/.config/vivid/mytilus_light.yml")
		end
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

	set -x MANPAGER "nvim +Man!"
	set -x EDITOR "nvim"
	set -x PAGER "nvim -R -"
	set -x XMODIFIERS @im=kime
	set -gx QT_QPA_PLATFORM xcb
end

if status is-login
	if type -q gnome-keyring-daemon
		gnome-keyring-daemon --start --components=secrets
	end
	if type -q niri
		niri --session
	end
end

# BEGIN opam configuration
test -r '/home/raca/.opam/opam-init/init.fish' && source '/home/raca/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
