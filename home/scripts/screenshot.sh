#!/bin/sh

# Ensure screenshot directory exists
dir="$(xdg-user-dir)/Pictures/Screenshots"
[ ! -d "${dir}" ] && mkdir -p "${dir}"

# Create screenshot names
time=$(date "+%Y-%m-%d_%H%M%S")
file="${dir}/Screenshot_${time}_${RANDOM}.png"

notify_screenshot() {
    # Exit early if image failed to save
    [ ! -f "$1" ] && $notify_cmd_base "Screenshot captured but did not save" && exit 1

    # If default action is taken for notification, execute swappy with image
    ret=$(notify-send -a "Screenshot" -u low -t 1 -i "$1" --action="default=Mark up image" "$2" "Click to markup image")
    [ "default" == "$ret" ] && swappy -f "$1"
}

screen() {
    grimblast copysave screen "${file}"
    notify_screenshot "${file}" "Captured screenshot"
}

monitor() {
    grimblast copysave output "${file}"
    notify_screenshot "${file}" "Captured screenshot of monitor"
}

area() {
    grimblast --freeze copysave area "${file}"
    if [ -s "$file" ]; then
        notify_screenshot "${file}" "Captured screenshot of area"
    fi
}

if [[ "$1" == "--screen" ]]; then
    screen
elif [[ "$1" == "--monitor" ]]; then
    monitor
elif [[ "$1" == "--area" ]]; then
    area
else
    echo -e "Available Options : --screen --monitor --area"
fi

exit 0
