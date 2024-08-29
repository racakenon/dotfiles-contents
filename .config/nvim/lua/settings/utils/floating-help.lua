local Options      = {}

Options.args       = {
	border = 'rounded',
	ratio = 0.8,
}

Options.vars       = {
	group_name = 'FloatingHelpPlugin'
}

Options.float_opts = {
	width = 78,
	height = 0,
	window_opts = {
		border = Options.args.border,
		style = 'minimal',
		anchor = 'NW',
		relative = 'editor',
		offset_x = 0,
		offset_y = 0,
		zindex = 49,
		external = false,
		focusable = true,
		noautocmd = true,
	},
}

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
	callback = function(args)
		local buf = args.buf
		if buf ~= nil and vim.bo[buf].filetype == 'help' then
			local current_help_win = vim.api.nvim_get_current_win()
			local help_win =
				(function(buf, options)
					local opts = options.float_opts
					local window_height = (vim.opt.lines:get() - vim.opt.cmdheight:get()) * options.args.ratio

					opts.height = math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * options.args.ratio)
					opts.window_opts.offset_y = ((vim.opt.lines:get() - window_height) / 2) - vim.opt.cmdheight:get()
					opts.window_opts.offset_x = (vim.opt.columns:get() - opts.width) / 2
					local float_opts = vim.lsp.util.make_floating_popup_options(
						opts.width, opts.height, opts.window_opts)

					local new_win = vim.api.nvim_open_win(buf, true, float_opts)

					vim.api.nvim_win_set_height(new_win, opts.height)

					return new_win
				end)(buf, Options)
			vim.wo[help_win].scroll = vim.wo[current_help_win].scroll

			vim.api.nvim_win_close(current_help_win, false)
		end
	end
})
