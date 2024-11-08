#!/usr/bin/env sh

# This file is required. It is sourced when checking the goal of the mission
# has been achieved.
# It should end with a command returning 0 on success, and something else on
# failure.
# It should "unset" any local variable it has created, and any "global
# variable" that were only used for the mission. (The function _mission_check
# is automatically unset.)
#
# It typically looks like

_mission_check() {
    correct_password=$(cat "$GSH_TMP/inner_password.txt")
    
    while true; do
        printf "$(gettext "What is the Inner Password ? ")"
        read -r answer
        
        if [ -z "$answer" ]; then
            echo "$(gettext "Please enter a password.")"
            continue
        fi
        
        if [ "$answer" = "$correct_password" ]; then
            return 0
        else
            echo "$(gettext "That's not the correct password!")"
            return 1
        fi
    done
}
_mission_check
