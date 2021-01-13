Source url : [https://forum.seafile.com/t/tutorial-for-a-complete-certificate-chain-with-your-own-certificate-authority-ca/124]
Source url: [https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/#Root_vs_Intermediate_Certificate]

Source url : [https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/#Root_vs_Intermediate_Certificate]

#Tutorial for a complete certificate chain with your own Certificate Authorityu(CA)



##Root vs Intermediate Certificate
-   A certificate chain or certificate CA bundle is a sequence of certificates, where each
    certificate int he chain is signed by the subsequent certificate(sounds a bit like block-chain)
    
-   The Root CA is the top level of certificate chain wihle intermediate CAs or Sub CAs
    are Certificate Authorities that issue off an intermediate root
    
-   Typically, the root CA does not sign server or client certificates directly

-   The root CA is ony ever used to create one or more intermediate CAs, which are trusted
    by the root CA to sign certificates on their behalf.  This is best practice.
    
-   It allows the root key to be kept offline and unused asmuch as possible, as any compromise
    of the root key is disastrous
    
-   An intermediate certificate authority (CA) is an entity that can sign certificates on behalf of
    the root CA

-   The root CA signs the intermediate certificate, forming a chain of trust

-   The purpose of using an intermediate CA is primarily for security

-   The root key can be kept offline and used as infrequently as possible

-   If the intermediate key is compromised, the root CA can revoke the intermediate certificate
    and create a new intermediate cryptographic pair
    
    
    
 +-----------------+       +----------------+     +----------------+    +-----------------+
| Intermediate    |signs  |Intermediate    |signs|Intermediate    |signsRoot CA          |
| Certificate-3   +<------+Certificate-2   +<----+Certificate-1   +<---+Cerfificate      +<--+
|                 |       |                |     |                |    |                 |   |
+-----------------+       +----------------+     +----------------+    +--------+--------+   |
                                                                                |    signs   |
                                                                                +----------->+
   



##I'm curious, how can for example SHA-256 be unique if there are only a limited number
##of them ?


For clarification:
How many MD5 hashes are there ?
16^32 MD5 hashes can be produced.
16^64 SHA-256 hashes can be produced.
16^128 SHA-512 hashes can be produced.


For more clarification:
assume we want MD5 of all the SHA-256 hashes.
we can have 1632 number of MD5 hashes, while there are 1664 SHA-256 hashes.
we will have 3.4*1038

duplicate MD5 hashes!

And so is for SHA-256 hash, if we calculate SHA-256 of all the SHA-512 hashes, we will have 1.15*1077

duplicate SHA-256 hashes!

Edit: This is not limited to a particular hash like SHA-256.



##Hashes aren't really unique....they are psuedo-unique
-------------------------------------------------------------------------
Where our "issue" occurs is that they are not unique.  It is just very improbable that
they will recoccur.  **Unique** in this context is not meant to meet the requirment
of mathematical uniqueness, but rather meant to mean "unique" as in "the chance of colliding
hashes withen the contexual set of all possible hashes are very, very unlikely"


In terms of human numbers , 2^256 = 11579208923731619542357098500https://www.youtube.com/watch?v=mlvo4ioB5P08687907853269984665640564039457584007913129639936.

The chances of a collision in whatever context is 1/115792089237316195423570985008687907853269984665640564039457584007913129639936 the
qoutient of which is

8.636168555094445e-78


....statically "0"
