return {
	'racagogi/mytilus',
	priority = 1000,
	lazy = false,
	config = function()
		require("mytilus.configs").setup(
			{
				theme    = 'light',
				options  = {
					
				},
				overides = {}
			}
		)
		vim.cmd [[colorscheme mytilus]]
	end
}
