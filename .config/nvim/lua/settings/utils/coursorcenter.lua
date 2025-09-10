local api, fn = vim.api, vim.fn

local DEBOUNCE_MS = 10
local GUARD_RATIO = 0.30

local timer ---@type uv_timer_t|nil

local function is_supported_buf(bufnr)
	local bt = vim.bo[bufnr].buftype
	return not (bt == "nofile" or bt == "terminal" or bt == "prompt" or bt == "quickfix")
end

local function should_center()
	local win = api.nvim_get_current_win()
	local h = api.nvim_win_get_height(win)
	if h <= 0 then return false end
	local wl = api.nvim_win_call(win, function() return fn.winline() end)
	if type(wl) ~= "number" then return false end

	local guard = math.floor(h * GUARD_RATIO)
	if guard < 1 then guard = 1 end
	local top_guard = guard
	local bottom_guard = h - guard

	return wl <= top_guard or wl >= bottom_guard
end

local function center_now()
	local mode = api.nvim_get_mode().mode
	if mode:match("^[isS]") then
		return
	end
	api.nvim_win_call(0, function()
		vim.cmd("normal! zz")
	end)
end

local function debounced_center()
	if timer and not timer:is_closing() then
		timer:stop()
		timer:close()
	end
	timer = vim.loop.new_timer()
	timer:start(DEBOUNCE_MS, 0, function()
		vim.schedule(function()
			if api.nvim_win_is_valid(0) and should_center() then
				center_now()
			end
		end)
		timer:stop()
		timer:close()
		timer = nil
	end)
end

local group = api.nvim_create_augroup("utils_cursor_center_smooth", { clear = true })

api.nvim_create_autocmd({ "CursorMoved" }, {
	group = group,
	pattern = "*",
	callback = function(opts)
		if not is_supported_buf(opts.buf) then return end
		if should_center() then
			debounced_center()
		end
	end,
})

api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
	group = group,
	pattern = "*",
	callback = function()
		center_now()
		if timer and not timer:is_closing() then
			timer:stop()
			timer:close()
			timer = nil
		end
	end,
})

api.nvim_create_autocmd({ "VimLeavePre" }, {
	group = group,
	callback = function()
		if timer and not timer:is_closing() then
			timer:stop()
			timer:close()
			timer = nil
		end
	end,
})
