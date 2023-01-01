#!/usr/bin/env bash

# shellcheck source=/dev/null
# shellcheck disable=SC2154
# shellcheck disable=SC2034

: "обьявление переменных"
TOKEN=XXXXXXXXXX:YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY

err_file="./logs/err.log"



: " curl "
source ./import/curl.bash

: "результат ассоциативный масив ${arr_json[chat_username]}"
source ./import/getUpdate.bash

: "обработчик текста отправленого боту, вызывается из main.bash"
source ./import/handler.bash

while true; do
    GetUpdate
    read -r
done
