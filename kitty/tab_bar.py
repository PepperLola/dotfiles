import json
import random
import subprocess
from collections import defaultdict
from datetime import datetime, timezone

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.rgb import Color
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)
from kitty.utils import color_as_int

timer_id = None

opts = get_options()

ICONS = [
    "  ",
    "  ",
    "  ",
    "  ",
    " 󰑱 ",
    "  ",
    "  ",
    "  ",
    "  "
]
RIGHT_MARGIN = 1
REFRESH_TIME = 1
UNPLUGGED_ICONS = {
    10: "",
    20: "",
    30: "",
    40: "",
    50: "",
    60: "",
    70: "",
    80: "",
    90: "",
    100: "",
}
PLUGGED_ICONS = {
    1: "",
}
UNPLUGGED_COLORS = {
    15: as_rgb(color_as_int(opts.color1)),
    16: as_rgb(color_as_int(opts.color15)),
}
PLUGGED_COLORS = {
    15: as_rgb(color_as_int(opts.color1)),
    16: as_rgb(color_as_int(opts.color6)),
    99: as_rgb(color_as_int(opts.color6)),
    100: as_rgb(color_as_int(opts.color2)),
}

icon_fg = as_rgb(color_as_int(opts.color16))
icon_bg = as_rgb(color_as_int(opts.color8))
bat_text_color = as_rgb(color_as_int(opts.color15))
clock_color = as_rgb(color_as_int(opts.color15))
date_color = as_rgb(color_as_int(opts.color8))

def _draw_icon(screen, index):
    if index != 1:
        return 0
    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = icon_fg
    screen.cursor.bg = icon_bg
    i = random.randint(0, len(ICONS) - 1)
    icon = ICONS[i]
    screen.draw(icon)
    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(icon)
    return screen.cursor.x

def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    draw_title(draw_data, screen, tab, index)
    return screen.cursor.x

def _draw_right_status(
    draw_data: DrawData,
    screen: Screen,
    is_last: bool,
) -> int:
    if not is_last:
        return 0

    draw_attributed_string(Formatter.reset, screen)

    clock = datetime.now().strftime("%H:%M")
    date = datetime.now().strftime(" %m.%d.%Y")

    cells = []

    cells.append((clock, clock_color))
    cells.append((date, date_color))

    right_status_length = RIGHT_MARGIN
    for cell in cells:
        right_status_length += len(str(cell[0]))

    # draw_spaces = screen.columns - screen.cursor.x - right_status_length

    # if draw_spaces > 0:
    #     screen.draw(" " * draw_spaces)

    screen.cursor.x = screen.columns - right_status_length

    # screen.draw(" " * RIGHT_MARGIN)
    screen.cursor.fg = 0
    for status, color in cells:
        screen.cursor.fg = color
        screen.draw(status)
    # screen.draw(" " * RIGHT_MARGIN)
    screen.cursor.bg = 0

    # if screen.columns - screen.cursor.x > right_status_length:
    #     screen.cursor.x = screen.columns - right_status_length

    return screen.cursor.x

def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    global timer_id
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)

    _draw_icon(screen, index)
    _draw_left_status(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data)
    _draw_right_status(draw_data, screen, is_last)

    return screen.cursor.x
