#!/bin/bash

if [ ! "$#" -eq 1 ]; then
    echo "Usage: $(basename $0) <filename>";
    exit 1;
fi;
hash_indir sha1 $1
