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
    # Check if the player has extracted the files
    printf "$(gettext "What will happen during the next full moon? ")"
    read -r answer

    if echo "$answer" | grep -qi "mercenaries.*attack.*forest.*passage"; then
        return 0
    else
        echo "$(gettext "That's not what the evidence reveals. Read the extracted documents carefully!")"
        return 1
    fi
}
_mission_check
