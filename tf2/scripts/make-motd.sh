#!/bin/sh

echo ''

while IFS= read -r line; do
    echo -n '- '
    echo $line
done < $1