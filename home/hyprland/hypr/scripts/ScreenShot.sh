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

shotmonitor() {
    monitor=$(hyprctl -j activeworkspace | jq -r '(.monitor)')
    grim -o $monitor - | tee "$file" | wl-copy
    notify_screenshot "${file}" "Captured screenshot of monitor ${monitor}"
}

shotarea() {
    tmpfile=$(mktemp)
    grim -g "$(slurp -w 0)" - >"$tmpfile"
    if [ -s "$tmpfile" ]; then
        wl-copy <"$tmpfile"
        mv "$tmpfile" "$file"
        notify_screenshot "${file}" "Captured screenshot of area"
    else
        rm "$tmpfile"
        exit 1
    fi
}

shotactive() {
    window_region=$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    grim -g "${window_region}" - | tee "${active_window_file}" | wl-copy
    notify_screenshot "${active_window_file}" "Captured screenshot of ${active_window_class}"
}


if [[ "$1" == "--now" ]]; then
    shotnow
elif [[ "$1" == "--monitor" ]]; then
    shotmonitor
elif [[ "$1" == "--area" ]]; then
    shotarea
elif [[ "$1" == "--active" ]]; then
    shotactive
else
    echo -e "Available Options : --now --monitor --area --active"
fi

exit 0
