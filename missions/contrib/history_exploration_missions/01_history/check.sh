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

    printf "$(gettext "What password was exposed in the command history? ")"
    read -r answer

    if [ "$answer" = "$CORRECT_PASSWORD" ]; then
        printf "$(gettext "Where was this password typed? After which command? ")"
        read -r context

        if echo "$context" | grep -qi "su\|sudo"; then
            echo "$(gettext "Correct! Never type passwords directly in the command line as they will be stored in history!")"
            return 0
        else
            echo "$(gettext "That's not the correct context. Look at what command was used before the password.")"
            return 1
        fi
    else
        echo "$(gettext "That's not the password that was exposed. Check the history carefully!")"
        return 1
    fi
}
_mission_check
