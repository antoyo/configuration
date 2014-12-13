#!/bin/bash

echo "Different files:"

for file in $(find . -type f\
    -not -path "./.git/*"\
    -not -path "*.swp"\
    -not -path "./urxvt/*"\
    -not -path "./diff.sh"\
    )
do
    if [ -n "$(diff $file ~/$file)" ]; then
        echo $file
    fi
done
