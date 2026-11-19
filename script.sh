#!/bin/bash

X_COORD=1098
Y_COORD=405
LOOP_DELAY=0.6

trap "kill 0 2>/dev/null" EXIT

echo "F8 starts/stops the macro"
echo "Ctrl+C exits"

python3 - "$X_COORD" "$Y_COORD" "$LOOP_DELAY" << 'EOF'
import select
import subprocess
import sys

import evdev
from evdev import ecodes

x_coord, y_coord, loop_delay = sys.argv[1], sys.argv[2], float(sys.argv[3])
running = False
macro_proc = None

devices = [evdev.InputDevice(path) for path in evdev.list_devices()]
keyboards = [d for d in devices if ecodes.EV_KEY in d.capabilities() and ecodes.KEY_F8 in d.capabilities()[ecodes.EV_KEY]]

if not keyboards:
    print("No keyboard found in /dev/input")
    print("Add this user to the input group if needed:")
    print("sudo usermod -aG input $USER")
    sys.exit(1)

bash_loop = f"""
while true; do
  hyprctl repl "hl.dispatch(hl.dsp.cursor.move({{ x = {x_coord}, y = {y_coord} }}))" > /dev/null
  sleep 0.05
  ydotool mousemove -- 1 0 > /dev/null 2>&1
  sleep 0.1
  ydotool click 0xC0 > /dev/null 2>&1
  sleep 0.2
  ydotool click 0xC0 > /dev/null 2>&1
  sleep 0.02
  ydotool click 0xC0 > /dev/null 2>&1
  sleep 0.02
  ydotool click 0xC0 > /dev/null 2>&1
  ydotool key 57:1 57:0 > /dev/null 2>&1
  sleep {loop_delay}
done
"""

while True:
    r, _, _ = select.select(keyboards, [], [])
    for dev in r:
        for event in dev.read():
            if event.type == ecodes.EV_KEY and event.code == ecodes.KEY_F8 and event.value == 1:
                running = not running
                if running:
                    print("Started")
                    subprocess.run(["notify-send", "-t", "1200", "Grenade Macro", "Started"], stderr=subprocess.DEVNULL)
                    macro_proc = subprocess.Popen(["bash", "-c", bash_loop])
                else:
                    print("Stopped")
                    subprocess.run(["notify-send", "-t", "1200", "Grenade Macro", "Stopped"], stderr=subprocess.DEVNULL)
                    if macro_proc:
                        macro_proc.terminate()
                        macro_proc = None
EOF
