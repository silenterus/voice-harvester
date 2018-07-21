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



if [ "$2" = "asd" ]
then
    echo ""
    echo "[FAIL]"
    echo ""
    echo "choose search term"
    echo ""
    exit
fi





if [ -f "$PWD/searched.links" ]
then
    rm "$PWD/searched.links"
fi

files=$(find "$searchpath" -name "*.html" && find "$searchpath" -name "*.html.tmp" )
echo "------------------------------------------------"
SAVEIFS=$IFS
IFS=$'\n'
files=($files)
IFS=$SAVEIFS
num=0
allfound=0
found=0
for (( i=0; i<${#files[@]}; i++ ))
do

    search=$(cat ${files[$i]} | sed "s/ /\n/g" | grep -oP '(?<"http).*(?=")' )
    if [ "$search" != "" ]
    then
        num=$(( $num + 1 ))
        found=$(cat ${files[$i]} | sed "s/ /\n/g" | grep -oP '(?<"http).*(?=")' | wc -l)
        echo "$search" >> "$PWD/searched.links"
        allfound=$(($allfound + $found))

    fi

    echo "SEARCHED THROUGH [$i/${#files[@]}]"
    clear
done
if [ "$num" = "0" ]
then
    echo ""
    echo "[FAIL]"
    echo ""
    echo ""
    echo "SEARCHED THROUGH :"
    echo ""      
    echo "[$searchpath]"
    echo ""      
    echo "nothing found..."
    echo ""
    exit
fi


cat "$PWD/searched.links"
echo ""

echo ""
echo "[SUCCESS]"
echo ""
echo ""
echo "FOUND [$allfound] LINKS"
echo ""
echo "IN [$num] PAGES"

echo ""
echo "-------------------------------------"




