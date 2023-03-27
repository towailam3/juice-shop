this challenge requires me to login as site admin without obtaining the admin's password. 

i first go to the the main website https://juice.8-thousander.me/#/ and browsed the apple juice item. 

in review section of the item, i noice a review made by a user admin@juice-sh.op

based on the username and domain name of the email address, it is quite possible the review was made by the site admin. 

so i leveraged the opportunity to perform a sql injection attack. 

i browsed to the login ui https://juice.8-thousander.me/#/login

then i used admin@juice-sh.op'-- as username, and some artibtrary string as password. 

the special sequence '-- will end the query the interpretation in the sql engine, bypassing rest of the filtering conditions, resulting in a query that is always success. 

this is the api request extracted from browser developer tool

this is the response from the query