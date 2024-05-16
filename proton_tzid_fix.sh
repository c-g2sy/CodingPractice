#!/bin/bash

# Check if a file is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename.ics>"
    exit 1
fi

# Check if file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Backup original file
cp "$1" "$1.backup"

# Prompt user for replacements
read -p "Enter the replacement for 'TZID:': " tzid_replace
read -p "Enter the replacement for 'DTSTART;TZID=': " dtstart_replace
read -p "Enter the replacement for 'DTEND;TZID=': " dtend_replace

# Find the line numbers of the strings to replace
tzid_line=$(awk '/^TZID:/{ print NR; exit }' "$1")
dtstart_line=$(awk '/^DTSTART;TZID=/{ print NR; exit }' "$1")
dtend_line=$(awk '/^DTEND;TZID=/{ print NR; exit }' "$1")

# Replace the text after "TZID:" with user input
sed -i "${tzid_line}s/:.*/:$tzid_replace/" "$1"

# Replace the text after "DTSTART;TZID=" with user input
sed -i "${dtstart_line}s/:.*/:$dtstart_replace/" "$1"

# Replace the text after "DTEND;TZID=" with user input
sed -i "${dtend_line}s/:.*/:$dtend_replace/" "$1"

echo "Replacements applied to $1"
