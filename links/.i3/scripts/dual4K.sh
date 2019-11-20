#!/usr/bin/env bash


# default monitor (LVDS1, eDP)
DEFAULT_PORT=eDP1       # 2560x1440

# additional ports (HDMI-1, VGA1)
EXT_PORT_1=DP1-1
EXT_PORT_2=DP1-2
EXT_PORT_3=HDMI2


function PortConnected {
    ! xrandr | grep "^$1" | grep disconnected
}


function notify {
	NOTIFY_CMD=""
	command -v dust >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
}


if PortConnected ${EXT_PORT_1}; then
	# Use DPI: 96, 120 (25% higher), 144 (50% higher), 168 (75% higher), 192 (100% higher)
	#xrandr --dpi 120 --output ${DEFAULT_PORT} --mode 1920x1080 --pos 0x1080 --scale 1.0x1.0 --output ${EXT_PORT_1} --mode 3840x2160 --pos 1920x0 --rotate normal --scale 1.0x1.0
	#xrandr --dpi 120 --output ${DEFAULT_PORT} --mode 1920x1080 --pos 0x1080 --scale 1.25x1.25 --output ${EXT_PORT_1} --mode 3840x2160 --pos 2400x0 --rotate normal
	#xrandr --dpi 120 --output ${DEFAULT_PORT} --mode 1920x1080 --pos 0x1080 --scale 1.5x1.5 --output ${EXT_PORT_1} --mode 3840x2160 --pos 2880x0 --rotate normal --scale 0.8x0.8

	xrandr --output ${DEFAULT_PORT} --primary --mode 2560x1440 --pos 0x720 --rotate normal \
	--output ${EXT_PORT_2} --mode 3840x2160 --pos 2560x0 --rotate normal

	notify-send "Extending desktop to ${DEFAULT_PORT} screen"
	sleep 2

	xrandr \
		--output ${DEFAULT_PORT} --primary --mode 2560x1440 --pos 0x720 --rotate normal \
		--output ${EXT_PORT_2} --mode 3840x2160 --pos 2560x0 --rotate normal \
		--output ${EXT_PORT_1} --mode 1920x1080 --pos 6400x136 --rotate left


	# HDPI settings
	#export QT_AUTO_SCREEN_SCALE_FACTOR=1  # enable automatic scaling for Qt
	#export GDK_SCALE=2
	#export GDK_DPI_SCALE=0.5    # scaling of text
elif PortConnected ${EXT_PORT_3}; then
	xrandr --output ${EXT_PORT_3} --auto --pos 2560x0
else
	xrandr --output ${DEFAULT_PORT} --primary --mode 2560x1440 --pos 0x0 \
	--output ${EXT_PORT_1} --off \
	--output ${EXT_PORT_2} --off \
	--output ${EXT_PORT_3} --off 
fi
