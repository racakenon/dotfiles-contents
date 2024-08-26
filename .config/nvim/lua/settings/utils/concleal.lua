local fn = vim.fn
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave", }, {
	pattern = "*",
	callback = function()
		vim.opt.concealcursor = "n"
		vim.opt.conceallevel = 3
		vim.api.nvim__redraw({ valid = true })
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.conceallevel = 0
		vim.api.nvim__redraw({ valid = true })
	end,
})
