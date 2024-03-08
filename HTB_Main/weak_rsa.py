#!/usr/bin/python

from Crypto.PublicKey import RSA
import owiener

def get_pubkey(f):
    with open(f) as pub:
        key = RSA.importKey(pub.read())
    return (key.n, key.e)

N, e = get_pubkey('./key.pub')

def get_ciphertext(f):
    with open(f, 'rb') as ct:
        return bytes_to_long(ct.read())

d = owiener.attack(e, N)

def decrypt_rsa(N, e, d, ct):
    pt = pow(ct, d, N)
    return long_to_bytes(pt)

print(f'{e = }')
print(f'{N = }')

def pwn():
    N, e = get_pubkey('./key.pub')
    ct = get_ciphertext('./flag.enc')
    d = owiener.attack(e, N)
flag = decrypt_rsa(N, e, d, ct)

print(flag)

if __name__ == '__main__':
    pwn()