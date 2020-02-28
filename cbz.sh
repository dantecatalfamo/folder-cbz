#!/bin/sh

path=$(realpath $1)
echo "Path: $path"
series=$(basename $path)
echo "Series: $series"
output=$(realpath "$path/../$series cbz")
echo "Output: $output"
mkdir -p "$output"

cd "$path"

chapters=$(ls)

IFS=$'\n'
for chapter in $chapters; do
    cd "$chapter"
    chapternum=$(echo $chapter | cut -d ' ' -f 1)
    echo "Processing $chapternum"
    chapterout="$output/$series $chapternum.cbz"
    if [ -e $chapterout ]; then
        echo "Chapter $chapternum.cbz already exists, skipping"
        cd ..
        continue
    fi
    echo "Chapter out: $chapterout"
    zip -r "$chapterout" .
    cd ..
done
