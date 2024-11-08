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
    PHRASES_FILE="$MISSION_DIR/data/passphrases.txt"
    RANDOM_NAME=$(shuf -n 1 "$NAMES_FILE")
    RANDOM_PHRASE=$(shuf -n 1 "$PHRASES_FILE")
    
    # Save the name and passphrase for checking later
    echo "$RANDOM_NAME" > "$GSH_TMP/traitor_name.txt"
    echo "$RANDOM_PHRASE" > "$GSH_TMP/passphrase.txt"
    
    # Create secret message
    echo "The second traitor's name is: $RANDOM_NAME" > "$GSH_TMP/secret_message.txt"
    
    # Create protected note with passphrase in the safe
    NOTE_PATH="$(eval_gettext '$GSH_HOME/Castle/Throne_room/Safe/secret_note.txt')"
    echo "Passphrase for the painting: $RANDOM_PHRASE" > "$NOTE_PATH"
    # Remove read permissions
    chmod 000 "$NOTE_PATH"
    
    # Copy new painting to throne room
    PAINTING_PATH="$(eval_gettext '$GSH_HOME/Castle/Throne_room/king_portait.jpg')"
    cp "$MISSION_DIR/ascii-art/painting.jpg" "$PAINTING_PATH"
    
    # Hide message in image with passphrase
    steghide embed -cf "$PAINTING_PATH" -ef "$GSH_TMP/secret_message.txt" -p "$RANDOM_PHRASE" -q
}
_mission_init