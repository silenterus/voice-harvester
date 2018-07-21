#!/bin/bash


if [ "$1" = "" ]
then
    echo ""
    echo "[FAIL]"
    echo ""
    echo "choose folder"
    echo ""
    exit
fi


files=$(find "$1" -name "*.pyc")
echo "------------------------------------------------"
SAVEIFS=$IFS
IFS=$'\n'
files=($files)
IFS=$SAVEIFS
num=0
for (( i=0; i<${#files[@]}; i++ ))
do
    rm "${files[$i]}"
    num=$(( $num + 1 ))
done

echo ""
echo "DELETED [$num]"
echo ""
echo "------------------------------------------------"



