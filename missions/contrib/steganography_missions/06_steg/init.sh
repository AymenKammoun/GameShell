#!/usr/bin/env sh

# This file is not required: it is sourced every time the mission is started.
# Since it is sourced every time the mission is restarted, it can generate
# random data to make each run slightly different.
#
# Since it is sourced, it may define environment variables if you really need
# them, but it should "unset" any local variable it has created.
#
# Note however that should the mission be initialized in a subshell, those
# environment variables will disappear! That typically happens a mission is
# checked using process redirection, as in
#   $ SOMETHING | gsh check
# To mitigate the problem, GameShell will display a message asking the player
# to run
#   $ gsh reset
# in that case.
#
# It typically looks like
# init.sh
_mission_init() {
    # Create a secret message
    echo "My dear King, I have discovered a plot against the kingdom. The details are in the attached scroll." > "$GSH_TMP/secret_letter.txt"

    # Create a fake scroll with evidence
    echo "The mercenaries will attack through the forest passage during the next full moon." > "$GSH_TMP/scroll.txt"

    # Combine files into the map image
    cp "$MISSION_DIR/ascii-art/kingdom_map.jpg" "$GSH_TMP/base_map.jpg"
    zip -j -q "$GSH_TMP/secret_docs.zip" "$GSH_TMP/secret_letter.txt" "$GSH_TMP/scroll.txt"

    cat "$GSH_TMP/base_map.jpg" "$GSH_TMP/secret_docs.zip" > "$(eval_gettext '$GSH_HOME/Castle/Main_building/Library/Cartographer_room/mysterious_map.jpg')"
}
_mission_init