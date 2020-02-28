#!/bin/sh

path=$(realpath $1)
echo "Path: $path"
series=$(basename $path)
echo "Series: $series"
output=$(realpath "$path/../$series cbz")
echo "Output: $output"
mkdir "$output"

echo "Chapters: $chapters"

cd "$path"
echo "In $path"

chapters=$(ls)
echo "Chapters: $chapters"

IFS=$'\n'
for chapter in $chapters; do
    echo "Processing $chapter"
    cd "$chapter"
    chapternum=$(echo $chapter | cut -d ' ' -f 1)
    chapterout="$output/$chapternum.cbz"
    echo "Chapter out: $chapterout"
    zip -r "$chapterout" .
    cd ..
done
