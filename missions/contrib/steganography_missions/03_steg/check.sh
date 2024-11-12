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
    SAFE_PATH="$(eval_gettext '$GSH_HOME/Castle/Throne_room/Safe')"
    REVEALED_FILE="$SAFE_PATH/revealed.txt"
    CORRECT_NAME=$(cat "$GSH_TMP/traitor_name.txt")
    
    # Check if revealed.txt exists
    if [ ! -f "$REVEALED_FILE" ]; then
        echo "$(gettext "The revealed.txt file is missing from the safe!")"
        return 1
    }
    
    # Read and clean the content (remove spaces, newlines)
    REVEALED_CONTENT=$(tr -d '[:space:]' < "$REVEALED_FILE")
    CORRECT_CONTENT=$(echo "The traitor among the court is: $CORRECT_NAME" | tr -d '[:space:]')
    
    if [ "$REVEALED_CONTENT" = "$CORRECT_CONTENT" ]; then
        return 0
    else
        echo "$(gettext "The content of revealed.txt is incorrect. Did you decode the message properly?")"
        return 1
    fi
}
_mission_check
