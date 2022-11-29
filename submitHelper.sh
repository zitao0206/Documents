#!/bin/bash
git status
sleep 2

echo "-------Begin-------"
if [ ! $1 ]; then
    read -r -p "Please input your Video commit message: " input
else
    input=$1
fi

git add -A
if [ $input ]; then
    git commit -am $input
else
    git commit -am "Auto Submission"
fi
git push origin master

echo "--------End--------"
