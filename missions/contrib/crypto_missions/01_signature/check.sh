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
    for i in {1..5}
    do
        if [[ $i -eq $GOOD_LETTRE_INDEX ]]
        then
            if [ ! -e "$GSH_HOME/Castle/Main_building/Mail_box/genuine/lettre$i.txt" ]; then
                echo "The good lettre is not in the genuine directory"
                return 0
            fi
        else
            if [ ! -e "$GSH_HOME/Castle/Main_building/Mail_box/genuine/lettre$i.txt" ]; then
                echo "A bad lettre is not in the fake directory"
                return 0
            fi
        fi
    done
    return 1
}
_mission_check
