local icon = require("nvim-web-devicons")

local function fileformat()
	local fformat = vim.bo.fileformat
	local fficon = ""
	if fformat == "unix" then
		fficon = ""
	elseif fformat == "dos" then
		fficon = ""
	else
		fficon = ""
	end
	return fficon
end

local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)

local modes = {
	['n']    = { 'Normal', '%#MiniStatuslineModeNormal#' },
	['v']    = { 'Visual', '%#MiniStatuslineModeVisual#' },
	['V']    = { 'V-Line', '%#MiniStatuslineModeVisual#' },
	[CTRL_V] = { 'V-Block', '%#MiniStatuslineModeVisual#' },
	['s']    = { 'Select', '%#MiniStatuslineModeVisual#' },
	['S']    = { 'S-Line', '%#MiniStatuslineModeVisual#' },
	[CTRL_S] = { 'S-Block', '%#MiniStatuslineModeVisual#' },
	['i']    = { 'Insert', '%#MiniStatuslineModeInsert#' },
	['R']    = { 'Replace', '%#MiniStatuslineModeReplace#' },
	['c']    = { 'Command', '%#MiniStatuslineModeCommand#' },
	['r']    = { 'Prompt', '%#MiniStatuslineModeOther#' },
	['!']    = { 'Shell', '%#MiniStatuslineModeOther#' },
	['t']    = { 'Terminal', '%#MiniStatuslineModeOther#' },
}



local function mode()
	local currnet_mode = modes[vim.fn.mode(0)]
	return currnet_mode[2] .. " " .. fileformat() .. " | " .. currnet_mode[1] .. " " .. "%#StatusLine#"
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
	return "no active lsp"
end

local function diagnostic()
	local bufnr = vim.api.nvim_get_current_buf()
	local errors = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
	local infos = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
	local hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
	local error = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
	local warn = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
	local help = vim.api.nvim_get_hl(0, { name = "DiagnosticHelp" })
	local info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })

	vim.api.nvim_set_hl(0, "stError", { fg = error.fg, bg = hl.bg, bold = true })
	vim.api.nvim_set_hl(0, "stWarn", { fg = warn.fg, bg = hl.bg, bold = true })
	vim.api.nvim_set_hl(0, "stInfo", { fg = help.fg, bg = hl.bg, bold = true })
	vim.api.nvim_set_hl(0, "stHint", { fg = info.fg, bg = hl.bg, bold = true })
	return "%#stError#" .. " " .. errors ..
		"%#stWarn#" .. "  " .. warnings ..
		"%#stHint#" .. "  " .. hints ..
		"%#stInfo#" .. "  " .. infos .. "%#StatusLine# "
end

local function lspname()
	local ftype = vim.bo.filetype
	local symbol, symbol_color = icon.get_icon_color_by_filetype(ftype, { default = true })
	local hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
	vim.api.nvim_set_hl(0, "symbol_color", { fg = symbol_color, bg = hl.bg })
	local fencoding = vim.bo.fenc == "utf-8" and "" or vim.bo.fenc .. " "
	return " %#symbol_color#" .. symbol .. "%#StatusLine#" .. " " .. lsp() .. fencoding:upper()
end

local function lineinfo()
	local ftype = vim.bo.filetype
	local currnet_mode = modes[vim.fn.mode(0)]
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return currnet_mode[2] .. "%5l/%L | " .. ftype:upper() .. " "
end

local active = function()
	return table.concat {
		mode(),
		lspname(),
		"%=",
		" %f %m %r %h",
		"%=",
		diagnostic(),
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
