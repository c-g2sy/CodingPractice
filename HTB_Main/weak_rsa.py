from Crypto.PublicKey import RSA

def get_pubkey(f):
    with open(f) as pub:
        key = RSA.importKey(pub.read())
    return (key.n, key.e)

N, e = get_pubkey('./key.pub')

print(f'{e = }')
print(f'{N = }')