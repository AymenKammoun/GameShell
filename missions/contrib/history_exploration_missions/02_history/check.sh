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
    CORRECT_PASSWORD=$(cat "$GSH_TMP/exposed_password.txt")

    pif history | grep -q "$CORRECT_PASSWORD"; then
        echo "$(gettext "The sensitive password command is still in your history! Remove it for security.")"
        return 1
    else
        # Verify user knows how to check history
        printf "$(gettext "What command do you use to view your command history? ")"
        read -r answer

        if echo "$answer" | grep -q "^history$"; then
            return 0
        else
            echo "$(gettext "That's not the correct command to view history.")"
            return 1
        fi
    fi
}
_mission_check
