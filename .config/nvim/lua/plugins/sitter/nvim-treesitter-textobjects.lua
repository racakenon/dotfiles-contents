return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["as"] = "@scope"
					},
					include_surrounding_whitespace = true,
				},
				swap = {
					enable = true,
					swap_previous = {
						["<M-N>"] = "@parameter.inner",
					},
					swap_next = {
						["<M-n>"] = "@parameter.inner",
					},
				},
			},
		}
	end
}
