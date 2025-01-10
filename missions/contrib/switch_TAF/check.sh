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

#!/usr/bin/env sh

_mission_check() {
    # Vérifier si un choix a été fait
    if [ ! -f "$GSH_CONFIG/specialization/choice" ]; then
        return 1
    fi

    local choice=$(cat "$GSH_CONFIG/specialization/choice")

    # Modifier l'index des missions selon le choix
    case $choice in
        1) # Cyber
            head -n "$MISSION_NB" "$GSH_CONFIG/index.txt" > "$GSH_CONFIG/new_index.txt"
            cat "$GSH_MISSIONS/index_cyber.txt" >> "$GSH_CONFIG/new_index.txt"
            ;;
        2) # IoT
            head -n "$MISSION_NB" "$GSH_CONFIG/index.txt" > "$GSH_CONFIG/new_index.txt"
            cat "$GSH_MISSIONS/index_iot.txt" >> "$GSH_CONFIG/new_index.txt"
            ;;
        3) # Cloud
            head -n "$MISSION_NB" "$GSH_CONFIG/index.txt" > "$GSH_CONFIG/new_index.txt"
            cat "$GSH_MISSIONS/index_pnum.txt" >> "$GSH_CONFIG/new_index.txt"
            ;;
        4) # Default
            # Garder l'index original
            cp "$GSH_CONFIG/suite_missions_index.txt" "$GSH_CONFIG/new_index.txt"
            ;;
    esac

    mv "$GSH_CONFIG/new_index.txt" "$GSH_CONFIG/index.txt"
    return 0
}

_mission_check