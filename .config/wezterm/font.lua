local module = {}
local wezterm = require 'wezterm'
function module.set(config)
	config.font_size       = 18
	config.unicode_version = 14
	config.font            = wezterm.font_with_fallback {
		{
			family = 'JetBrains Mono',
			weight = 'Regular',
			style = "Normal"
		},
		"KoPubWorld돋움체_Pro Medium",
		"Noto Color Emoji"
	}
	config.font_rules      = {
		{
			intensity = 'Bold',
			italic = true,
			font = wezterm.font_with_fallback {
				{
					family = 'JetBrains Mono',
					weight = 'Bold',
					style = "Italic"
				},
				"KoPubWorld바탕체_Pro Bold",
				"Noto Color Emoji"
			},
		},
		{
			intensity = 'Bold',
			italic = false,
			font = wezterm.font_with_fallback {
				{
					family = 'JetBrains Mono',
					weight = 'Bold',
					style = "Normal"
				},
				"KoPubWorld돋움체_Pro Bold",
				"Noto Color Emoji"
			}
		},
		{
			italic = true,
			font = wezterm.font_with_fallback {
				{
					family = 'JetBrains Mono',
					weight = 'Regular',
					style = "Italic"
				},
				"KoPubWorld바탕체_Pro Medium",
				"Noto Color Emoji"
			}
		}
	}
end

return module
