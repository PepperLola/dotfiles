local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = wezterm.config_builder()

wezterm.GLOBAL = wezterm.GLOBAL or {}
wezterm.GLOBAL.float_tabs = wezterm.GLOBAL.float_tabs or {}
wezterm.GLOBAL.return_tabs = wezterm.GLOBAL.return_tabs or {}

config.color_scheme = "Tokyo Night Moon"
config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium" })
config.font_size = 13.0
config.window_padding = { left = 4, right = 4, top = 32, bottom = 0 }
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.inactive_pane_hsb = { saturation = 0.85, brightness = 0.7 }
config.window_background_opacity = 0.9
config.macos_window_background_blur = 14

config.custom_block_glyphs = true
config.allow_square_glyphs_to_overflow_width = 'Always'

config.notification_handling = "AlwaysShow"

local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize { direction, 3 }
    }
end

local function activate_key_table(key, mods, name)
    return {
        key = key,
        mods = mods,
        action = wezterm.action.ActivateKeyTable {
            name = name,
            one_shot = false,
            timeout_milliseconds = 1000,
        }
    }
end

-- KEYS
config.keys = {
    activate_key_table('p', 'CTRL', 'pane'),
    activate_key_table('r', 'CTRL', 'resize'),
    { key = 'h', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Right' },
}

-- KEY TABLES
config.key_tables = {
    pane = {
        { key = '"', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = '%', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 'x', action = wezterm.action.CloseCurrentPane { confirm = false } },
        { key = 'f', action = wezterm.action.TogglePaneZoomState },
    },
    resize = {
        resize_pane('h', 'Left'),
        resize_pane('j', 'Down'),
        resize_pane('k', 'Up'),
        resize_pane('l', 'Right'),
    }
}

return config
