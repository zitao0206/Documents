#!/bin/bash
git status
sleep 2

git add -A

echo "-------Begin-------"
if [ ! "$1" ]; then
    read -r -p "Please input your commit message: " input
else
    input="$1"
fi

if [ "$input" ]; then
    git commit -am "$input"
else
    git commit -am "Publish or edit articles."
fi
git push

echo "--------End--------"
