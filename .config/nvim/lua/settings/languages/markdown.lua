local root_files = {}
local cmd = { 'marksman', 'server' }
require 'settings.languages.lsp'.setup('markdown', 'marksman', root_files, cmd, {})
