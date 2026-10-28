#!/bin/bash
# Screenshot the currently focused monitor to ~/Pictures/screenshot.png
out=$(swaymsg -t get_outputs -r | python3 -c "import json,sys; print([o['name'] for o in json.load(sys.stdin) if o.get('focused')][0])")
grim -o "$out" /var/home/connor/Pictures/screenshot.png
