# types of cryptography

There are 3 major types of modern encryption:
    -   Symmetric:
        -   single key
    -   Asymetric:
        -   two keys
    -   Hashing
        -   One way encryption
        -   Uses no keys for obvious reasons
        -   Uses encryption algorithm only

## Symmetric
Uses the same key for encryption and de-encryption.
Sometimes known as "secret key" encryption

Uses stream and or block modes.
Stream:
    every bit is encyrpted in a "stream"
Block:
    blocks of 64 -> 128 bits are 
    encrypted.
    DES(Data Encryption Standard) uses 64 block ciphers
    AES uses 128 ciphers
    Some block ciphers can emule
    stream ciphers by setting the bock size to 1 bit; but they are still block ciphers at the end of the day.

## Initialization vectors and chaining



## DEA
Data Encryption standard
Invented by IBM
Is called an algorithm but it is not.
It is an encryption standard
64 bit cipher
56 bit key
Featurs block and emulated stream
Modes:
    -ECB
    -CBC
    -CFB
    -OFB
    -CTR
International data encryption algorithm(IDEA) is a symmetric block cipher designed as an international replacement to DES.
64 bit block size
128 bit key

## 



## Asymmetric encryption standard (AES)
Teh advanced encryption standard(AES) is the current US standard in symmetric block ciphers.
features:
128 bit blocks of dat
128 bit key(10 rounds of encryption)
192 bit key (12 rounds of encryption)
256 bit key (with 14 rounds of encryption)



## Blowfish and Twofish
Symmetrc block ciphers
Open algorithms(unpatented and free for use by anyone)
**Blowfish**
32-448 bit key(default 128)
64 bit block
**Twofish**
AES finalist
128-256 bit keys 
128 bit block


## RC5 and RC6
Symmetrck block cphpers by RSA Labs
32bit key (for testing)
64bit key (for replacing DES)
128-bit blocks
Key size ranges from 0-2040
**RC6** 
AES finalist



## Asymmetric Encryption
Asymmetric encryption uses two keys, one for encryption and the other for decryption.  The public key, as its name indicates, is made pulbic and asymmetric encryption is also called public key encryption for htis reason

Any one who wants to communicate with your system...all they have to do is download your posted public key and us it to encrypt their plaintext.  Once encrypted, your public key cannot decrypt the plain text; however your private key can do so.

#### Asymmetric methods
Math lies behind the asymmetric breakthrough.  These methods use one-way functions, which are easy to compute one way but are difficult to compute in the reverse direction.

#### Factoring prime numbers
An example of one-way function is factoring a composite number into
primes.  Multiplying hte prime numbe 6269 by the number 7883 results in the composite number 


    In [2]: n0 = 6269

    In [3]: n1 = 7883

    In [4]: c = n0 * n1

    In [5]: c
    Out[5]: 49418527

This is relatively a fast calculation,
however reversing this operations such that we can accurately calculate what the values of n0 and n1 are is far more difficult.  That computation is called **factoring** and currently how this would be accomplished in a efficient manner that would not take hundred of years is not currently known by our current mathematics.

Factoring is the basis of RSA's algorithm.


#### Discrete lograthim

A logarithm is the oppose of exponentiation.

    Computing 7^13 is relatively easy...
    In [6]: m0 = 7

    In [7]: m1 = 13

    In [8]: m2 = pow(7,13)

    In [9]: m2
    Out[9]: 96889010407

..however computing the exponent of m0 that will provide for the result of
m2 is far more diffcult.

Discrete logarithms apply logariths to groups, which is a much harder problem to solve.  This one-way function is the basis of the 
Diffie-Hellman and ElGamal asysmetric algorithms


#### Diffie-Hellman key agreement protocol

Secure way to exchange public keys over a public channel such as the Internet, with no prior key exchange.  An attacker who is able tosniff the entire conversation is unable to derive the exchanged key.
Relys on discrete lograithms to provide security.


####  Elliptic curve cryptography
ECC leverages a one-way function that uses discret logarithsm as applied to elliptic curves.  Solving this problem is harder than solving discrete logarithms, so algorithms based on elliptic curve cryptography(ECC) are much stronger per bit than 
systems using discrete logarithms and factoring prime numbers.

ECC requires less computational resources because it uses shorter keys compared to DL and Factoring.

Lower-power evices often use ECC for this reason.


### Asymmetric and symmetric tradeoffs
Asymmetric encryption is far slower than symmetric encryption, and is weaker per bit of key length.

The strength of Asymmetric encyrption is that you can communicate securely without presharing a key.



## Hash Functions
Encrption algorithm with no key.
Are referred to as one way Has Functions because their encryption is irreversable(no key, no decryption)

**Hash common names:**
    -   message digest
    -   hash

Hashes are used primarily for the purposes of maintaining integrity.
If a hash plantext changes, the plaintext itself has changed.

**Common older hashes functions**
    -   Secure Hash Algorithm 1(SHA-1)
        -   160-bit hash
    -   Message Digest 5 (MD5)
        -   128-bit hash
        -   Subject to relatively frequent collisions


**Alternatives to SHA-1 and MD5**
    -   SHA-2
    -   SHA-224
    -   SHA-256
    -   SHA-384
    -   SHA-512
    -   MD6
  

#### Collisions
Hahes are not unique because the number of possible plantexts is far larger than the number of possible hashes.  Assume you are hashing documents that are a megabit long with MDF.  Think of the documents s


#### Cryptographic Attacks
Methods to recover encrypted data without a key. Aquiring a valid key is nearly always easier than breaking modern encryption.  Stealing keys is typically what Law Enforcement does when trying to break encryption.  They typically get a warrant and then try to aquire the target key.

    -   Brute Force...
        -   generates the entire key space, which is every value in the entire set of possible keys.  Given enough time, the correct key will be attained...but due to the computing resources, including time required...isn't often a viable solution.
    -   Social engineering
        -   Get the key via covincing someone to give it to you.
    -   Known Plaintext
        -   A known plaintext attack relies on recovering and analyzing a matching plaintext and cipertext pair; the goal is to derive the key that was used.
        -   Known Key
            -   Crypto Analyist knows enough about the key being used to encrypt data and as such can reduce the efforts used to attack it.

    -   Differential Cryptanalysis
        -   Different

    -   Side-Channel Attacks
        -   Side-channel attacks use physical data to break a cryptosystem, such as monitoring CPU cycles or power consumption used while encrypting or cecrypting.

## Implementing Cryptography
  Symmetric, asymmetric, and has-based cryptography does not exist in a vaccum; rather, they have real-world applications, often in combination with each other, in which they can provide confidentiality, integrity, authentication and non-repudiation

  - Digital Signatures
    - cryptographically sign documents
    - provides nonrepudiation
    - authentication of identity of signer
    - proof of document's integrity
  


