#!/bin/bash

# give Noctalia time to write CSS
sleep 0.3

# close Zen cleanly
pkill -TERM zen

# wait a moment
sleep 0.5

# relaunch Zen
zen &
