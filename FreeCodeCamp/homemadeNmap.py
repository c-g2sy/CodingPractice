#!/usr/bin/python3

#import nmap
import nmap

scanner = nmap.PortScanner()

#Introductions are in order
print("Welcome to a worse version of Nmap network scanner!")
print("----------------------------------------------------------------")
#Ask for user input
ip_addr = input("Enter target IP address:  ")
print("The IP you entered is: ", ip_addr)
type(ip_addr)
#Ask for user inupt
resp = input("""\nPlease enter the type of scan you want to run:
                            1) SYN ACK scan
                            2) UDP scan
                            3) Comprehensive scan"""
                            )
print("You have selected option: ", resp)
#Logic block, could change ports or ask for port ranges up front?
if resp == 1:
    print("Nmap version: ", scanner.nmap_version())
    scanner.scan(ip_addr, "1-1024", "-v -sS")
    print(scanner.scan())
    print("IP Status:  ", scanner[ip_addr].state())
    print(scanner[ip_addr].all_protocols())
    print("Open ports:  ", scanner[ip_addr]["tcp"].keys())
elif resp == 2:
     print("Nmap version: ", scanner.nmap_version())
     scanner.scan(ip_addr, "1-1024", "-v -sU")
     print(scanner.scan())
     print("IP Status:  ", scanner[ip_addr].state())
     print(scanner[ip_addr].all_protocols())
     print("Open ports:  ", scanner[ip_addr]["udp"].keys())
elif resp == 3:
     print("Nmap version: ", scanner.nmap_version())
     scanner.scan(ip_addr, "1-1024", "-v -sS -sV -sC -A -O")
     print(scanner.scan())
     print("IP Status:  ", scanner[ip_addr].state())
     print(scanner[ip_addr].all_protocols())
     print("Open ports:  ", scanner[ip_addr]["tcp"].keys())
elif resp >= 4:
    print("Please enter a valid number!")

