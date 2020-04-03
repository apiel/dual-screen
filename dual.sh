#!/bin/sh

createDummyDisplayIntel() {
    INTEL_FILE="/usr/share/X11/xorg.conf.d/20-intel.conf"
    count=1
    if [ "$EUID" -ne 0 ]; then
        echo We may need sudo permissions to write the following file \"$INTEL_FILE\"
        echo
    fi
    sudo tee $INTEL_FILE >/dev/null <<TEXT
Section "Device"
 Identifier "intelgpu0"
 Driver "intel"
 Option "VirtualHeads" "$count"
EndSection
TEXT

    echo "Result\033[0;33m"
    cat $INTEL_FILE
    echo "\033[0m"
    echo Restart is needed to apply changes.
}

add_modeline() {
    local modeline name
    modeline="$(gtf "$2" "$3" "$4" | sed -n 's/.*Modeline "\([^" ]\+\)" \(.*\)/\1 \2/p')"
    name="$(echo "${modeline}" | sed 's/\([^ ]\+\) .*/\1/')"
    if [ -z "${modeline}" -o -z "${name}" ]; then
        echo "Error! modeline='${modeline}' name='${name}'"
        exit 1
    fi
    xrandr --delmode "$1" "${name}"
    xrandr --rmmode "${name}"
    xrandr --newmode ${modeline}
    xrandr --addmode "$1" "${name}"
    # xrandr --output $1 --mode ${name} --left-of eDP1
}

# createDummyDisplayIntel
# add_modeline VIRTUAL1 952 1620 60
add_modeline VIRTUAL1 1024 600 60
# add_modeline VIRTUAL1 2048 1200 60
#x11vnc -clip 952x1620+0+0
