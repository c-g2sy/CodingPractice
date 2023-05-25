#!/bin/bash

var="8dm7KsjU28B7v621Jls"
value="ERmFRMVZ0U2paTlJYTkxDZz09Cg"

for i in {1..40}
do
    var=$(echo $var | base64)
    
    if [[ "$var" == *"$value"* && ${#var} -gt 113450 ]]
    then
        # Print the last 20 characters of var
        last_20_chars=$(echo $var | tail -c 20)
        echo "Last 20 characters of var: $last_20_chars"
    else
        echo "Conditions not met for iteration $i"
    fi
done
