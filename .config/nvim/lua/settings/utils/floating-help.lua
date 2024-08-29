vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
	callback = function(args)
		local buf = args.buf
		if buf ~= nil and vim.bo[buf].filetype == 'help' then
			local current_help_win = vim.api.nvim_get_current_win()
			local opts = {
				width = 78,
				height = vim.opt.lines:get() - 6,
				window_opts = {
					border = 'rounded',
					style = 'minimal',
					anchor = 'NW',
					relative = 'editor',
					offset_x = (vim.opt.columns:get() - 78) / 2,
					offset_y = 0,
					zindex = 49,
					external = false,
					focusable = true,
					noautocmd = true,
				}
			}
			local float_opts = vim.lsp.util.make_floating_popup_options(opts.width, opts.height, opts.window_opts)

			local help_win = vim.api.nvim_open_win(buf, true, float_opts)

			vim.api.nvim_win_set_height(help_win, opts.height)

			vim.wo[help_win].scroll = vim.wo[current_help_win].scroll

			vim.api.nvim_win_close(current_help_win, false)
		end
	end
})
