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

# Define replacement for the first TZID
tzid_replace="America\/New_York"

# Find the line numbers of the strings to replace
tzid_line=$(awk '/TZID:/{ print NR }' "$1")
dtstart_line=$(awk '/DTSTART;TZID=/{ print NR }' "$1")
dtend_line=$(awk '/DTEND;TZID=/{ print NR }' "$1")

# Replace the text after TZID: with user input
sed -i "${tzid_line}s/Customized Time Zone/$tzid_replace/" "$1"

# Replace the text after DTSTART;TZID= with empty string
sed -i "${dtstart_line}s/Customized Time Zone//" "$1"

# Replace the text after DTEND;TZID= with empty string
sed -i "${dtend_line}s/Customized Time Zone//" "$1"

echo "Replacements applied to $1"
