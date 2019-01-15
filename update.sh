#!/bin/bash
#Author: Garfield_lv

info_file = "./README.md"
base_dir = "./"

echo "# REEADME\n\n"  > info_file
echo "![avatar](./utils/linux.jpg)\n\n" >> info_file


function read_dir(){
    for file in `ls $1`
    do
	if $1 != ".git"
	then
            if [ -d $1"/"$file ]
            then
                read_dir $1"/"$file
            else
                echo $1"/"$file
            fi
	fi
    done
}

read_dir base_dir
