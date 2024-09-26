#!/bin/bash
# A bash script designed to run only once dotfiles installed

# THIS SCRIPT CAN BE DELETED ONCE SUCCESSFULLY BOOTED!! And also, edit ~/.config/hypr/configs/Settings.conf
# not necessary to do since this script is only designed to run only once as long as the marker exists
# However, I do highly suggest not to touch it since again, as long as the marker exist, script wont run

# Variables
scriptsDir=$HOME/.config/hypr/scripts
wallpaper=$HOME/.config/hypr/wallpaper_effects/.wallpaper_modified
waybar_style="$HOME/.config/waybar/style/[Wallust] Box type.css"

swww="swww img"
effect="--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2"

# Check if a marker file exists.
if [ ! -f ~/.config/hypr/.initial_startup_done ]; then
    sleep 1
    # Initialize wallust and wallpaper
	if [ -f "$wallpaper" ]; then
		wallust run -s $wallpaper > /dev/null 
		swww query || swww-daemon && $swww $wallpaper $effect
	    "$scriptsDir/WallustSwww.sh" > /dev/null 2>&1 & 
	fi
     
    # initiate the kb_layout (for some reason) waybar cant launch it
    "$scriptsDir/SwitchKeyboardLayout.sh" > /dev/null 2>&1 &

    # Initial waybar style
	if [ -f "$waybar_style" ]; then
    	ln -sf "$waybar_style" "$HOME/.config/waybar/style.css"

		# Refreshing waybar, swaync, rofi etc. 
		"$scriptsDir/Refresh.sh" > /dev/null 2>&1 & 
	fi

    # Create a marker file to indicate that the script has been executed.
    touch ~/.config/hypr/.initial_startup_done

    exit
fi
