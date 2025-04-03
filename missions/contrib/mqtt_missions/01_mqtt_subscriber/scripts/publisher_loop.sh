#!/bin/bash
passPhrase=$(< /dev/urandom tr -dc 'a-z' | head -c 5)
touch "$GSH_TMP/passphrase.txt"
echo -n "$passPhrase" > "$GSH_TMP/passphrase.txt"
while true; do
    mosquitto_pub -h localhost -t GameShell/important_topic -m "The passphrase is $passPhrase"
    sleep 5
done