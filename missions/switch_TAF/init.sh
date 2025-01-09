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
    # Crée le répertoire bin s'il n'existe pas
    mkdir -p "$GSH_BIN"

    # Crée la commande gsh choose
    cat > "$GSH_BIN/choose" << 'EOF'
#!/usr/bin/env sh
if [ $# -ne 1 ]; then
    echo "Usage: gsh choose NUMBER (1-4)"
    exit 1
fi

case $1 in
    1|2|3|4)
        echo "$1" > "$GSH_TMP/specialization_choice"
        echo "Choice registered! Use 'gsh check' to confirm."
        ;;
    *)
        echo "Invalid choice! Please use a number between 1 and 4"
        exit 1
        ;;
esac
EOF

    # Rend la commande exécutable
    chmod +x "$GSH_BIN/choose"
}
_mission_init