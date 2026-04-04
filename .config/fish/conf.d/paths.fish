if status is-interactive
	fish_add_path $HOME/.cargo/bin/
	fish_add_path $HOME/.yarn/bin/
	fish_add_path $HOME/.ghcup/bin/
	fish_add_path $HOME/.cabal/bin/
	fish_add_path $HOME/.local/bin/
	for dir in $HOME/.local/*/bin
		if test -d "$dir"; and not string match -q "*conda*" "$dir"
			fish_add_path "$dir"
		end
	end

	# pnpm
	set -gx PNPM_HOME "$HOME/.local/share/pnpm"
	if not string match -q -- $PNPM_HOME $PATH
		set -gx PATH "$PNPM_HOME" $PATH
	end

	# Android / NDK
	if test -d "$HOME/.assdk"
		set -gx ANDROID_HOME "$HOME/.assdk"
		if test -d "$ANDROID_HOME/ndk"
			set -gx NDK_HOME "$ANDROID_HOME/ndk/"(ls -1 "$ANDROID_HOME/ndk" | head -1)
		end
	end

	# Java (Android Studio bundled JBR)
	if test -d "$HOME/.local/android-studio/jbr"
		set -gx JAVA_HOME "$HOME/.local/android-studio/jbr"
	end

	# conda
	if test -f "$HOME/.local/miniconda3/bin/conda"
		eval $HOME/.local/miniconda3/bin/conda "shell.fish" "hook" | source
	end
end
