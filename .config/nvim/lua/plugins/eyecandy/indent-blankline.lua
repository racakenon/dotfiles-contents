return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
	},
	config = function()
		local highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		}
		require("ibl").setup {
			indent = { highlight = highlight },
			scope = { enabled = false }
		}
	end
}
