#!/usr/bin/env python3

def print_reverse(input_string):
    reversed_string = input_string[::-1]
    print(reversed_string)

# Get input from the user
user_input = input("Enter a string: ")

# Call the function to print the reversed string
print_reverse(user_input)
