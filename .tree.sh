#!/bin/bash
#Author:Garfield_lv

f1="./README.md"
echo "# 目录" > $f1
echo "![avatar](./Utils/Other/linux.jpg)" >> $f1


function func(){
    for p in `ls $1`
        do
            if [ -d $1"/"$p ]
                then
            echo "- $1"/"${p}" >> $f1
            func $1"/"$p
            elif [ -f $1"/"$p ]
            then
            echo "    [$p]($1"/"$p)" >> $f1
            fi
        done
}
func .
