#!/bin/sh

for hash in sha1sum sha224sum sha256sum sha384sum sha512sum shasum md5sum; do
    echo "$hash $(echo 'towailam3@juice-sh.op' | $hash)"
done
