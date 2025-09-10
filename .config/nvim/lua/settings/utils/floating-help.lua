vim.api.nvim_create_user_command('Help', function(opts)
	vim.cmd('help ' .. opts.args)
	local buf = vim.api.nvim_get_current_buf()
	vim.cmd.close() -- Immediately close the split window

	local width = math.min(80, vim.o.columns - 4)
	local height = math.min(80, vim.o.lines - 6)

	vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		col = (vim.o.columns - width) / 2,
		row = (vim.o.lines - height) / 2,
		border = 'rounded',
		style = 'minimal'
	})
end, {
	nargs = 1,
	complete = 'help',
	desc = 'Open help in floating window'
})

vim.cmd('cnoreabbrev h Help')
vim.cmd('cnoreabbrev help Help')
