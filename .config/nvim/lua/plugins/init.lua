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
	for name, type in vim.fs.dir(config_path) do
		if type == "directory" then
			local path = config_path .. name
			for fname in vim.fs.dir(path) do
				local n = fname:match("(.*)%.lua")
				local _, plugin = pcall(require, "plugins" .. "." .. name .. "." .. n)
				table.insert(plugins, plugin)
			end
		end
	end
	require("lazy").setup(plugins)
end

load_plugins()
