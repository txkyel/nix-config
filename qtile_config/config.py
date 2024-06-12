# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, widget
from libqtile.widget.battery import Battery, BatteryState, BatteryStatus
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import psutil

mod = "mod4"
terminal = "alacritty"

keys = [
    ### WINDOW MANAGEMENT
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Switch between windows
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(["mod1"], "tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Move up/down in current stack.
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # TODO: Remove? Keep?
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Fullscreen
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),

    ### SCREENS/GROUPS
    # Groups
    # Switch between groups
    Key([mod], "h", lazy.screen.prev_group(), desc="Switch to prev group"),
    Key([mod], "l", lazy.screen.next_group(), desc="Switch to next group"),
    # TODO: Add function to move windows to next group
    # Key([mod, "shift"], "h", lazy.screen.prev_group(skip_empty=True), desc="Switch to prev group"),
    # Key([mod, "shift"], "l", lazy.screen.next_group(skip_empty=True), desc="Switch to next group"),
    Key([mod], "space", lazy.screen.next_group(skip_empty=True), desc="Switch to next non-empty group"),
    # Screens
    Key([mod], "comma", lazy.prev_screen(), desc="Move focus to previous screen"),
    Key([mod], "period", lazy.next_screen(), desc="Move focus to next screen"),

    # Spawn programs
    # rofi
    Key([mod], "o", lazy.spawn("rofi -show drun"), desc="Spawn a command using rofi"),
    Key([mod], "p", lazy.spawn("rofipower"), desc="Shutdown menu"),
    # terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

      # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Keybindings
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 15%-"), desc="Lower Brightness"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 15%+"), desc="Increase Brightness"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-"), desc="Lower Volume"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+"), desc="Increase Volume"),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer sset Master 1+ toggle"),
        desc="Mute/Unmute Volume"
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn("amixer sset Capture 1+ toggle"),
        desc="Mute/Unmute Mic"
    ),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause player"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Skip to next"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Skip to previous"),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop"), desc="Stop player"),
    Key(
        [],
        "Print",
        lazy.spawn("maim -u | xclip -selection clipboard -t image/png", shell=True),
        desc="Screenshot desktop to clipboard"
    ),
    Key(
        [mod, "shift"],
        "s",
        lazy.spawn("maim -us | xclip -selection clipboard -t image/png", shell=True),
        desc="Screenshot selection to clipboard"
    ),
]


### GROUPS
groups = [Group(i) for i in "123456"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + control + group number = switch to & move focused window to group
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # # mod1 + control + group number = move focused window to group
            # Key(
            #     [mod, "control"],
            #     i.name,
            #     lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)
            # ),
        ]
    )

# Dracula colour scheme
colors = {
    "fg": "#F8F8F2",
    "bg": "#282A36",
    "0":     "#000000", # Black
    "8":     "#4D4D4D",
    "1":     "#FF5555", # Red
    "9":     "#FF6E67",
    "2":     "#50FA7B", # Green
    "10":    "#5AF78E",
    "3":     "#F1FA8C", # Yellow
    "11":    "#F4F99D",
    "4":     "#BD93F9", # Blue
    "12":    "#CAA9FA",
    "5":     "#FF79C6", # Purple
    "13":    "#FF92D0",
    "6":     "#8BE9FD", # Cyan
    "14":    "#9AEDFE",
    "7":     "#BFBFBF", # White
    "15":    "#E6E6E6",
}

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": colors["4"],
    "border_normal": colors["8"],
}

layouts = [
    layout.Max(),
    layout.Tile(**layout_theme),
    # layout.MonadTall(**layout_theme),
    # layout.Columns(**layout_theme, border_focus_stack=["#d75f5f", "#8f3d3d"]),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


### WIDGETS
class MyBattery(Battery):
    """Overrides the build_string method for better use of Nerd Font battery icons"""
    def build_string(self, status: BatteryStatus) -> str:
        if self.layout is not None:
            if status.state == BatteryState.DISCHARGING and status.percent < self.low_percentage:
                self.layout.color = self.low_foreground
                self.background = self.low_background
            else:
                self.layout.color = self.foreground
                self.background = self.normal_background

        if status.state == BatteryState.DISCHARGING:
            # Main override branch
            if status.percent >= 0.90:
                char = "󰂂"
            elif status.percent >= 0.80:
                char = "󰂁"
            elif status.percent >= 0.70:
                char = "󰂀"
            elif status.percent >= 0.60:
                char = "󰁿"
            elif status.percent >= 0.50:
                char = "󰁾"
            elif status.percent >= 0.40:
                char = "󰁽"
            elif status.percent >= 0.30:
                char = "󰁼"
            elif status.percent >= 0.20:
                char = "󰁻"
            elif status.percent >= 0.10:
                char = "󰁺"
            else:
                char = "󰂃"
        elif status.state == BatteryState.CHARGING:
            char = "󰂄"
        elif status.state == BatteryState.FULL or status.percent >= 1:
            char = "󰁹"
        elif status.state == BatteryState.EMPTY or \
                (status.state == BatteryState.UNKNOWN and status.percent == 0):
            char = "󰂎"
        else:
            char = "󰂑"

        # Hardcoded format with battery character and battery percentage
        return "{char} {percent:2.0%}".format(char=char, percent=status.percent)

class VolumeIcon(widget.Volume):
    """Overrides the _update_drawer method for better use of Nerd Font battery icons"""
    def _update_drawer(self):
        emoji_list=[" ", " ", " ", " "]
        if self.volume <= 0:
            self.text = emoji_list[0]
        elif self.volume <= 33:
            self.text = emoji_list[1]
        elif self.volume <= 66:
            self.text = emoji_list[2]
        else:
            self.text = emoji_list[3]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font Bold",
    fontsize=14,
    padding=3,
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()


def init_widgets(main_screen=False):
    # Add left hand side widgets
    widgets = [
        widget.Spacer(length=16),
        widget.CurrentLayoutIcon(
            scale=0.45,
        ),
        widget.Spacer(length=10),
        widget.GroupBox(
            margin=6,
            disable_drag=True,
            highlight_method="line",
            # Group label color
            active=colors["fg"],
            inactive=colors["8"],
            block_highlight_text_color=colors["6"],     # Focused group label on all screens
            # Focused styles
            highlight_color=colors["8"],                # Focused group bg on focused screen only
            this_current_screen_border=colors["4"],     # Focused group line on current focused screen
            this_screen_border=colors["8"],             # Focused group line on current unfocused screen
            other_current_screen_border=colors["4"],    # Focused group line on other focused screen
            other_screen_border=colors["8"],            # Focused group line on other unfocused screen
        ),
        widget.Spacer(length=10),
        widget.WindowName(max_chars=50),
    ]

    # Conditionally add systray widget
    if main_screen:
        widgets.extend([widget.Spacer(length=10), widget.Systray(padding=10)])

    # Add sensor widget
    widgets.extend([
        widget.Spacer(length=10),
        widget.ThermalSensor(
            tag_sensor="CPU",
            format=" {temp:.0f}{unit}",
            threshold=80,
            foreground=colors["3"],
            foreground_alert=colors["1"],
        ),
        widget.Spacer(length=10),
        widget.CPU(format="  {load_percent}%", foreground=colors["2"]),
        widget.Spacer(length=10),
        widget.Memory(format=" {MemUsed: .0f}{mm}", foreground=colors["4"]),
        # widget.Spacer(length=10),
        # widget.Bluetooth(),
    ])

    # Conditionally add battery widget
    if psutil.sensors_battery() is not None:
        widgets.extend([widget.Spacer(length=10), MyBattery(low_percentage=0.1, notify_below=0.1)])

    # Add fixed right hand side widgets
    widgets.extend([
        widget.Spacer(length=10),
        VolumeIcon(foreground=colors["6"]),
        widget.Volume(foreground=colors["6"]),
        widget.Spacer(length=10),
        widget.Clock(format="󰃭 %a, %b %d"),
        widget.Spacer(length=10),
        widget.Clock(format="󰥔 %H:%M"),
        widget.Spacer(length=16),
    ])
    return widgets

screens = [
    Screen(
        top=bar.Bar(
            widgets=init_widgets(main_screen=True),
            size=36,
            background=colors["bg"]
        ),
    ),
    Screen(
        top=bar.Bar(
            widgets=init_widgets(),
            size=36,
            background=colors["bg"]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
