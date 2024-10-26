local module = {}

function module.set(config)
	config.window_padding = {
		left = 15,
		right = 0,
		top = 15,
		bottom = 0,
	}
	config.audible_bell = 'Disabled'
	config.enable_tab_bar = false
	config.window_background_opacity = 1.0
	config.window_decorations = "NONE"
	config.inactive_pane_hsb = {
		saturation = 1,
		brightness = 1,
	}
	config.colors = {
		-- The default text color
		foreground = "#040204",
		-- The default background color
		background = "#EBEFE9",

		-- Overrides the cell background color when the current cell is occupied by the
		-- cursor and the cursor style is set to Block
		cursor_bg = '#2A2E32',
		-- Overrides the text color when the current cell is occupied by the cursor
		cursor_fg = "#C1BCB6",
		-- Specifies the border color of the cursor when the cursor style is set to Block,
		-- or the color of the vertical or horizontal bar when the cursor style is set to
		-- Bar or Underline.
		cursor_border = "#322B2C",

		-- the foreground color of selected text
		selection_fg = "#B6BFBF",
		-- the background color of selected text
		selection_bg = '#2A2E32',

		-- The color of the scrollbar "thumb"; the portion that represents the current viewport
		scrollbar_thumb = '#2A2E32',

		-- The color of the split lines between panes
		split = '#322B2C',

		ansi = {
			"#B6BFBF",
			"#8D5038",
			"#6D641E",
			"#287253",
			"#096E87",
			"#5B5C95",
			"#854D71",
			"#040204"
		},
		brights = {
			"#C1BCB6",
			"#AD6D55",
			"#8A823E",
			"#48906F",
			"#368CA7",
			"#7779B5",
			"#A56A8F",
			"#322B2C",
		},

		compose_cursor = '#2A2E32',

		copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
		copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
		copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

		quick_select_label_bg = { Color = 'peru' },
		quick_select_label_fg = { Color = '#ffffff' },
		quick_select_match_bg = { AnsiColor = 'Navy' },
		quick_select_match_fg = { Color = '#ffffff' },
	}
end

return module
