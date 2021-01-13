Source url : [Beginners guide on PKI, Certificates, Extensions, CA, CRL and OCSP]

Source url for primer on internet naming conventions: [https://docs.oracle.com/cd/E19182-01/820-6573/ghusi/index.html]

Source url for Certificate signing request : [https://en.wikipedia.org/wiki/Certificate_signing_request]

###Table of Contents
-PKI
-Certificates
-Certificate Types
-Certification Authorities
-Certificate Hierarchies
-Certificate Formats
-Cerfitificate Revocation Lists
-Online Certificate Status Protocol
-How SSL/TLS works ?




##PKI
Public Key Infrastructure (PKI) provides the means to establish trust by
binding publick keys and identities, thus giving reasonable assurance that
we are communicating securely with who we think we are.

PKI is important to use public key cryptography effectively, and is essential to
understanding andusing the SSL protocol


Using public key cryptography, we can be sure that only the encryped data can be decyrpted
with the correspondig private key.

If we combine this with the use of message digest algorithm to compute a
signature, we can be sure that the encrypted data has not been tampered with.
What is missing is some means of ensuring that the party we are communicating with
is actually who they say they are.  In other works, trust has not been established.  
This is where PKI fits in.

##Certificates
-   At the heart of PKI is something called a **certificate**

-   A certificate binds a pubic key with a Distinguished Name(DN)
    public key <---binds---> thirdplanet.io

-   A certificate is signed with the issuer's private key, and it contains 
    almost all of the information necessary to veriy its validity.  It contains information
    regarding
        - subject
        - issuer
        - perfiod of validity
    Almost all the information regarding the issuer ? What's missing ?
        -   They key component that the certificate is missing 
            is missing the issuer's actual certificate. The issuer's certificate
            contains the the issuer's public key which is necessary for verifying the
            signature on the subje'ts certificate
-   A certificate is signed with the issuer's private key, and it contains almost all of the
    information necessary to verfiy its validity
    
-   Cerftificates are also created with a serial number embedded int hem.  The serial 
    number is unique only to the issuer or the certificate.  No two certificates issued by the same
    issuer should ever be assigned the same serial numberl.  The certiciate's serial number is often
    used to identify a certicate quickly.
    
    
##Certificate Types
-   Wildcard :
    -   Certificates are assigned a common name when created, and the 
        common name matches the URL of the site or entity using the
        certificate.
    -   In other words...trust anyone with a CN match...then we are good.

-   SAN
    -   A subject altnernative name(SAN) certificate is a certificate that can have
        multiple common names associated with the certifciate
        
-   Code Signing
    -  A code-signing certificate would be used to digitally sign application code
       that you create
    
    
-   Self signed:
    -   A self-signed certificate is used by the root CA.  Each entity within the PKI
        needs a certificater
        
-   Root:  When a PKI is created, the first certificate authority installed is known as 
           as the root CA

##Certificate Authoritorities
A Certification authority(CA) is an organization or company that issues certificates
the CA must ensure beyond all reaswonable doubt that every certificate it issues contains a public 
key that was issued by the party that claims to have issued it.

-   Private CA
    -   has the responsibility of issuing certificates only for members of its own
        organization, and is likewise trusted only by members of its own organization
-   Public CA
    -   Such as Verisign, or Thawte, has the responsiblility of issuing certificates for
        any member of the public, and must be trusted by the public.



##Certificate Hierarchies
A certificate that is issued by a CA can be used to issue and sign another certificate,
(in other words...if I have been issued a cert by a CA...I can use it's private key
to sign other certs ?)
If the issued cer is created with the appropiate permissions todo so.  In this way, certficates
can be chained

At the root of the chain is the root CA cer.  Because it is at the root of the 
chain, and there is no other authority to sign its certificate, the root CA signs itson own
certificate.  Such a certificate is known as a self-signed certificate....


#Certificate signing request
In public key insfrastructure (PKI) systems, a certificate signing rquest (also CSR or 
certification request) is a message sent from an applicant to a registration authority
of the public key infrastructure inm order to apply for a digitald identity certificate.

It usually contains the public key for which the certificate should be issued,  digital identity certificate. It usually contains the public key for which the certificate should be issued, identifying information (such as a domain name) and integrity protection (e.g., a digital signature). The most common format for CSRs is the PKCS #10 specification; another is the Signed Public Key and Challenge SPKAC format generated by some web browsers. 





                                    +---------------+
                                    |     Root CA   |
                         +----------+               +---------+
                         |          |               |         |
                         |          |               |         |
                         |          +---------------+         |
                         |                                    |
                         |                                    |
                  +------+--------+                 +---------+-----+
                  | Subordinate CA|                 |Subordinate CA |
           +----> |               |                 |               | <---+
           |      |               |                 |               |     |  Request
Request    |      |               |                 |               |     |  cert
cert       |      +---------------+                 +---------------+     |
           |                                                              |
           |                                                              |
       +---+-----+                                                 +------+----+
       |Subject  |                                                 |Subject    |
       |         |                                                 |           |
       |         |                                                 |           |
       +---------+                                                 |           |
                                                                   +-----------+



###Certificate Extensions

The most widely accepted format for certificates is the 
X.509 format for certificates is the x.509 format.  ther are three
versions of the format, known as 
-   X.509v1
-   X.509v2
-   X.509v3

The most recent revision ofthe standard was introduced in 1996,
and most, if not all, modern software now supports it.  A large number
of chanes were made between X.509v1 and X.509v3, but perhaps one of the 
most significant features introduced in the X.509v3 standard is its support
of extensions


##Certificate Formats

There are different certificate formats because of the way the information is stored in the certificate. The following identifies common file formats for certificates:

-   DER/CER   Distinguished Encoding Rules (DER) and Canonical Encoding Rules (CER) are binary file formats used to store information in the certificate file. DER-formatted files can have a .der or a .cer file extension.

-   PEM   Privacy-enhanced Electronic Mail (PEM) is an ASCII file format that can have a file extension of .pem, .crt, .cer, or .key. PEM files are very common and start with

        -----BEGIN CERTIFICATE----- 
 
 and end with 
         
        -----END CERTIFICATE-----
         
 
-   PFX/P12   The Personal Information Exchange (PFX) format, also known as the P12 or PKCS#12 format, is a binary file format that is common with Microsoft environments for importing and exporting certificates. PFX formatted files have an extension of .pfx or .p12.


-   P7B   The P7B format, also known as PKCS#7, is another ASCII file format used to store certificate information. If you open the ASCII file, you will see that it begins with the text -----BEGIN PKCS7----- and ends with -----END PKCS7-----. P7B files can have an extension of .p7b or .p7c.



##Certificate Revocation Lists
Once a cert has been issued, it is generallyput into production, where it will be
distributed to many clients.  If an attack compromisies the associated private key, he 
now has the ability to use the the certificate een though it doesn't belong to him.  

Assuming the proper owner is aware of the compromise, a new certificate with a new key pair 
should be obtained and put into use. 

In this situation there are two certificates for the same entity---both are technically valid,
but one should not be trusted.  The compromised certificate will eventually expire, but in the meantime, how will the owrld at large know not to trust it?

The answer lies in something calle a certificate revocations list(CRL).  A CRL contains a list
of all the reovked certificates a CA has issued that have yet to expire.  When a certificate is revoked,
the CA declares that the certificate should no longer be trusted.




##Online Cetificate Status Protocol

The Online Certificate Status Protocol(OCSP), formally specified in RFC 2560, is 
a realatively new addtion to PKI.  Its primary aim is to address some of the distribution
problems that have tradtionally plagued CRLs


Using OCSP, an application makes a connection to an OCSP responser and requests
the status of a certificate by passing the certificate's serial number.  The rewspnder replies "good"
,"revoked", or "unknown".  A "good" response indicates that the cert is valid, so far as the responder knows.



Using OCSP, an application makes a connection to an OCSP responder and requests the status of a certificate by passing the certificate’s serial number. The responder replies “good,” “revoked,” or “unknown.” A “good” response indicates that the certificate is valid, so far as the responder knows. This does not necessarily mean that the certificate was ever issued, just that is hasn’t been revoked. A “revoked” response indicates that the certificate has been issued and that it has indeed been revoked. An “unknown” response indicates that the responder doesn’t know anything about the certificate. A typical reason for this response could be that the certificate was issued by a CA that is unknown to the responder.



1. The client sends a request for a web page to the secure web site using https:// in the URL. This makes a connection to port 443 by default.
    
2. The server sends the public key to the client.
    
3. The client validates the certificate and ensures it has not expired or been revoked.

4. The client creates a random symmetric key (known as a session key) used to encrypt the web page content, 
5. The client encrypts the symmetric key with the public key obtained from the web server.

6. The encrypted information is sent to the web server. The web server decrypts and obtains the symmetric key (session key). The web server uses the symmetric key to encrypt information between the client and the server.




