#!/bin/bash

BINDIR="${MESON_INSTALL_DESTDIR_PREFIX}/${1}/"
LIBDIR="${MESON_INSTALL_DESTDIR_PREFIX}/${2}/"
OLDDIR="$PWD"

if [ -f "$LIBDIR/libkcapi.so.$3" ]; then
  cd "$LIBDIR"
  major_ver="`echo $3 | sed -e 's!\..*$!!g'`"

  echo "Generating hmac / fipscheck file for libkcapi.so.$3."
  "$4" sha256 -hmac orboDeJITITejsirpADONivirpUkvarP libkcapi.so.$3 > .libkcapi.so.$3.hmac

  for link in .$major_ver ""; do
    echo "Linking hmac / fipscheck file for libkcapi.so$link."
    "$5" -f .libkcapi.so.$3.hmac .libkcapi.so$link.hmac
  done
fi

if [ -f "$LIBDIR/libkcapi_apps.so.$3" ]; then
  cd "$LIBDIR"
  major_ver="`echo $3 | sed -e 's!\..*$!!g'`"

  echo "Generating hmac / fipscheck file for libkcapi_apps.so.$3."
  "$4" sha256 -hmac orboDeJITITejsirpADONivirpUkvarP libkcapi_apps.so.$3 > .libkcapi_apps.so.$3.hmac

  for link in .$major_ver ""; do
    echo "Linking hmac / fipscheck file for libkcapi_apps.so$link."
    "$5" -f .libkcapi_apps.so.$3.hmac .libkcapi_apps.so$link.hmac
  done
fi

if [ -f "$BINDIR/kcapi-hasher" ]; then
  cd "$BINDIR"

  echo "Generating hmac / fipscheck file for kcapi-hasher."
  "$4" sha256 -hmac orboDeJITITejsirpADONivirpUkvarP kcapi-hasher > .kcapi-hasher.hmac

  for prog in $6; do
    echo "Linking $prog to kcapi-hasher."
    "$5" -f kcapi-hasher $prog
    echo "Linking hmac / fipscheck file for $prog."
    "$5" -f .kcapi-hasher.hmac .$prog.hmac
  done
fi

cd "$OLDDIR"
