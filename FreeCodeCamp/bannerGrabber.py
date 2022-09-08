#!/usr/bin/python3

#import module
import socket

#Shorten lingo and end after timeout
s = socket.socket()
s.settimeout(10)
#Banner function block
def banner(ip, port):
    s.connect((ip, int(port)))
    print.recv(1024)

#Main function block
def main():
    ip = input("Please enter IP target:  ")
    port = str(input("Enter desired port number:  "))
    banner(ip, port)

#Call main function
main()