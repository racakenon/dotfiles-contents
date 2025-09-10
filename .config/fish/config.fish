if status is-interactive
	# Commands to run in interactive sessions can go here
	set fish_greeting ""
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

	### ANSI 16 Colors Base Palette ###
	set -U fish_color_foreground '403E47'
	set -U fish_color_background 'E8E9DE'
	set -U fish_color_ansi_black '403E47'
	set -U fish_color_ansi_red '5A3336'
	set -U fish_color_ansi_green '0F4B39'
	set -U fish_color_ansi_yellow '4C3F03'
	set -U fish_color_ansi_blue '334059'
	set -U fish_color_ansi_magenta '4B374E'
	set -U fish_color_ansi_cyan '124850'
	set -U fish_color_ansi_white 'E8E9DE'
	set -U fish_color_ansi_brblack '504E57'
	set -U fish_color_ansi_brred 'FECCCF'
	set -U fish_color_ansi_brgreen 'B0EAD2'
	set -U fish_color_ansi_bryellow 'EADBA3'
	set -U fish_color_ansi_brblue 'CBDBFA'
	set -U fish_color_ansi_brmagneta 'EAD1ED'
	set -U fish_color_ansi_brcyan 'B0E5F0'
	set -U fish_color_ansi_brwhite 'F5F6EB'

	### Fish UI Colors ###
	set -U fish_color_normal '403E47'
	set -U fish_color_command '334059'
	set -U fish_color_keyword '4B374E'
	set -U fish_color_quote '0F4B39'
	set -U fish_color_redirection '4C3F03'
	set -U fish_color_end '124850'
	set -U fish_color_error '5A3336'
	set -U fish_color_param '403E47'
	set -U fish_color_option '5F4E09'
	set -U fish_color_comment '504E57'
	set -U fish_color_selection --background='504E57'
	set -U fish_color_operator '124850'
	set -U fish_color_escape 'EADBA3'
	set -U fish_color_autosuggestion '504E57'
	set -U fish_color_cwd '0F4B39'
	set -U fish_color_cwd_root '5A3336'
	set -U fish_color_user '4B374E'
	set -U fish_color_host '4B374E'
	set -U fish_color_host_remote 'EAD1ED'
	set -U fish_color_status '5A3336'
	set -U fish_color_cancel '5A3336'
	set -U fish_color_search_match --background='5F4E09'
	set -U fish_color_history_current '403E47'

	### Pager Colors ###
	set -U fish_pager_color_progress '403E47'
	set -U fish_pager_color_background 'E8E9DE'
	set -U fish_pager_color_prefix '334059'
	set -U fish_pager_color_completion '403E47'
	set -U fish_pager_color_description '504E57'
	set -U fish_pager_color_selected_background --background='504E57'
	set -U fish_pager_color_selected_prefix 'CBDBFA'
	set -U fish_pager_color_selected_completion 'E8E9DE'
	set -U fish_pager_color_selected_description 'CECFC4'
	set -U fish_pager_color_secondary_background 'CECFC4'
	set -U fish_pager_color_secondary_prefix '404F6F'
	set -U fish_pager_color_secondary_completion '504E57'
	set -U fish_pager_color_secondary_description '504E57'

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

