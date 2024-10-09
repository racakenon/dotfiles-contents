local module = {}
local wezterm = require 'wezterm'

function module.set(config)
	config.disable_default_key_bindings = true
	config.disable_default_mouse_bindings = true
	config.keys = {
		{ key = 'c',          mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
		{ key = 'v',          mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
		{ key = '%',          mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'DefaultDomain' }, },
		{ key = 'PageUp',     mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(-1) },
		{ key = 'PageDown',   mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(1) },
		{ key = '"',      mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'DefaultDomain' }, },
		{ key = 'f',          mods = 'SHIFT|CTRL', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
		{ key = 'q',          mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true }, },
		{ key = 'K',          mods = 'SHIFT|CTRL', action = wezterm.action.ClearScrollback 'ScrollbackOnly' },
		{ key = 'LeftArrow',  mods = 'SHIFT|CTRL', action = wezterm.action.ActivatePaneDirection 'Left' },
		{ key = 'RightArrow', mods = 'SHIFT|CTRL', action = wezterm.action.ActivatePaneDirection 'Right' },
		{ key = 'UpArrow',    mods = 'SHIFT|CTRL', action = wezterm.action.ActivatePaneDirection 'Up' },
		{ key = 'DownArrow',  mods = 'SHIFT|CTRL', action = wezterm.action.ActivatePaneDirection 'Down' },
		{ key = 'n',  mods = 'SHIFT|CTRL', action = wezterm.action.ActivatePaneDirection 'Next' },
		{ key = 'x',  mods = 'SHIFT|CTRL', action = wezterm.action.RotatePanes 'CounterClockwise' },
	}
	config.mouse_bindings = {
		{
			event = { Down = { streak = 1, button = 'Left' } },
			mods = 'NONE',
			action = wezterm.action.SelectTextAtMouseCursor("Cell")
		},
		{
			event = { Down = { streak = 2, button = 'Left' } },
			mods = 'NONE',
			action = wezterm.action.SelectTextAtMouseCursor("Word")
		},
		{
			event = { Down = { streak = 3, button = 'Left' } },
			mods = 'NONE',
			action = wezterm.action.SelectTextAtMouseCursor("Line")
		},
		{
			event = { Drag = { streak = 1, button = 'Left' } },
			mods = 'NONE',
			action = wezterm.action.ExtendSelectionToMouseCursor("Cell")
		},
		{
			event = { Drag = { streak = 2, button = 'Left' } },
			mods = 'NONE',
			action = wezterm.action.ExtendSelectionToMouseCursor("Word")
		},
		{
			event = { Drag = { streak = 3, button = 'Left' } },
			mods = 'NONE',
			action = wezterm.action.ExtendSelectionToMouseCursor("Line")
		},
		{
			event = { Drag = { streak = 1, button = 'Left' } },
			mods = 'SHIFT',
			action = wezterm.action.ExtendSelectionToMouseCursor("Block")
		},
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = 'NONE',
			action = wezterm.action.ScrollByCurrentEventWheelDelta,
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = 'NONE',
			action = wezterm.action.ScrollByCurrentEventWheelDelta,
		},
	}
end

return module
