#!/bin/bash

# Check if argument requirements are met:
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <integer> <base64_encoded_string>"
    exit 1
fi

# Read integer and Base64 encoded string inputs
x="$1"
encoded_string="$2"

# Loop 'x' times and print decoded string after each iteration
for ((i=0; i<x; i++)); do
    decoded_string="$(echo "$encoded_string" | base64 -d)"

    # Check if base64 decoding was successful
    if [ $? -ne 0 ]; then
        echo "String fully decoded after $i iterations"
        exit 1
    fi

    encoded_string="$decoded_string"
    echo "$i: "$decoded_string""
done

# Print final decoded string after 'x' iterations
echo "Decoded $x times: $decoded_string"