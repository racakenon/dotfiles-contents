local function load_setting(dir)
	local path = vim.fn.stdpath("config") .. "/lua/settings/" .. dir
	for fname in vim.fs.dir(path) do
		local n = fname:match("^(.*)%.lua$")
		if n ~= nil then
			local ok, err = pcall(require, "settings" .. "." .. dir .. "." .. n)
			if not ok then
				vim.notify("settings." .. dir .. "." .. n .. ": " .. tostring(err), vim.log.levels.WARN)
			end
		end
	end
end

load_setting("languages")
load_setting("utils")
load_setting("options")
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})
