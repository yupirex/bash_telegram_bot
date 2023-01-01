#!/usr/bin/bash
# shellcheck disable=SC2154

curl_api(){ :
    log_file="$(date +%F)_curl.log"
    curl -ss \
        --request POST \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --data "$($1)" \
        "https://api.telegram.org/bot${TOKEN}/${METOD}" |
            { sed 's/\\n/\\\\n/g'; echo; }              |
            tee -a "$log_file"                          |
            jq_string
    sleep 1
}

jq_string(){
    jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]'
}

check_curl(){ :
    if ${arr_json[ok]} ; then
        return 0
    else
        case ${arr_json[error_code]} in
            400) return 1 ;; #empty string
            404) return 1 ;; #not found
            429) sleep "$(jq -c '.retry_after' <<< "${arr_json[parameters]}")"
                 return 1 ;;
            *) echo "${arr_json[error_code]}" ;;
        esac
    fi
}
