#! /bin/bash

path="/hdfs/data/data1"
name_of_directory="data1"
filename_excel="daily_market_price.xlsx"
source_dir="/local/data/market"
target_dir="$path/$name_of_directory"

if [ -d $path/$name_of_directory ]; then
    echo "There is $name_of_directory Directory Exists!"
else
    echo "$name_of_directory Directory Not Exists!"
    mkdir $path/$name_of_directory
    echo "$name_of_directory Directory Created!"
fi
