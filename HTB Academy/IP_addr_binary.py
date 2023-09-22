#!/usr/env/python python3

import ipaddress

def ip_to_binary(ip):
    try:
        # Parse the input IP address or CIDR range
        ip_network = ipaddress.ip_network(ip, strict=False)

        # If it's a single IP address, convert it to binary
        if ip_network.num_addresses == 1:
            ip_binary = ipaddress.IPv4Address(ip_network.network_address).exploded
            return ''.join(format(int(octet), '08b') for octet in ip_binary.split('.'))

        # If it's a CIDR range, convert the network address to binary
        else:
            network_binary = ipaddress.IPv4Address(ip_network.network_address).exploded
            return ''.join(format(int(octet), '08b') for octet in network_binary.split('.'))

    except ValueError as e:
        return str(e)

# Input IP address or CIDR range
ip_input = input("Enter an IP address or CIDR range: ")

binary_octet = ip_to_binary(ip_input)
if binary_octet:
    print(f"Binary Octet Notation: {binary_octet}")
else:
    print("Invalid IP address or CIDR range.")