#!/usr/bin/env sh

# This file is not required: it is sourced once when initialising a GameShell
# game, and whenever the corresponding missions is (re)started.
# It typically creates the parts of the mission that will be available during
# the whole game, like the directory structure.
#
# Since it is sourced, it may define environment variables if you really need
# them, but it should "unset" any local variable it has created.
# Ensure throne room and safe exist
mkdir -p "$(eval_gettext '$GSH_HOME/Castle/Throne_room/Safe')"