local root_files = {
	'.git'
}
local cmd = { 'racket', '-l','racket-langserver' }

require 'settings.languages.lsp'.setup('racket', 'racket-langserver' , root_files, cmd, {})
