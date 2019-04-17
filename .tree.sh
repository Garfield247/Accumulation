#!/bin/bash
#Author:Garfield_lv

f1="./README.md"
echo -e "# 目录\n" > $f1
echo -e "![avatar](./Utils/Other/linux.jpg)\n" >> $f1


function func(){
    for p in `ls $1`
        do
            if [ -d $1"/"$p ]
                then
            echo -e "- $1"/"${p}\n" >> $f1
            func $1"/"$p
            elif [ -f $1"/"$p ]
            then
            echo -e "    [$p]($1"/"$p)\n" >> $f1
            fi
        done
}
func .
