local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath })
end

vim.opt.rtp:prepend(lazypath)

local function load_plugins()
	local plugins = {}
	local config_path = vim.fn.stdpath("config") .. "/lua/plugins/"
	local dirs = {}
	for name, type in vim.fs.dir(config_path) do
		if type == "directory" then table.insert(dirs, name) end
	end
	table.sort(dirs)
	for _, name in ipairs(dirs) do
		local fnames = {}
		for fname in vim.fs.dir(config_path .. name) do
			table.insert(fnames, fname)
		end
		table.sort(fnames)
		for _, fname in ipairs(fnames) do
			local n = fname:match("(.*)%.lua")
			local ok, plugin = pcall(require, "plugins" .. "." .. name .. "." .. n)
			if ok then table.insert(plugins, plugin) end
		end
	end
	require("lazy").setup(plugins)
end

load_plugins()
