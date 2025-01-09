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
    # Vérifie si un choix a été fait
    if [ ! -f "$GSH_TMP/specialization_choice" ]; then
        echo "$(gettext "You need to make a choice first! Use 'gsh choose NUMBER'")"
        return 1
    }

    # Lit le choix
    CHOICE=$(cat "$GSH_TMP/specialization_choice")

    # Vérifie si le choix est valide
    case $CHOICE in
        1|2|3|4)
            # Applique le choix
            case $CHOICE in
                1) 
                    cp "$GSH_ROOT/missions/index_cyber.txt" "$GSH_CONFIG/index.txt"
                    echo "$(gettext "You have chosen the Cybersecurity path!")"
                    ;;
                2)
                    cp "$GSH_ROOT/missions/index_iot.txt" "$GSH_CONFIG/index.txt"
                    echo "$(gettext "You have chosen the IoT path!")"
                    ;;
                3)
                    cp "$GSH_ROOT/missions/index_pnum.txt" "$GSH_CONFIG/index.txt"
                    echo "$(gettext "You have chosen the Cloud path!")"
                    ;;
                4)
                    echo "$(gettext "You have chosen to continue with all missions!")"
                    ;;
            esac
            return 0
            ;;
        *)
            echo "$(gettext "Invalid choice! Please use 'gsh choose' with a number between 1 and 4")"
            return 1
            ;;
    esac
}
_mission_check