#shellcheck disable=2154
#shellcheck disable=2034

handler(){ :
set -x
    access="111111111
            666666666
            555555555"

    IFS=' ' read -r var1 var2 <<< "${arr_json[text]}"
    case $var1 in
        /count)
            if grep -q "${arr_json[from_id]}" <<< "$access" ; then
                f_count
            fi ;;
            *) echo other command "${arr_json[text]}"
    esac
        # ответ(curl) + логирование
set +x
}

f_count(){ :
    echo "${var2// */}"
    METOD="sendMessage"
    for ((i=1;i<=${var2// */};i++)); do
# set -x
        arr_gen < <(curl_api "gen_data_count")
        check_curl || curl_api "gen_data_count"
# set +x
    done
}

gen_data_count(){ :
cat <<EOF
{
    "chat_id": "${arr_json[chat_id]}",
    "text": "$i",
    "disable_notification": true,
    "protect_content": false,
    "parse_mode": "MarkdownV2",
    "reply_markup": {"remove_keyboard": true},
    "reply_to_message_id": "${arr_json[message_id]}"
}
EOF
}

# handler(){ :
#     set -x
#     : "ok = ${arr_json[ok]}"
#     : "update_id = ${arr_json[update_id]}"
#     : "message_id = ${arr_json[message_id]}"
#     : "date = ${arr_json[date]}"
#     : "text = ${arr_json[text]}"
#     : "forward_sender_name = ${arr_json[forward_sender_name]}"
#     : "forward_date = ${arr_json[forward_date]}"
#     : "from_id = ${arr_json[from_id]}"
#     : "from_username = ${arr_json[from_username]}"
#     : "chat_id = ${arr_json[chat_id]}"
#     : "chat_username = ${arr_json[chat_username]}"
#     : "forward_from_id = ${arr_json[forward_from_id]}"
#     : "forward_from_username = ${arr_json[forward_from_username]}"
#     : -------------------------------------------------------------
#     set +x
# }
