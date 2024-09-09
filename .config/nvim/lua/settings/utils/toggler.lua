local inverses = {
	{ "true", "false" },
	{ "#f",   "#t" },
	{ "on",   "off" },
	{ "yes",  "no" },
	{ "up",   "down" },
	{ "left", "center", "right" },
	{ "top", "bottom" },
	{ "!=",   "==",   "/=" },
}

local function replace_word_at_cursor(new_word)
	local current_word = vim.fn.expand("<cWORD>")
	local line = vim.api.nvim_get_current_line()
	local _, col = unpack(vim.api.nvim_win_get_cursor(0))
	local word_range = vim.fn.matchstrpos(line,  current_word , col - #current_word)
	local new_line = line:sub(1, word_range[2]) .. new_word .. line:sub(word_range[3] + 1)
	vim.api.nvim_set_current_line(new_line)
end

local function inverse_word()
	local current_word = vim.fn.expand("<cWORD>")
	for _, group in ipairs(inverses) do
		for i, word in ipairs(group) do
			if word == current_word then
				replace_word_at_cursor(i == #group and group[1] or group[i + 1])
			end
		end
	end
end

vim.keymap.set({ "n", "v" }, "<M-t>", function()
	inverse_word()
end)
