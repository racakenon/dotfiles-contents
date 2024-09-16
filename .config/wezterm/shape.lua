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
	config.window_background_opacity = 0.8
    config.window_decorations = "NONE"
    config.inactive_pane_hsb = {
        saturation = 1,
        brightness = 1,
    }
end

return module
