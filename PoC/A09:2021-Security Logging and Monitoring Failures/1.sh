curl -i -s -k -X 'GET' \
    -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/111.0' \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'Accept-Language: en-GB,en;q=0.5' \
    -H 'Connection: keep-alive' \
    -H 'Referer: https://juice.8-thousander.me/' \
    -H 'Cookie: language=en' \
    -H 'Sec-Fetch-Dest: empty' \
    -H 'Sec-Fetch-Mode: cors' \
    -H 'Sec-Fetch-Site: same-origin' \
    'https://juice.8-thousander.me/rest/products/search?q=%27%28'
