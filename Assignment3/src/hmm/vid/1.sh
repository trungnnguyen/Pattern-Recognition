#!/bin/sh
find . -name '*.jpg' | gawk 'BEGIN{ a=1 }{ printf "mv \"%s\" %d.jpg\n", $0, a++ }' | bash
