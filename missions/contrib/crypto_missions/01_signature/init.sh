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

    # Create good RSA keys
    mkdir $MISSION_DIR/data/
    mkdir $MISSION_DIR/data/good_keys
    openssl genrsa -out $MISSION_DIR/data/good_keys/private.pem 4096
    openssl rsa -in $MISSION_DIR/data/good_keys/private.pem -pubout -out $MISSION_DIR/data/good_keys/public.pem

    # Create bad RSA keys
    mkdir $MISSION_DIR/data/bad_keys
    openssl genrsa -out $MISSION_DIR/data/bad_keys/private.pem 4096
    openssl rsa -in $MISSION_DIR/data/bad_keys/private.pem -pubout -out $MISSION_DIR/data/bad_keys/public.pem

    #Creating 5 letters
    for i in {1..5}
    do
      echo "This is lettre $i" > $GSH_HOME/Castle/Main_building/Mail_box/unsorted/lettre$i.txt
    done

    GOOD_LETTRE_INDEX=$((1 + $RANDOM % 5))
    echo "The good index is $GOOD_LETTRE_INDEX"
    for i in {1..5}
    do
      
      if [[ $i -eq $GOOD_LETTRE_INDEX ]]
      then
        KEY_PATH=$MISSION_DIR/data/good_keys/private.pem
      else
        KEY_PATH=$MISSION_DIR/data/bad_keys/private.pem
      fi
      openssl dgst -sha256 -sign $KEY_PATH -out $GSH_HOME/Castle/Main_building/Mail_box/unsorted/lettre$(eval_gettext '$i')_sign.sha256.bin $GSH_HOME/Castle/Main_building/Mail_box/unsorted/lettre$i.txt
      openssl base64 -in $GSH_HOME/Castle/Main_building/Mail_box/unsorted/lettre$(eval_gettext '$i')_sign.sha256.bin -out $GSH_HOME/Castle/Main_building/Mail_box/unsorted/lettre$(eval_gettext '$i')_sign.sha256
      rm $GSH_HOME/Castle/Main_building/Mail_box/unsorted/lettre$(eval_gettext '$i')_sign.sha256.bin
    done

    #Copy the good public key for signature verification
    cp $MISSION_DIR/data/good_keys/public.pem $GSH_HOME/Castle/Main_building/Mail_box/unsorted/public.pem

    #Delete the data repo
    rm -r $MISSION_DIR/data
    # Select random name from list
    #NAMES_FILE="$MISSION_DIR/data/names.txt"
    #RANDOM_NAME=$(shuf -n 1 "$NAMES_FILE")
    
    # Save the name for checking later
    #echo "$RANDOM_NAME" > "$GSH_TMP/traitor_name.txt"
    
    # Create temporary message file
    #echo "The traitor's name is: $RANDOM_NAME" > "$GSH_TMP/secret_message.txt"
    
    # Copy base image to throne room
    #cp "$MISSION_DIR/ascii-art/king-portrait.jpg" "$(eval_gettext '$GSH_HOME/Castle/Throne_room/mysterious_painting.jpg')"
    
    # Hide message in image (empty passphrase for simplicity)
    #steghide embed -cf "$(eval_gettext '$GSH_HOME/Castle/Throne_room/mysterious_painting.jpg')" -ef "$GSH_TMP/secret_message.txt" -p "Tra1t0r" -q
}
_mission_init