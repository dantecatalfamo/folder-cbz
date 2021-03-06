#!/bin/sh

# If converting to PDF, use https://github.com/bronson/pdfdir to stitch chapters together

if [ "$#" -lt 2 ]; then
    echo "$0 <pdf|cbz> <in folder> [out folder]"
    exit
fi

type=""

if [ "$1" = "pdf" ]; then
    type="pdf"
else
    type="cbz"
fi

path=$(realpath $2)
echo "Path: $path"
series=$(basename $path)
echo "Series: $series"
if [ "$3" != "" ]; then
    output=$(realpath "$3")
else
    output=$(realpath "$path/../$series $type")
fi
echo "Output: $output"
mkdir -p "$output"

cd "$path"

chapters=$(ls)

IFS=$'\n'
for chapter in $chapters; do
    cd "$chapter"
    chapternum=$(echo $chapter | cut -d ' ' -f 1)
    echo "Processing $chapternum"
    chapterout="$output/$series $chapternum.$type"
    if [ -e $chapterout ]; then
        echo "Chapter $chapternum.$type already exists, skipping"
        cd ..
        continue
    fi
    echo "Chapter out: $chapterout"
    if [ "$type" = "pdf" ]; then
        convert * "$chapterout"
    else
        zip -r "$chapterout" .
    fi
    cd ..
done
