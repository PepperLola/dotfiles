local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

local handle = io.popen("aerospace list-workspaces --all")
local result = handle:read("*a")
handle:close()

-- Split the output into individual workspace lines
local workspaces = {}
for line in result:gmatch("[^\r\n]+") do
    table.insert(workspaces, line)
end

local handle = io.popen("aerospace list-windows --all --format '%{app-name}\n%{workspace}'")
local result = handle:read("*a")
handle:close()

apps = {}
for name, workspace in result:gmatch("([^\n]+)\n([^\n]+)") do
    apps[workspace] = name
end

local spaces = {}

-- Add each workspace to sketchybar
for i, workspace in ipairs(workspaces) do
    if apps[workspace] == nil then
        goto continue
    end
    local text = workspace .. ": " .. tostring(apps[workspace])
    local space = sbar.add("item", "space." .. workspace, {
        icon = {
            font = { family = settings.font.numbers },
            string = text,
            padding_left = 15,
            padding_right = 8,
            color = colors.white,
            highlight_color = colors.red,
        },
        padding_right = 1,
        padding_left = 1,
        background = {
            color = colors.bg1,
            border_width = 1,
            height = 26,
            border_color = colors.black,
        },
        popup = { background = { border_width = 5, border_color = colors.black } },
        click_script = "aerospace workspace " .. workspace,
        script = "$CONFIG_DIR/plugins/aerospace.sh"
    })

    spaces[i] = space

    local space_bracket = sbar.add("bracket", { space.name }, {
        background = {
            color = colors.transparent,
            border_color = colors.bg2,
            height = 28,
            border_width = 2
        }
    })

    sbar.add("item", "space.padding." .. workspace, {
        script = "",
        width = settings.group_paddings
    })

    local space_popup = sbar.add("item", {
        position = "popup." .. space.name,
        padding_left = 5,
        padding_right = 0,
        background = {
            drawing = true,
            image = {
                corner_radius = 9,
                scale = 0.2
            }
        }
    })

    space:subscribe("space_change", function(env)
        local selected = env.SELECTED == "true"
        local color = select and colors.grey or colors.bg2
        space:set({
            icon = { highlight = selected, },
            label = { highlight = selected, },
            background = { border_color = selected and colors.grey or colors.bg2 }
        })
        space_bracket:set({
            background = { border_color = selected and colors.grey or colors.bg2 }
        })
    end)

    space:subscribe("mouse.exited", function(_)
        space:set({ popup = { drawing = false } })
    end)
    ::continue::
end

local space_window_observer = sbar.add("item", {
    drawing = false,
    updates = true,
})

local spaces_indicator = sbar.add("item", {
    padding_left = -3,
    padding_right = 0,
    icon = {
        padding_left = 8,
        padding_right = 9,
        color = colors.grey,
        string = icons.switch.on,
    },
    label = {
        width = 0,
        padding_left = 0,
        padding_right = 8,
        string = "Spaces",
        color = colors.bg1,
    },
    background = {
        color = colors.with_alpha(colors.grey, 0.0),
        border_color = colors.with_alpha(colors.bg1, 0.0)
    }
})
