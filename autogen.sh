#!/bin/sh

autoreconf --install

sed -i 's/rm -f core /rm -f /g' configure
