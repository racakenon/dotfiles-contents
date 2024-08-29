local p = require "gruvbox".palette
local icon = require("nvim-web-devicons")

local function mode()
	local modes = {
		["n"] = { "n", "%#MiniStatuslineModeNormal#" },
		["v"] = { "v", "%#MiniStatuslineModeVisual#" },
		["V"] = { "V", "%#MiniStatuslineModeVisual#" },
		["s"] = { "s", "%#MiniStatuslineModeOther#" },
		["S"] = { "S", "%#MiniStatuslineModeOther#" },
		["i"] = { "i", "%#MiniStatuslineModeInsert#" },
		["R"] = { "R", "%#MiniStatuslineModeOther#" },
		["c"] = { "c", "%#MiniStatuslineModeCommand#" },
		["r"] = { "r", "%#MiniStatuslineModeOther#" },
		["!"] = { "!", "%#MiniStatuslineModeCommand#" },
		["t"] = { "t", "%#MiniStatuslineModeOther#" },
	}
	local currnet_mode = modes[vim.fn.mode(0)]
	return currnet_mode[2] .. " " .. currnet_mode[1] .. " "
end

local function lsp()
	local lspname = {}
	local bufnr = vim.api.nvim_get_current_buf()
	local client = vim.lsp.get_clients({ bufnr = bufnr })
	if client[1] ~= nil then
		for _, server in pairs(client) do
			table.insert(lspname, server.name)
		end
		return table.concat(lspname, " ") .. " "
	end
	return ""
end

local function diagnostic()
	local bufnr = vim.api.nvim_get_current_buf()
	local errors = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
	vim.api.nvim_set_hl(0, "Error", { fg = p.faded_red, bg = p.light2, bold = true, })
	vim.api.nvim_set_hl(0, "Warning", { fg = p.faded_yellow, bg = p.light2, bold = true, })
	vim.api.nvim_set_hl(0, "Info", { fg = p.faded_blue, bg = p.light2, bold = true, })
	vim.api.nvim_set_hl(0, "Hint", { fg = p.faded_aqua, bg = p.light2, bold = true, })
	return "%#Error#" .. errors .. "%#Warning#" .. warnings .. "%#Hint#" .. hints .. "%#Info#" .. info
end

local function filetype()
	local ftype = vim.bo.filetype
	local symbol, symbol_color = icon.get_icon_color_by_filetype(ftype, { default = true })
	vim.api.nvim_set_hl(0, "symbol_color", { fg = symbol_color, bg = p.light2, bold = true, })
	local fencoding = vim.bo.fenc
	local fformat = vim.bo.fileformat
	return "%#symbol_color#" ..
		symbol .. " %#StatusLine#" .. ftype:upper() .. " " .. fencoding:upper() .. " " .. fformat:upper()
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return "%5l/%L "
end

local active = function()
	return table.concat {
		mode(),
		lsp(),
		"%#StatusLine#",
		" %f %m %r %h",
		"%=",
		diagnostic(),
		filetype(),
		lineinfo(),
	}
end

local function inactive()
	return " %F"
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "LspAttach", "ModeChanged", "DiagnosticChanged" },
	{
		pattern = "*",
		callback = function()
			vim.api.nvim_set_option_value("statusline", active(), { scope = "local" })
		end
	}
)

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" },
	{
		pattern = "*",
		callback = function()
			vim.api.nvim_set_option_value("statusline", inactive(), { scope = "local" })
		end
	}
)
