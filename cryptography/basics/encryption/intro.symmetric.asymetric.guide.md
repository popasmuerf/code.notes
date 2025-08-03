[Cryptography quick guide – understand symmetric and asymmetric cryptography and how to use it with OpenSSL](https://grimoire.carcano.ch/blog/cryptography-quick-guide/)



# Terms
## Keys
It is a set of data used to feed cryptographic routines:  They are called `keys` since 
same way as physical keys lock and unlock things, cryptographic keys
lock and unlock cryptographic objects there are 
two kinds of keys:

- symmetric = a single key
    * must always remain secret
    * must always be read-only/write-protected
- asymetric = a pair of keys
    * private key
        - must always remain secret
        - must always be read-only/write-protected
    * public key
        read-only/write-protected












# Encryption
    - scrambling of data
        * reversable
        * irreversable 
    
### Two major families of encryption 
    - Block Ciphers
        * Types of Block Ciphers
            - DES
            - 3DES
            - Blowfish
            - IDEA
            - RC2
            - RC5
            - AES
        * Encryption methodology
            - data is encrypted in fixed sized blocks
                * 64 bytes
                * 128 bytes
        * Typically used for encrypting data at rest

    - Block Cipher Operating modes
        * Electronic Codebook Mode (ECB)
            - Data is handled in lbocks of 64 bits
            - Encrypts every block with the same key, padding the last chunk
            of data if it does not completely fit the last block.
        * Cipher-Block Chaining (CBC)
            - XOR the current block with the previous one
            - First block is XOR'd with a random block of data called an `iniitalization vector (IV)`
        * Cipher Feedback(CFB)
            - Optimized for performance
        * Output Feedback mode (OFB)
            - Similar to CFB, but does not propagagte errors of transimission of bits
            - More vulnerable to attacks that modify flow of messages 
        * Counter (CTR)
            - 
            
    - Stream Ciphers
        * Types of Stream Ciphers
            - RC4
            - SALSA
            - SOSEMANUK
            - PANAMA
        * Operates on each byte of data
        * Requires fewer resources(?)
        * Are typicaly faster than block ciphers 
        * Are conscidered less secure than block ciphers(source ?)
        * Typically used for encrypting data in transit










### Message Digest
    - Outcome of derving a bit array of a fixed size from the original data using a mathematical algorithm
    that cannot be reverted (AKA cryptographic hash).  Examples of cryptographic hash functions are :
        * Types of Cryptographic Hashes
            - MD-4
            - MD-5
            - RIPEMD-160
            - SHA-1, SHA-256, SHA-512



    - Message digests are generated using a symmetric key and are suitable to implement 
    the so called `Message Authentication Code (MAC)`: this is the process of validating data integrity
    by verfiying that the MAC code calculated at the recieving party does match the one 
    provided by the sender: If it doesn't, it means that data has been tampered.


### Hash-Based Message Authentication Code 

Message digests let you verify that the message has not been tampered, 
but they do not guarantee that the received message does actually come from the entity 
that is supposed to be the author instead of from an impostor. This limitation 
is addressed by the Hash-based Message Authentication Code (HMAC) algorithm: 
it has been specifically designed to enable the parties to establish a trusted channel 
and to agree on the key and the MAC algorithm to use. 
This resolves the authentication problem: but there is still a missing thing: since both parties 
calculate the MAC using the shared key, you cannot say from a MAC which one of the 
parties did generate it. So HMAC are suitable for integrity check and authentication, but not for non-repudiation, since we cannot clearly identify who generated the MAC.





### Signing

The solution to the non-repudiation problem

Asymmetric cryptography addresses the non-repudiation 
problem: when digitally signing  the sender encrypts 
the MAC using its own private key. Any receiver can easily 
verify that the message comes from us by decrypting it using 
the sender's public key, and then verify the integrity of the 
message validating the MAC. Conversely from HMAC, each party has 
its own private key, and so the signature can clearly identify 
who signed the message.



### Encrypting  Contents

- This is the most straightforward type of encryption
    * both parties use the same key to encrypt and decrypt
    * Despite this kind of encryption is easier to implement and 
    offers better peformance if compared with asymmetric encryption, it is 
    `cumbersome to keep secure` since you have to deliver copies of the key in situations such as
        - New keys will eventually have to be generated and provided to all parties to replace the old 
        keys (key rotation best practices)
        - Keys must be replaced if there is any chance the current key has been comprimised 

    * Commonly used symmetric encyrption algorithms include :
        - AES
        - Blowfish
        - Camellia
        - Idea
        - DES, 3DES
        - RC4, RC5, RC6
        - Twofish 


## Asymetric Cryptography
- Relies on related key pairs 
    * private
    * public 

- Easier to keep secure as unlike symmetric key crptography....we only 
need to share public keys

- Use cases 
    * Authentication 
        - only parties with the valid private key that shared their public 
        key with you can be authenticated (basically the core of CA and PKI)
    * Encryption of contents 
    * Signing of contents 
        - Generate a MAC of the data to be signed
        - Encrypt MAC using your private key
        - Peers can verfiy the signature by decrypting it using the sender's public key
        and then goes about validating the MAC






