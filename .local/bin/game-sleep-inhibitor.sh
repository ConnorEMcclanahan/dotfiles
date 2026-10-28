#!/bin/bash
while true; do
    # Check if Steam, a Proton game container, or common game binaries are running
    if pgrep -x "steam" >/dev/null || pgrep -f "proton" >/dev/null || pgrep -f "wined3d" >/dev/null; then
        # Inhibit sleep while a game is detected
        systemd-inhibit --what=idle:sleep --who="GameRunning" --why="Active game session" sleep 60
    else
        # Check again in 30 seconds if no game is running
        sleep 30
    fi
done
