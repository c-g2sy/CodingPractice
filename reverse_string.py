#!/usr/bin/env python3
import sys

print_reverse = lambda s: s[::-1]

if len(sys.argv) > 1:
    # If a command-line argument is provided, use it as input
    input_string = ' '.join(sys.argv[1:])
    reversed_string = print_reverse(input_string)
    print("Reversed string:", reversed_string)
else:
    # If no command-line argument, prompt the user for input
    user_input = input("Enter a string: ")
    reversed_string = print_reverse(user_input)
    print("Reversed string:", reversed_string)