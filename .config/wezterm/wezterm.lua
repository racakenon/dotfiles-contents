local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end
config = {
    color_scheme = 'Gruvbox light, soft (base16)',
}

require 'shape'.set(config)
require 'font'.set(config)
require 'key'.set(config)
return config
