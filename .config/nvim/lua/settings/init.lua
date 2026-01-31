local function load_setting(dir)
	local path = vim.fn.stdpath("config") .. "/lua/settings/" .. dir
	for fname in vim.fs.dir(path) do
		local n = fname:match("^(.*)%.lua$")
		if n ~= nil then
			pcall(require, "settings" .. "." .. dir .. "." .. n)
		end
	end
end

load_setting("languages")
load_setting("utils")
load_setting("options")
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})
