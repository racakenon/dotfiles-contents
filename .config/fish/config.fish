if status is-interactive
    # Commands to run in interactive sessions can go here
	starship init fish | source
	set -U LS_COLORS $(vivid generate $HOME/.config/vivid/mytilus_light.yml)
	set -U fish_greeting
	fish_add_path $HOME/.cargo/bin/
	fish_add_path $HOME/.ghcup/bin/
	fish_add_path $HOME/.cabal/bin/
	fish_add_path $HOME/.local/bin/
	fish_add_path $HOME/.local/fish/bin/
	fish_add_path $HOME/.local/chez/bin/
	fish_add_path $HOME/.local/chicken/bin/
	fish_add_path $HOME/.local/clojure/bin/
	fish_add_path $HOME/.local/cmake/bin/
	fish_add_path $HOME/.local/dotnet/bin/
	fish_add_path $HOME/.local/erlang/bin/
	fish_add_path $HOME/.local/elixir/bin/
	fish_add_path $HOME/.local/go/bin/
	fish_add_path $HOME/.local/idiris2/bin/
	fish_add_path $HOME/.local/jdk/bin/
	fish_add_path $HOME/.local/julia/bin/
	fish_add_path $HOME/.local/maven/bin/
	fish_add_path $HOME/.local/lua-language-server/bin/
	fish_add_path $HOME/.local/opam/bin/
	fish_add_path $HOME/.local/python/bin/
	fish_add_path $HOME/.local/ruby/bin/
	fish_add_path $HOME/.local/racket/bin/
	fish_add_path $HOME/.local/share/coursier/bin/
	fish_add_path $HOME/.local/node/bin/
	fish_add_path $HOME/.local/wezterm/target/release
	fish_add_path $HOME/.local/eww/target/release
	fish_add_path $HOME/.local/rio/target/release
	fish_add_path $HOME/.local/swww/target/release
	fish_add_path $HOME/.local/niri/target/release
	set -x GOPATH $HOME/.local/go/go
	set -x DOTNET_ROOT $HOME/.local/share/dotnet
	set -x MANPAGER "nvim +Man!"
end

if status is-login 
	dbus-run-session niri -- --session&
end
