return {
	"junegunn/vim-easy-align",
	keys = { { "<M-f>", mode = { "v", "n" } } },
	config = function()
		vim.keymap.set({"v","n"},"<M-f>","<Plug>(EasyAlign)")
	end
}
