#!/usr/bin/env bash

# Terminate already running compton instances
killall -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

# Launch compton in background, using default config location ~/.config/compton/compton.conf
picom -b --config $HOME/.config/picom/picom.conf --experimental-backends --xrender-sync-fence

echo "Picom launched..."
