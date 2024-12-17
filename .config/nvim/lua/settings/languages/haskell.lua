local root_files = {
	'.git',
	'hie.yaml',
	'stack.yaml',
	'cabal.project',
	'*.cabal',
	'package.yaml'
}
local cmd = { 'haskell-language-server-wrapper', '--lsp' }

require 'settings.languages.lsp'.setup('haskell', 'hls' , root_files, cmd, {
	haskell = {

        formattingProvider = 'ormolu',
        cabalFormattingProvider = 'cabalfmt',
      }
})
