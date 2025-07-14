vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local opts = { buf = ev.buf }
		vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", opts)
		vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", opts)
		vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", opts)
		opts = { buffer = ev.buf }
		vim.keymap.set('n', '<space>d', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<space>n', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>h', function()
			vim.lsp.buf.hover({ border = "rounded", focus = true, max_width = 80 })
		end, opts)
		vim.keymap.set('n', '<space>r', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<space>r', vim.lsp.buf.references, opts)
		vim.keymap.set({ 'n', 'i' }, '<space>s', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>w', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

vim.keymap.del('n', ']d')
vim.keymap.del('n', '[d')

vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gO')
vim.keymap.del('i', '<C-S>')
vim.keymap.set('n', ']d', function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Jump to the next diagnostic' })

vim.keymap.set('n', '[d', function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Jump to the previous diagnostic' })

vim.api.nvim_create_user_command('LspLog',
	function()
		vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path()))
	end,
	{
		desc = 'Opens the Nvim LSP client log.',
	}
)

vim.diagnostic.config({
	virtual_text = true,
	float = {
		border = "rounded"
	},
})

local M = {}

function M.setup(name, settings)
	vim.lsp.config[name] = vim.tbl_deep_extend('keep', {
		capabilities = vim.tbl_deep_extend('keep', vim.lsp.protocol.make_client_capabilities(),
			require('cmp_nvim_lsp').default_capabilities()),
	}, settings)
	vim.lsp.enable(name)
end

return M
