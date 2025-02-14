local module = {}
local wezterm = require 'wezterm'
local ko_normal = 'Pretendard GOV'
local en_normal = 'Monaspace Neon'
local ko_special = 'Gowun Batang'
local en_special = 'Monaspace Xenon'
local features = { 'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss09', 'liga', }
function module.set(config)
	config.font_size       = 16
	config.unicode_version = 15
	config.font            = wezterm.font_with_fallback {
		{
			family = en_normal,
			weight = 'Regular',
			style = "Normal",
			harfbuzz_features = features,
		},
		{
			family = ko_normal,
			weight = 'Regular',
			style = "Normal",
		},
		"Symbols Nerd Font Mono",
		"Noto Sans Symbols",
		"Noto Sans Symbols 2 Regular",
		"Noto Color Emoji"
	}
	config.font_rules      = {
		{
			intensity = 'Bold',
			italic = true,
			font = wezterm.font_with_fallback {
				{
					family = en_special,
					weight = 'Bold',
					style = "Normal",
					harfbuzz_features = features,
				},
				{
					family = ko_special,
					weight = 'Bold',
					style = "Normal",
				},

			},
		},
		{
			intensity = 'Bold',
			italic = false,
			font = wezterm.font_with_fallback {
				{
					family = en_normal,
					weight = 'Bold',
					style = "Normal",
					harfbuzz_features = features,
				},
				{
					family = ko_normal,
					weight = 'Bold',
					style = "Normal",
				},

			}
		},
		{
			italic = true,
			font = wezterm.font_with_fallback {
				{
					family = en_special,
					weight = 'Regular',
					style = "Normal",
					harfbuzz_features = features,
				},
				{
					family = ko_special,
					weight = 'Regular',
					style = "Normal",
				},

			}
		}
	}
end

return module
