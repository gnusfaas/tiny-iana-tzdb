#!/bin/sh
# Author: Sreejith.Naarakathil@gmail.com

rm -rf tzdb-2022a tzdb-2022a-base
lzip -dc tzdb-2022a.tar.lz | tar -xf -

cp -f Makefile.NEW tzdb-2022a/
cp -f private.h tzdata_template.h tzdata_template.c intercept.h tz-gen-c-db.sh tzr.txt tz-strip-db.sh zn.txt tzdb-2022a/

make TOPDIR=./build cc=gcc -C tzdb-2022a -f Makefile.NEW clean
make TOPDIR=./build cc=gcc -C tzdb-2022a -f Makefile.NEW production
make TOPDIR=./build cc=gcc -C tzdb-2022a -f Makefile.NEW tzlib_clean
make TOPDIR=./build cc=gcc -C tzdb-2022a -f Makefile.NEW tzlib

