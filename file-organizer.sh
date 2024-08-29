#!/bin/bash

#directory to organize
DIRECTORY_TO_ORGANIZE="${1:-.}"

#check if the directory exists
if [ ! -d "$DIRECTORY_TO_ORGANIZE" ]; then
	echo "Directory $DIRECTORY_TO_ORGANIZE is not exist"
	exit 1
fi
#file extension and corresponding directories
declare -A file_types
file_types=(
	["jpg"]="Images"
	["png"]="Images"
	["gif"]="Images"
	["mp4"]="Videos"
	["mov"]="Videos"
	["mp3"]="Music"
	["wav"]="Music"
	["txt"]="Documents"
	["pdf"]="Documents"
	["docx"]="Documents"
	["zip"]="Archives"
	["tar"]="Archives"
)

#create directories and move files
for file in "$DIRECTORY_TO_ORGANIZE"/*; do
	if [ -f "$file" ]; then
		extension="${file##*.}"
		#convert to lowercase
		extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
		directory=${file_types[$extension]}
		if [ ! -z "$directory" ]; then
			mkdir -p "$DIRECTORY_TO_ORGANIZE/$directory"
			mv "$file" "$DIRECTORY_TO_ORGANIZE/$directory"
			echo "Moved  $file to $DIRECTORY_TO_ORGANIZE/$directory/"
		else
			mkdir -p "$DIRECTORY_TO_ORGANIZE/Others"
			mv "$file" "$DIRECTORY_TO_ORGANIZE/Others"
			echo "Moved $file to $DIRECTORY_TO_ORGANIZE/Others/"
		fi
	fi
done
echo "File organization completed."
