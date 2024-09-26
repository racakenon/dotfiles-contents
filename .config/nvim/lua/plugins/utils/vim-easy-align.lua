return {
	"junegunn/vim-easy-align",
	config = function ()
		vim.keymap.set({"v","n"},"<M-f>","<Plug>(EasyAlign)")
	end
}
