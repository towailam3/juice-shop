#!/bin/sh

for hash in sha1sum sha224sum sha256sum sha384sum sha512sum shasum md5sum; do
    echo -n 'towailam3@juice-sh.op' | $hash | grep 819b4c0dcec1ec1eaeeea048a87f9f5b && echo $hash
done
