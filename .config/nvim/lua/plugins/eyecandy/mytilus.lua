return {
	'racagogi/mytilus',
	priority = 1000,
	config=function ()
		vim.o.background = 'light'
		vim.cmd[[colorscheme mytilus-light]]
	end
}
