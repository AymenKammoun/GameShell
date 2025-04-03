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
    n=$(cat "$GSH_TMP/challenge.txt")
    if [ ! -e "$GSH_HOME/Castle/Cave/key.bin.hex" ]; then
        echo "key.bin.hex must be created in the Cave!"
        return 1
    fi
    if [ ! -e "$GSH_HOME/Castle/Cave/iv.bin.hex" ]; then
        echo "iv.bin.hex must be created in the Cave!"
        return 1
    fi
    if [ ! -e "$GSH_HOME/Castle/Cave/ciphered_result.bin" ]; then
        echo "ciphered_result.bin must be created in the Cave!"
        return 1
    fi
    openssl enc -aes-128-cbc -d -in "$GSH_HOME/Castle/Cave/ciphered_result.bin" -out "$GSH_TMP/result.txt" -K $(cat "$GSH_HOME/Castle/Cave/key.bin.hex") -iv $(cat "$GSH_HOME/Castle/Cave/iv.bin.hex") || return 1
    result=$(cat "$GSH_TMP/result.txt")
    echo "[Debug] The result=$result"
    if [[ "$(($n*2))" -eq "$result" ]]; then
        echo "Idendity verified!"
        return 0
    fi
    echo "Wrong answer!"
    return 1
}
_mission_check
