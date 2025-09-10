local inverses = {
	{ "true", "false" },
	{ "#f",   "#t" },
	{ "on",   "off" },
	{ "yes",  "no" },
	{ "up",   "down" },
	{ "left", "center", "right" },
	{ "top",  "bottom" },
	{ "!=",   "==",     "/=" },
}

local function find_token_under_cursor(line, col1_based, inverse_table)
	if type(line) ~= "string" or type(col1_based) ~= "number" then
		return nil
	end
	local best = nil
	for _, group in ipairs(inverse_table or {}) do
		for _, tok in ipairs(group) do
			local from = 1
			while true do
				local s, e = string.find(line, tok, from, true) -- plain find
				if not s then break end
				if s <= col1_based and col1_based <= e then
					return { token = tok, s = s, e = e }
				end
				from = e + 1
			end
		end
	end
	return best
end

local function replace_span(line, s, e, new_text)
	return string.sub(line, 1, s - 1) .. new_text .. string.sub(line, e + 1)
end

local function inverse_word()
	local _, col0 = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local col = col0 + 1

	local match = find_token_under_cursor(line, col, inverses)
	if not match then
		return
	end

	local next_text = nil
	for _, group in ipairs(inverses) do
		for i, tok in ipairs(group) do
			if tok == match.token then
				local j = (i % #group) + 1
				next_text = group[j]
				break
			end
		end
		if next_text then break end
	end

	if not next_text then
		return
	end

	local new_line = replace_span(line, match.s, match.e, next_text)
	vim.api.nvim_set_current_line(new_line)
end

vim.keymap.set({ "n", "v" }, "<M-t>", function()
	inverse_word()
end)
