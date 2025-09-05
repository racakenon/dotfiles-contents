return {
	'racagogi/mytilus',
	priority = 1000,
	lazy = false,
	config = function()
		require("mytilus.configs").setup(
			{
				theme    = 'light',
				options  = {
					str = { bold = true },
					keyword = { bold = true, italic = true },
					func = { italic = true },
					comment = { italic = true }
				},
				overides = {}
			}
		)
		vim.cmd [[colorscheme mytilus]]
	end
}
