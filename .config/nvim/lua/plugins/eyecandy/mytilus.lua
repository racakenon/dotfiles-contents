return {
	'racagogi/mytilus',
	priority = 1000,
	lazy = false,
	config = function()
		require("mytilus").setup(
			{
				theme    = 'dark',
				options  = {
					bold = {
						["sy.keyword"] = true,
						["sy.type"] = true,
					}
				},
				overides = {}
			}
		)
		vim.cmd [[colorscheme mytilus]]
	end
}
