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
    passPhrase=$(cat "$GSH_TMP/passphrase.txt")
    read -p "Whats the passphrase " userGuess
    if [[ $userGuess == $passPhrase ]]; then
        echo "Good job!"
        return 0
    else
        echo "Wrong answer!"
        return 1
    fi
}
_mission_check
