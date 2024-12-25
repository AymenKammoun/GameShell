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
    # Créer le message secret dans les métadonnées
    SECRET_MESSAGE="Enemy troops will attack from the North Gate. -Agent X"

    # Copier l'image source
    cp "$MISSION_DIR/ascii-art/kingdom_map.png" "$GSH_TMP/kingdom_map.png"

    # Ajouter le message secret dans les métadonnées
    exiftool -Comment="$SECRET_MESSAGE" "$GSH_TMP/kingdom_map.png"

    # Copier l'image avec une extension trompeuse
    cp "$GSH_TMP/kingdom_map.png" "$(eval_gettext '$GSH_HOME/Castle/Main_building/Throne_room/Safe/report.txt')"
}
_mission_init
