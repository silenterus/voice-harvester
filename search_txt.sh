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



if [ "$2" = "" ]
then
    echo ""
    echo "[FAIL]"
    echo ""
    echo "choose search term"
    echo ""
    exit
fi



if [ "$1" = "pip" ]
then
    files=$(find /usr/lib/python* -name "*.py")
else
    if [ "$3" = "" ] || [ "$3" = "f" ]
    then
        files=$(find "$searchpath" -type f)
    else
        files=$(find "$searchpath" -name "*.$3")
    fi
fi



if [ -f "$PWD/searched.files" ]
then
    rm "$PWD/searched.files"
fi


echo "------------------------------------------------"
SAVEIFS=$IFS
IFS=$'\n'
files=($files)
IFS=$SAVEIFS
num=0
for (( i=0; i<${#files[@]}; i++ ))
do

    search=$(cat ${files[$i]} | grep "$2" )
    if [ "$search" != "" ]
    then
        num=$(( $num + 1 ))
        found=$(cat ${files[$i]} | grep "$2"  | wc -l)
        echo "------------------------------------------" >> "$PWD/searched.files"
        echo "" >> "$PWD/searched.files"
        echo "[$found]x in :" >> "$PWD/searched.files"
        echo "[${files[$i]}]" >> "$PWD/searched.files"
        echo "" >> "$PWD/searched.files"
        cat ${files[$i]} | grep "$2" >> "$PWD/searched.files"
        echo "" >> "$PWD/searched.files"
        echo "" >> "$PWD/searched.files"
        if [ "$4" != "" ]
        then
            sed -i "s/$2/$4/g" "${files[$i]}"
        fi
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

if [ -f "$PWD/searched.temp" ]
then
    rm "$PWD/searched.temp"
fi

cat "$PWD/searched.files"
echo ""

echo ""
echo "[SUCCESS]"
echo ""
echo ""
if [ "$4" = "" ]
then
    echo "FOUND [$num]"
else
    echo "CHANGED [$num]"
fi
echo ""
echo "-------------------------------------"




