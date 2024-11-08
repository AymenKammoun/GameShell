_gsh_api_get_session() {
    local SESSION_ID=$1
    local STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$GSH_API_URL/sessions/$SESSION_ID")
     if [ "$STATUS_CODE" -eq 200 ]; then
        session=$(curl -s "$GSH_API_URL/sessions/$SESSION_ID")
        echo
    else
        echo "API request failed with status code: $STATUS_CODE"
        return 1
    fi
}

_gsh_api_get_rooms() {
    local SESSION_ID=$1
    local array=$(curl -s "$GSH_API_URL/sessions/$SESSION_ID"|jq '.rooms[].name')
    echo "$array"|sed 's/"//g' && printf '\0'
}

_gsh_api_create_player() {
    local SESSION_ID=$1
    local ROOM=$2
    local PLAYER=$3

    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X 'POST' -H 'Content-Type: application/json' -d "{\"name\": \"$PLAYER\", \"missions_passed\": 1}" "$GSH_API_URL/sessions/$SESSION_ID/rooms/$ROOM/players")
    if [ "$STATUS_CODE" -eq 200 ]; then
        echo
    else
        echo "API request failed with status code: $STATUS_CODE"
        return 1
    fi
}

_gsh_api_update_player() {
    local PASSPORT=$1
    local MISSION_NB=$2
    
    # Read the first word of the first three lines and store them in variables
    NOM=$(sed -n '1p' "$PASSPORT" | awk '{print $1}')
    SESSION_ID=$(sed -n '2p' "$PASSPORT" | awk '{print $1}')
    ROOM=$(sed -n '3p' "$PASSPORT" | awk '{print $1}')

    local STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X 'PATCH' "$GSH_API_URL/sessions/$SESSION_ID/rooms/$ROOM/players/$NOM" \
        -H 'accept: application/json' \
        -H 'Content-Type: application/json' \
        -d "{\"name\":\"$NOM\", \"missions_passed\": $MISSION_NB}")
    if [ "$STATUS_CODE" -eq 200 ]; then
        echo
    else
        echo "API request failed with status code: $STATUS_CODE"
        return 1
    fi
}