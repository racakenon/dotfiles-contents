return {
	'racagogi/even',
	priority = 1000,
	lazy = false,
	config = function()
		require("mytilus").setup(
			{
				theme = 'light'
			}
		)
		vim.cmd [[colorscheme mytilus]]
	end
}
