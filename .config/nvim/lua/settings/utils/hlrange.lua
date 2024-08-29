local number_range = "^(%d+)"
local mark_range = "^('[%l><])"
local forward_search_range = "^(/.*/)"
local backward_search_range = "^(?.*?)"
local special_range = "^([%%%.$])"

local command_pattern = "^(%l+)"
local range_patterns = {
	special_range, number_range, mark_range, forward_search_range,
	backward_search_range
}
local range_patterns_type = {
	"special", "number", "mark", "forward_search", "backward_search"
}

local function get_range(index, cmd)
	local range, type
	for i = 1, #range_patterns do
		local _, end_index, result = string.find(cmd, range_patterns[i], index)
		if end_index then
			index = end_index + 1
			range = result
			type = range_patterns_type[i]
			break
		end
	end
	if type == "special" then type = range end
	return range, type, index
end

local function update_increment(operator, increment, acc_text, acc_num)
	local inc_str = acc_text .. operator .. increment
	if increment == "" then increment = 1 end
	return inc_str, acc_num + tonumber(operator .. increment)
end

local function get_increment(index, cmd)
	local pattern, inc_text, total, done = "([+-])(%d*)", "", 0, false
	while not done do
		local _, end_index, operator, increment =
			string.find(cmd, pattern, index)
		if not end_index then
			done = true
			break
		end
		inc_text, total = update_increment(operator, increment, inc_text, total)
		index = end_index + 1
	end

	return inc_text, total, index
end

local function parse_cmd(cmd)
	local result, next_index, comma_index, _ = {}, 1, nil, nil
	local start_range_text

	result.start_range, result.start_range_type, next_index = get_range(1, cmd)

	comma_index, _, result.separator = string.find(cmd, '[(;,)]', next_index)

	if comma_index then
		if not result.start_range then
			result.start_range = "."
			result.start_range_type = "."
		end
		start_range_text = string.sub(cmd, 1, comma_index)
	else
		start_range_text = cmd
	end
	result.start_increment, result.start_increment_number, next_index =
		get_increment(next_index, start_range_text)
	if comma_index then
		next_index = next_index + 1
		result.end_range, result.end_range_type, next_index =
			get_range(next_index, cmd)
		if not result.end_range then
			result.end_range = "."
			result.end_range_type = "."
		end
		result.end_increment, result.end_increment_number, next_index =
			get_increment(next_index, cmd)
	end

	_, _, result.command = string.find(cmd, command_pattern, next_index)

	return result
end

local function mark_to_number(start_mark)
	return vim.api.nvim_buf_get_mark(0, string.sub(start_mark, 2, -1))[1]
end

local function search_to_number(config)
	return function(pattern)
		local pattern_text, search_options = string.sub(pattern, 2, -2), "n"
		if not config.forward then search_options = "bn" end
		local line_number = vim.api.nvim_call_function("searchpos", {
			pattern_text, search_options
		})[1]
		return line_number
	end
end

local forward_search_to_number = search_to_number { forward = true }
local backward_search_to_number = search_to_number { forward = false }

local v = vim.api
local ns = v.nvim_create_namespace("range-highlight")
local cache = {}

local function cleanup()
	v.nvim_buf_clear_namespace(0, ns, 0, -1)
	cache = {}
end

local range_handlers = {
	number = tonumber,
	mark = mark_to_number,
	forward_search = forward_search_to_number,
	backward_search = backward_search_to_number,
}

local function get_range_number(cmd)
	local start_line, end_line = 0, 0
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local line_count = vim.api.nvim_buf_line_count(0)
	local result = parse_cmd(cmd)

	if not result.start_range then
		v.nvim_buf_clear_namespace(0, ns, 0, -1)
		vim.cmd("redraw")
		return -1, -1
	end

	if result.start_range == "%" or result.end_range == "%" then
		return 0, line_count
	end

	if result.start_range then
		if result.start_range == "$" then
			start_line = line_count
		elseif result.start_range == "." then
			start_line = current_line
		else
			start_line = range_handlers[result.start_range_type](result.start_range)
		end
	else
		start_line = current_line
	end

	if result.start_increment then
		start_line = start_line + result.start_increment_number
	end

	if result.end_range then
		if result.end_range == "$" then
			end_line = line_count
		elseif result.end_range == "." then
			end_line = current_line
		else
			end_line = range_handlers[result.end_range_type](result.end_range)
		end
	else
		end_line = start_line
	end

	if result.end_increment then
		end_line = end_line + result.end_increment_number
	end

	start_line = start_line - 1

	return start_line, end_line
end

local function add_highlight()
	if vim.fn.getcmdtype() ~= ":" then
		return
	end

	local text = vim.fn.getcmdline()
	local start_line, end_line = get_range_number(text)

	if start_line < 0 or end_line < 0 then
		return
	end

	if end_line < start_line then
		start_line, end_line = end_line, start_line
		start_line = start_line - 1
		end_line = end_line + 1
	end

	if cache[1] == start_line and cache[2] == end_line then
		return
	end

	if cache[1] and cache[2] then
		if cache[1] ~= start_line or cache[2] ~= end_line then
			v.nvim_buf_clear_namespace(0, ns, cache[1], cache[2])
		end
	end

	cache[1], cache[2] = start_line, end_line

	vim.highlight.range(0, ns, "Visual", { start_line, 0 }, { end_line, 0 })
	vim.api.nvim__redraw({ flush = true })
end

vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
	callback = function()
		cleanup()
	end
})

vim.api.nvim_create_autocmd({ "CmdlineChanged" }, {
	callback = function()
		add_highlight()
	end
})
