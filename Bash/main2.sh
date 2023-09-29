#! /bin/bash

path="/hdfs/data/data1"
name_of_directory="data1"
filename_excel="daily_market_price.xlsx"
source_dir="/local/data/market"
target_dir="$path/$name_of_directory"

if [ -f $target_dir/$filename_excel ]; then
    echo "The File $filename_excel Exists in $target_dir"
else
    echo "The File $filename_excel' Does Not Exist in $target_dir"
    cp "$source_dir/$filename_excel" "$target_dir"

    if [ $? -eq 0 ]; then
        echo "File $filename_excel Copied Successfully"
        touch "$target_dir/log_file"
        echo "File Moved Successfully" >"$target_dir/log_file"
        echo "log_file Created"
    else
        echo "Error Copying $filename_excel. Please Check Permissions or File Fxistence."
    fi
fi
