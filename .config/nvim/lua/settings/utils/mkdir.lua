local api, fn, fs = vim.api, vim.fn, vim.fs

local group = api.nvim_create_augroup("utils_mkdir_on_save", { clear = true })

api.nvim_create_autocmd({ "bufwrite" }, {
	group = group,
	pattern = "*",
	callback = function(opts)
		local bt = vim.bo[opts.buf].buftype
		if bt == "nofile" or bt == "terminal" or bt == "prompt" or bt == "quickfix" then
			return
		end

		local dir
		if opts and opts.file and opts.file ~= "" then
			dir = fs and fs.dirname and fs.dirname(opts.file) or fn.fnamemodify(opts.file, ":p:h")
		else
			dir = fn.expand("<afile>:p:h")
		end

		if not dir or dir == "" then
			return
		end

		if string.find(dir, "://", 1, true) then
			return
		end

		if fn.isdirectory(dir) == 0 then
			fn.mkdir(dir, "p")
		end
	end,
})
