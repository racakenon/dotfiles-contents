return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = function()
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)
		require("nvim-autopairs").setup {
			enable_check_bracket_line = true,
			fast_wrap = {},
		}
	end
}
