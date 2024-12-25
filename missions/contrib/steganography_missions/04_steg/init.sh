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
_mission_init() {

    # Copier l'image source
    cp "$MISSION_DIR/ascii-art/painting1.jpg" "$GSH_TMP/castle_image.jpg"

    # Copier l'image avec une extension trompeuse
    cp "$GSH_TMP/castle_image.jpg" "$(eval_gettext '$GSH_HOME/Castle/Main_building/Throne_room/Safe/Your_Highness.pdf')" 
    
}
_mission_init
