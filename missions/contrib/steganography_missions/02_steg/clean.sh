#!/usr/bin/env sh

# This file is not required. When it exists, it is used to clean the mission,
# for example on completion, or when restarting it.
# In some rare case, cleaning is different after a successful check. You can
# inspect the variable $GSH_LAST_ACTION, which can take the following values:
# assert, check_false, check_true, exit, goto, hard_reset, reset, skip
# If you need this file, rename it to clean.sh
rm -f "$GSH_TMP/traitor_name.txt"
rm -f "$GSH_TMP/passphrase.txt"
rm -f "$GSH_TMP/secret_message.txt"
rm -f "$GSH_HOME/Castle/Main_building/Throne_room/Safe/secret_note.txt"
rm -f "$GSH_HOME/Castle/Main_building/Throne_room/king_portait.jpg"
rm -f "$GSH_HOME/Castle/Main_building/Throne_room/secret_message.txt"