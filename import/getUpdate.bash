declare -A arr_json

jq_all_vars(){ :
      jq -r '.|{
          update_id: .update_id,
          message_id: .message.message_id,
          date: .message.date,
          forward_date: .message.forward_date,
          text: .message.text,
          forward_sender_name: .message.forward_sender_name,
          from_id: .message.from.id,
          from_username: .message.from.username,
          chat_id: .message.chat.id,
          chat_username: .message.chat.username,
          forward_from_id: .message.forward_from.id,
          forward_from_username: .message.forward_from.username}|
              to_entries|
              map("\(.key)=\(.value|tostring)")|
              .[]'
}

arr_gen(){ :
      while IFS='=' read -r key value; do
          arr_json[$key]="$value"
      done
}

enum_update_id(){ :
    while IFS= read -r line; do
        arr_gen < <(<<< "$line" jq_all_vars)
        handler &
    done

}

gen_data(){ :
cat <<EOF
{
    "offset": $((arr_json[update_id] + 1)),
    "limit": 0
}
EOF
}

GetUpdate(){ :
    # shellcheck disable=SC2034
    METOD=GetUpdates
    arr_gen < <(curl_api "gen_data")
    check_curl || return
    # Разбор result... [ update_id, message, inline_query, chosen_inline_result, callback_query ]
    enum_update_id < <(<<< "${arr_json[result]}" jq -c '.[]')
}
