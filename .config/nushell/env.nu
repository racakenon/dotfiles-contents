$env.PROMPT_COMMAND = ""
$env.PROMPT_COMMAND_RIGHT = ""

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') 
    ($nu.data-dir | path join 'completions') 
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') 
]

$env.PATH = (
	$env.PATH 
	| split row (char esep) 
	| append ($env.HOME | path join .cabal bin)
	| append ($env.HOME | path join .cargo bin)
	| append ($env.HOME | path join .ghcup bin)
	| append ($env.HOME | path join .juliaup bin)
	| append ($env.HOME | path join .local bin)
	| append ($env.HOME | path join .local chez bin)
	| append ($env.HOME | path join .local chicken bin)
	| append ($env.HOME | path join .local clojure bin)
	| append ($env.HOME | path join .local cmake bin)
	| append ($env.HOME | path join .local dotnet bin)
	| append ($env.HOME | path join .local elixir bin)
	| append ($env.HOME | path join .local erlang bin)
	| append ($env.HOME | path join .local go bin)
	| append ($env.HOME | path join .local idris2 bin)
	| append ($env.HOME | path join .local jdk bin)
	| append ($env.HOME | path join .local julia bin)
	| append ($env.HOME | path join .local maven bin)
	| append ($env.HOME | path join .local opam bin)
	| append ($env.HOME | path join .local python bin)
	| append ($env.HOME | path join .local racket bin)
	| append ($env.HOME | path join .local ruby bin)
	| append ($env.HOME | path join .local share coursier bin)
	| append ($env.HOME | path join .local node lts bin)
)
$env.GOPATH = $env.HOME | path join .local go go
$env.DOTNET_ROOT = $env.HOME | path join .local share dotnet
$env.LS_COLORS = (vivid generate gruvbox-light-soft)
$env.VIRTUAL_ENV_DISABLE_PROMPT = true

mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

$env.STARSHIP_SHELL = "nu"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
