#!/bin/sh
grep '^LIBKCAPI_.*{' $1 | tail -1 | sed -e 's!^LIBKCAPI_!!' -e 's![ \t].*{$!!'
