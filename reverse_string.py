#!/usr/bin/env python3
import sys

print_reverse = lambda s: s[::-1]

if len(sys.argv) > 1:
    # If a command-line argument is provided, use it as input
    input_string = ' '.join(sys.argv[1:])
else:
    # If no command-line argument, prompt the user for input
    input_string = input("Enter a string: ")

reversed_string = print_reverse(input_string)
print("Reversed string:", reversed_string)