#!/usr/bin/python3
# Import module
import socket

# Shorten the variables
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Don't wait forever!
s.settimeout(10)

# Hard code or ask for user input
host = input("Enter the target IP address:  ")
port = int(input("Enter first port to scan:  "))

# Define boolean results
def portScanner(port):
    if s.connect_ex((host, port)):
        print("Port is closed! :(")
    else:
        print("Port is open!")

# Function call, will try to edit to include loop through desired ports, until break condition
portScanner(port)
