there is no challenges in juice shop web application that is designed to demonstrate a09 security logging and monitoring failures, probably because lack of logging is usually an operational shortcoming.

however, when i was scanning the juice shop web app with owasp zap, one partciular alert pops up. 

```
curl -i -s -k -X  'GET'  \
 -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/111.0'  -H 'Accept: application/json, text/plain, */*'  -H 'Accept-Language: en-US,en;q=0.5'  -H 'Connection: keep-alive'  -H 'Referer: https://juice.8-thousander.me/'  -H 'Sec-Fetch-Dest: empty'  -H 'Sec-Fetch-Mode: cors'  -H 'Sec-Fetch-Site: same-origin'  -H ''  \
'https://juice.8-thousander.me/rest/products/search?q=%27%28'
```

the alert is related to a sql injection vulnerability. here is the output of that request. 

apparaently, even without the sql injection, the response is a violation of CWE-532 https://cwe.mitre.org/data/definitions/532.html, which is a CWS mapped to A09:2021 Security Logging and Monitoring Failures, as the error message exposed the table information of the underlying rdbms and the query logic, which attacker can leverage to craft more sophisticated attack. 