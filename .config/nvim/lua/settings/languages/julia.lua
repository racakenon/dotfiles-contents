local root_files = {
	'Project.toml',
	'.git'
}

local cmd = {
	'julia',
	'--startup-file=no',
	'--history-file=no',
	'-e',
	[[
    using LanguageServer
    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
    project_path = let
        dirname(something(
            Base.load_path_expand((
                p = get(ENV, "JULIA_PROJECT", nothing);
                p === nothing ? nothing : isempty(p) ? nothing : p
            )),
            Base.current_project(),
            get(Base.load_path(), 1, nothing),
            Base.load_path_expand("@v#.#"),
        ))
    end
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    server.runlinter = true
    run(server)
  ]],
}

require 'settings.languages.lsp'.setup('julia', root_files, cmd, {})
