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

  parchment=$(eval_gettext '$GSH_HOME/Castle/Main_building/Library/Merlin_s_office/Drawer')/$(gettext "parchment")
  cat $MISSION_DIR/ascii-art/parchment.txt > $parchment

  # Get a random 4 digits number
  k=$(printf "%04d" "$(($(RANDOM) % 10000))")
  echo $k > "$GSH_TMP/digits.txt"

  # Get the messages for the server
  m1="$(gettext "Thank you for connecting! Do you wish to enter? [Y/n]")"
  m2="$(gettext "Goodbye!")"

  # run the server at 127.0.0.1:8585
  python3 $MISSION_DIR/data/script_server <(sed "s/KEY7/$k/" "$MISSION_DIR/ascii-art/potions.txt") "$m1" "$m2" >/dev/null &
}
_mission_init

_mission_init() {
    # Select random name from list
    NAMES_FILE="$MISSION_DIR/data/names.txt"
    RANDOM_NAME=$(shuf -n 1 "$NAMES_FILE")
    
    # Save the name for checking later
    echo "$RANDOM_NAME" > "$GSH_TMP/traitor_name.txt"
    
    # Create temporary message file
    echo "The traitor's name is: $RANDOM_NAME" > "$GSH_TMP/secret_message.txt"
    
    # Copy base image to throne room
    cp "$MISSION_DIR/ascii-art/king-portrait.jpg" "$(eval_gettext '$GSH_HOME/Castle/Throne_room/mysterious_painting.jpg')"
    
    # Hide message in image (empty passphrase for simplicity)
    steghide embed -cf "$(eval_gettext '$GSH_HOME/Castle/Throne_room/mysterious_painting.jpg')" -ef "$GSH_TMP/secret_message.txt" -p "Tra1t0r" -q
}
_mission_init