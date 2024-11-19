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
    
    goodPassHash="9a279ab8e168b25c248b7aab93080304cd29712b46ac4f6e78e99328d66efe3a"
    read -p "Enter your password guess: " userPass
    usePassHash=$(echo -n "$userPass" | openssl dgst -sha256 | awk '{print $2}')
    if [ -z "$userPass" ]; then
        echo "$(gettext "Please enter a guess!")"
        return 1
    fi
    
    if [ "$usePassHash" = "$goodPassHash" ]; then
        return 0
    else
        echo "$(gettext "That's not the correct password!")"
        return 1
    fi
    return 0
}
_mission_check
