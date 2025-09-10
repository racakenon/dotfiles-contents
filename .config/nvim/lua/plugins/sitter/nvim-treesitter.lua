return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = "all",
			sync_install = false,
			auto_install = true,
			ignore_install = {"ipkg"},
			modules = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-s>",
					node_incremental = "<M-a>",
					node_decremental = "<M-x>",
				},
			},
		}
	end
}
