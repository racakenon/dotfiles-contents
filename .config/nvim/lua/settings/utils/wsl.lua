local uv = vim.uv

local function is_wsl()
	local ok, uname = pcall(uv.os_uname)
	if not ok or not uname or not uname.release then
		return false
	end
	local r = string.lower(uname.release)
	return (string.find(r, "microsoft", 1, true) ~= nil)
		or (string.find(r, "wsl", 1, true) ~= nil)
end

local function get_exepath(name)
	local ok, path = pcall(vim.fn.exepath, name)
	if not ok or type(path) ~= "string" or path == "" then
		return ""
	end
	return path
end

local function setup_wsl_clipboard()
	if not is_wsl() then
		return
	end

	local win32yank = get_exepath("win32yank.exe")
	if win32yank ~= "" then
		return
	end

	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = { "sh", "-c", "iconv -f utf-8 -t utf-16le | clip.exe" },
			["*"] = { "sh", "-c", "iconv -f utf-8 -t utf-16le | clip.exe" },
		},
		paste = {
			["+"] = {
				"powershell.exe",
				"-NoLogo",
				"-NoProfile",
				"-Command",
				"[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; " ..
				"[Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace(\"`r\", \"\"))",
			},
			["*"] = {
				"powershell.exe",
				"-NoLogo",
				"-NoProfile",
				"-Command",
				"[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; " ..
				"[Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace(\"`r\", \"\"))",
			},
		},
		cache_enabled = 0,
	}
end

setup_wsl_clipboard()
