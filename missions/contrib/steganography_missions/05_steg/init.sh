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
  # Select random name and passphrase
    NAMES_FILE="$MISSION_DIR/data/names.txt"
    PHRASES_FILE="$MISSION_DIR/data/phrases.txt"
    RANDOM_NAME=$(shuf -n 1 "$NAMES_FILE")
    RANDOM_PHRASE=$(shuf -n 1 "$PHRASES_FILE")

  # Save for checking later
    echo "$RANDOM_NAME" > "$GSH_TMP/traitor_name.txt"
    echo "$RANDOM_PHRASE" > "$GSH_TMP/passphrase.txt"
  
  # Create the cryptic note with hex-encoded passphrase hint
    CRYPTIC_NOTE="$(eval_gettext '$GSH_HOME/Castle/Throne_room/Safe/cryptic_note.txt')"
    sed "s/PASSPHRASE/$RANDOM_PHRASE/" "$MISSION_DIR/data/quest_message.txt" > "$CRYPTIC_NOTE"
    chmod 000 "$CRYPTIC_NOTE"

    # Copy all paintings to throne room
    THRONE_ROOM="$(eval_gettext '$GSH_HOME/Castle/Throne_room')"
    cp "$MISSION_DIR/ascii-art/painting1.jpg" "$THRONE_ROOM/scene_as28e.jpg"
    cp "$MISSION_DIR/ascii-art/painting2.jpg" "$THRONE_ROOM/scene_926a2.jpg"
    cp "$MISSION_DIR/ascii-art/painting3.jpg" "$THRONE_ROOM/scene_1a7b7.jpg"
    cp "$MISSION_DIR/ascii-art/painting4.jpg" "$THRONE_ROOM/scene_t7g1e.jpg"

    # Convert passphrase to hex
    HEX_PHRASE=$(echo -n "$RANDOM_PHRASE" | xxd -p)
    
    # Hide base64 message in random painting (painting2)
    steghide embed -cf "$THRONE_ROOM/scene_926a2.jpg" -ef "$GSH_TMP/secret_message.txt" -p "$HEX_PHRASE" -q

  }
_mission_init