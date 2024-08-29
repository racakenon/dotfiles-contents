vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.pl" },
	callback = function()
		vim.api.nvim_create_user_command("SetProlog", 'lua vim.api.nvim_set_option_value("filetype", "prolog", {})', {})
	end
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = { "*.pl" },
	callback = function()
		vim.api.nvim_del_user_command("SetProlog")
	end
})
