#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <base64_encoded_string>"
    exit 1
fi

# Read the Base64 encoded string
encoded_string="$1"
decoded_string="$encoded_string"

# Start loop counter
iterations=1

# Decoding loop
while true; do
    decoded_string="$(echo "$decoded_string" | base64 -d 2>/dev/null)"
    
    # Check if the decoding resulted in an invalid Base64 string
    if ! echo "$decoded_string" | base64 -d &>/dev/null; then
        break
    fi

    # Increment loop counter
    iterations=$((iterations + 1))
done

echo "Decoding iterations stopped at: $iterations"
echo "$decoded_string"