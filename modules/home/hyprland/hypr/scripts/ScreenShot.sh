#!/bin/sh

# Ensure screenshot directory exists
dir="$(xdg-user-dir)/Pictures/Screenshots"
[ ! -d "${dir}" ] && mkdir -p "${dir}"

# Create screenshot names
time=$(date "+%Y-%m-%d_%H%M%S")
file="${dir}/Screenshot_${time}_${RANDOM}.png"
active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
active_window_file="${dir}/Screenshot_${time}_${active_window_class}.png"
notify_cmd_base="notify-send -a "Screenshot" -u low"

notify_screenshot() {
    # Exit early if image failed to save
    [ ! -f "$1" ] && $notify_cmd_base "Screenshot captured but did not save" && exit 1

    # If default action is taken for notification, execute swappy with image
    ret=$($notify_cmd_base -t 1 -i "$1" --action="default=Mark up image" "$2" "Click to markup image")
    [ "default" == "$ret" ] && swappy -f "$1"
}

shotnow() {
    grim - | tee "$file" | wl-copy
    notify_screenshot "${file}" "Captured screenshot"
}

# TODO: Replace with shotmonitor method
# shotwin() {
#    w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
#    w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
#    grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
#    notify_screenshot "${file}"
# }

shotarea() {
    tmpfile=$(mktemp)
    grim -g "$(slurp)" - >"$tmpfile"
    # Exit early if no image captured
    [ -s $tmpfile ] || exit 1
    wl-copy <"$tmpfile"
    mv "$tmpfile" "$file"
    notify_screenshot "${file}" "Captured screenshot of area"
}

shotactive() {
    hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' \
        | grim -g "${active_window_file}"
    notify_screenshot "${active_window_file}" "Captured screenshot of ${active_window_class}"
}


if [[ "$1" == "--now" ]]; then
    shotnow
elif [[ "$1" == "--win" ]]; then
    shotwin
elif [[ "$1" == "--area" ]]; then
    shotarea
elif [[ "$1" == "--active" ]]; then
    shotactive
else
    echo -e "Available Options : --now --win --area --active"
fi

exit 0
