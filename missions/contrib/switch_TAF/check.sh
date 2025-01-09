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

    while true; do
        printf "\n$(gettext "Enter your choice (1-4): ")"
        read -r choice

        case $choice in
            1|2|3|4)
                # Sauvegarder le choix pour start.sh
                echo "$choice" > "$GSH_TMP/specialization_choice"

                # Feedback visuel
                echo "\n$(gettext "==================================")"
                case $choice in
                    1) 
                        echo "$(gettext "🔒 Welcome to the Cybersecurity path!")"
                        echo "$(gettext "Your journey into security begins...")"
                        ;;
                    2)
                        echo "$(gettext "🔌 Welcome to the IoT path!")"
                        echo "$(gettext "Your connected adventure starts...")"
                        ;;
                    3)
                        echo "$(gettext "☁️  Welcome to the Cloud path!")"
                        echo "$(gettext "Your cloud journey begins...")"
                        ;;
                    4)
                        echo "$(gettext "🎯 Welcome to the Complete Journey!")"
                        echo "$(gettext "Your full Unix mastery awaits...")"
                        ;;
                esac
                echo "$(gettext "==================================")"
                return 0
                ;;
            "")
                echo "$(gettext "Please enter a number (1-4)")"
                ;;
            *)
                echo "$(gettext "Invalid choice! Please enter a number between 1-4")"
                ;;
        esac
    done
}
_mission_check