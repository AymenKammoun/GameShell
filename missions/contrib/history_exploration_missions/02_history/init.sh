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
#!/usr/bin/env sh

_mission_init() {
    # Select random medieval password
    PASSWORDS_FILE="$MISSION_DIR/data/passwords.txt"
    RANDOM_PASSWORD=$(shuf -n 1 "$PASSWORDS_FILE")
    # Save the password for checking later
    echo "$RANDOM_PASSWORD" > "$GSH_TMP/exposed_password.txt"

# Create a function to add to HISTFILE
    add_to_history() {
        HISTFILE="$HOME/.bashrc"
        set -o history
        history -s "ls -la"
        history -s "cd Castle"
        history -s "pwd"
        history -s "ls -l Documents"
        history -s "cd Main_building"
        history -s "clear"
        history -s "ls -la Guards/"
        history -s "pwd"
        history -s "cat guard_duties.txt"
        history -s "cd ../Kitchen"
        history -s "ls"
        history -s "clear"
        history -s "whoami"
        history -s "sudo -s"
        history -s "su -"
        history -s "$RANDOM_PASSWORD"
        history -s "clear"
        history -s "cd .."
        history -s "ls -R"
        history -s "clear"
        history -s "cd Treasury"
        history -s "ls -la"
        history -s "date"
        history -s "cd ../Armory"
        history -s "ls weapons.txt"
        history -s "cat training_schedule.txt"
        history -s "cd .."
        history -s "grep \"patrol\" guard_duties.txt"
        history -s "clear"
        history -s "man ls"
        history -s "cd Documents"
        history -s "touch report.txt"
        history -s "vim report.txt"
        history -s "cd ../Library"
        history -s "ls -l books/"
        history -s "cat ancient_scrolls.txt"
        history -s "clear"
    }

    # Execute the function
    add_to_history
}
_mission_init