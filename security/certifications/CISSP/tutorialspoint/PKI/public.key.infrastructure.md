[Public Key Infrastructure](https://www.tutorialspoint.com/cryptography/public_key_infrastructure.htm)


## Intro

The most distinct feature of PKI is that it uses a pair of keys  to achieve to the underlying security service.  The key pair comprises of private key and public key.

Since the public keys are in the open domain, they are likely to be abused.  It is, thus, necessary to establish and maintain some kind of trusted infrastructure to manage these keys.



### Key Management
It goes without saying that the securityof any cryptsystem depends upon how securely its keys are managed.  Without secure procedures for the handling of 
cryptographic keys, the benefits of the use of strong cryptgraphic schemes are potentiallly lost.

It is observed that cryptogrpahic shemes are rarely compromised thorugh weaknesses in their design. 

There are some important aspects of key management which are as follows --


##### Key management life-cycle
1. Key Generation
2. Key Establishment
3. Key Storage
4. Key Usage
5. Key Archival
6. Key Destruction


Specific Requirements of 'assurance of public key; can be achieved throughte public-key infrastructure (PKI, a key managment system for supporting public keys)


The most curcial requirement of 'assurance of public key' can be achieved thorugh the public-key infrstructure(PKI), a key management systems for supporting public-key cryptography.


Public Key Infrastructure(PKI)
PKI provides assurance of public key.  It provides the identification of public keys and their distribution.  An anatomy ofPKI comprises of the following compnents.

1. Public key Certificate, commonly referred to as 'digital certificate'
2. Private Key tokens
3. Certification Authority.
4. Registration Authority.
5. Certificate Management System.


##### Digital Certificate

A certificate can be considered as the ID cared issued to the person or organization.

Digital Certificates can be used to identify:
1. People
2. Computers
3. Software packages
4. Anything that needs to be electronically identified.....

*   Digtial certificates are based on the ITU standard X.509. which defines a standard certificate formt for public key certficates and certification validation.  Hence the reason that digital certs are often referred to as X.509 certificates.

*   Public keys pertainint fot he user client are storted  in digital certificates are sometimes referred to as X.509 certificates

*   Public keys pertainint fot he user client are storted  in digital certificates by the Certification Authority (CA) along with other relevant information such as client information, expiration data, usage, issuer etc.

*   CA digitally signs this entire information and includes a digital signature inthe certificate

    *Anyone who needs the assurance about the public key and associated informatin of client, he carries out the signature validateion process using CA's public key.  Successful validation assures that the public key given in the certificate belongs to the person whose details are given in the certificate.  
   
Summary so far:
1. We can create keys...no problem...
2. X.509 certs are either issued by a CA or you can create your own...
3. CAs digitally sign these certs with their public key
4. X.509 certs "encapsulte" information like:
   1. CA signature
   2. ID of client 
   3. Info about client
   4. Expiration dates
   5. Issuer
   6. Usage
   7. User public key

5. Assurance that the client is who they say they are is is provided by the public key given in the certificate via carrying out the signatiure validation process using the CA's public key.
6. A Certificate Signing Request(CSR) is how one goes about requesting that their public key is digitally signed(encapsulated in a CA issued X.509 Certificate)
7. Once issued a cert from the CA....a public/private key pay may be created for secure communication between two entities 
