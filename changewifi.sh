#!/bin/bash

# Vérifier le premier argument pour décider quel réseau choisir
if [ "$1" == "r" ]; then
    nmcli con up uuid 821cda88-62b8-49d3-8fef-087cb381495e
elif [ "$1" == "h" ]; then
    nmcli con up uuid 214daf21-96f6-426a-87c6-bdaaa0dc52d6
else
    echo "Changer de réseau wifi super rapidement. r : robot, h : home"
fi
