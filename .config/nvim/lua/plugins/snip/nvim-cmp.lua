return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"doxnit/cmp-luasnip-choice",
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"kdheepak/cmp-latex-symbols",
		"hrsh7th/cmp-path"
	},
	config = function()
		local cmp = require 'cmp'
		local luasnip = require("luasnip")
		local lspkind = require('lspkind')


		cmp.setup {
			preselect = cmp.PreselectMode.None,
			completion = {
				completeopt = 'menu,menuone,noinsert,noselect',
			},
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			view = {
				entries = { name = 'custom', selection_order = 'near_cursor' }
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[Latex]",
					})
				}),
			},
			mapping = {
				['<C-y>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),
				["<C-t>"] = function() if luasnip.locally_jumpable(1) then luasnip.jump(1) end end,
				["<C-p>"] = function() if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end end,
				["<C-n>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item()
					end
				end, { "i", "s" }),
				["<C-l>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					end
				end, { "i", "s" }),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				["<C-b>"]   = cmp.mapping.abort(),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'luasnip_choice' },
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'latex_symbols' },
			}
		}
	end
}
