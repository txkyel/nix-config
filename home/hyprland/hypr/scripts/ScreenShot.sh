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
    grimblast copysave screen "${file}"
    notify_screenshot "${file}" "Captured screenshot"
}

shotmonitor() {
    grimblast copysave output "${file}"
    notify_screenshot "${file}" "Captured screenshot of monitor"
}

shotarea() {
    grimblast --freeze copysave area "${file}"
    if [ -s "$file" ]; then
        notify_screenshot "${file}" "Captured screenshot of area"
    fi
}

shotactive() {
    grimblast copysave active "${active_window_file}"
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
