local api, fn = vim.api, vim.fn


local IGNORE_BUFTYPE = {
	nofile = true,
	terminal = true,
	prompt = true,
	quickfix = true,
}

local OPEN_FOLDS = true

local function is_supported_buf(buf)
	local bt = api.nvim_get_option_value("buftype", { buf = buf })
	return not IGNORE_BUFTYPE[bt]
end


local function jump_to_last_position(buf)
	local pos = api.nvim_buf_get_mark(buf, '"')
	local row = pos and pos[1] or 0
	if row <= 0 or row > api.nvim_buf_line_count(buf) then
		return
	end

	vim.cmd([[silent! keepjumps normal! g`"]])

	if OPEN_FOLDS then
		vim.cmd([[silent! normal! zv]])
	end
end


local group = api.nvim_create_augroup("utils_lastline_restore_once", { clear = true })

api.nvim_create_autocmd("BufWinEnter", {
	group = group,
	pattern = "*",
	callback = function(opts)
		if not is_supported_buf(opts.buf) then
			return
		end

		if vim.b[opts.buf].__lastline_done then
			return
		end
		vim.b[opts.buf].__lastline_done = true


		vim.schedule(function()
			if api.nvim_buf_is_loaded(opts.buf) then
				jump_to_last_position(opts.buf)
			end
		end)
	end,
})
