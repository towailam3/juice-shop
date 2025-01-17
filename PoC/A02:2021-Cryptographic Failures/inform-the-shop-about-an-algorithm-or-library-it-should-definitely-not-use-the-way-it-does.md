I tried logging in as a normal user https://juice.8-thousander.me/#/login

After some browsing, I logged out of the website.

At the moment when I log off, I found a request to the saveLoginIp api

```
curl 'https://juice.8-thousander.me/rest/saveLoginIp' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-HK,en;q=0.9,zh-HK;q=0.8,zh;q=0.7,en-GB;q=0.6,en-US;q=0.5' \
  -H 'authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MjEsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJ0b3dhaWxhbTNAanVpY2Utc2gub3AiLCJwYXNzd29yZCI6IjgxOWI0YzBkY2VjMWVjMWVhZWVlYTA0OGE4N2Y5ZjViIiwicm9sZSI6ImN1c3RvbWVyIiwiZGVsdXhlVG9rZW4iOiIiLCJsYXN0TG9naW5JcCI6InVuZGVmaW5lZCIsInByb2ZpbGVJbWFnZSI6Ii9hc3NldHMvcHVibGljL2ltYWdlcy91cGxvYWRzL2RlZmF1bHQuc3ZnIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIzLTAzLTE4IDEzOjAwOjQwLjI0MyArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDIzLTAzLTE4IDEzOjQwOjQ3LjQ0MiArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE2NzkxNDc0NjYsImV4cCI6MTY3OTE2NTQ2Nn0.ud7wSivSFqVMYaIXKEQK-KahkEZO2_GLe9O2_Pu-q-X4Z0Dh6_WMGpyvcX8kOvLeMV4T-ET7c8OmLTWrO_5Nb7GfnA12Cee0RkwQTPAXC1a7ZWvx1Z3Q3IEhRLHZ-MOUrvxBbDHeoCcjhWvegzLHTGsVuhJbZGhNulmsYJHdroA' \
  -H 'cookie: cookieconsent_status=dismiss; language=en; welcomebanner_status=dismiss; continueCode=lLrP7weLvQboX2p1gO354xyjdRjT9iK8f2edNl8K9mnRzD6qMaWVBJkEZYoO' \
  -H 'dnt: 1' \
  -H 'if-none-match: W/"15c-0fOuQBWERuN69JI6j7y+5S5MAhI"' \
  -H 'referer: https://juice.8-thousander.me/' \
  -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
  -H 'x-user-email: towailam3@juice-sh.op' \
  --compressed
```

The request returned a payload with information of the logged off session. 

```
{
    "id": 21,
    "username": "",
    "email": "towailam3@juice-sh.op",
    "password": "819b4c0dcec1ec1eaeeea048a87f9f5b",
    "role": "customer",
    "deluxeToken": "",
    "lastLoginIp": "undefined",
    "profileImage": "/assets/public/images/uploads/default.svg",
    "totpSecret": "",
    "isActive": true,
    "createdAt": "2023-03-18T13:00:40.243Z",
    "updatedAt": "2023-03-18T13:40:47.442Z",
    "deletedAt": null
}
```

I notice there is a password hash "819b4c0dcec1ec1eaeeea048a87f9f5b" included in the payload, I wonder what hash algorithm it was used. I decided to use different hash algorithms to hash my own password 'towailam3@juice-sh.op' (I used the same string for username and password). 


```
#!/bin/sh

for hash in sha1sum sha224sum sha256sum sha384sum sha512sum shasum md5sum; do
    echo -n 'towailam3@juice-sh.op' | $hash | grep 819b4c0dcec1ec1eaeeea048a87f9f5b && echo $hash
done
```

The result shows that md5, a broken hash algorithm, was used. 

```
819b4c0dcec1ec1eaeeea048a87f9f5b  -
md5sum
```

I informed the juice shop customer service about this vulnerability and the challenge is resolved. 
