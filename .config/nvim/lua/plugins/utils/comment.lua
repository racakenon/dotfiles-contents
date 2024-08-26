return {
	"numToStr/Comment.nvim",
	config = function()
		require('Comment').setup({
			toggler = {
				line = '<M-c>c',
				block = '<M-b>b',
			},
			opleader = {
				line = '<M-c>',
				block = '<M-b>',
			},
			extra = {
				above = '<M-c>O',
				below = '<M-c>o',
				eol = '<M-c>A',
			},
		})
	end
}
