# Public Key Infrastructure(PKI)

Public Key Infrastructure(PKI) leverages all three forms of encryption to provide and manage digital certificates.

The three Forms
    -   Symmetric
    -   Asymmetric
    -   Hash

A digital certificate is a public key signed
with a digtial signature.  Digital certificates may be server-based or client-based.  If client and server certficates are used togehter, they provide mutual authentication and encryption.  The standard digital 
certificate format is X.509



#### Certificate authorities and organizational registration authorities

Digital certificates are issued by certificate authorities(CAs), Organizational registration authorities(ORAs) authentiate the identity of a certificate holder before issuing a certificate to them.  An organization may operate as a CA or ORA (or both)

    -   CA
        -   issues certs

    -   ORA
        -   verifies identiry of cert requesters.

#### Certificate revocation lists
    -   The CAs maintain certificate revocation lists(CRL) which, as the name implies, is a list of revoked cerificates.  A certificate may be revoked if the private key has been stolen, an employee is terminated, etc.  A CRL is a flat file and does not scale well.  The online Certificate Status Protocol (OCSP) is a prelacemenht for CRLs and uses client-server deisn that scales better.

#### Key managment issues 
CAs issue digital certificates and distribute them to certificate holders.  The confidentiality and integrity of the holder's private key must be assured during the distirbution process

Public/Private key pairs used in PKI should be stored centrally and securely.  Users may lose their private key as easily as they may forgtet their password.  A lost  private key means that anything can be encrypted with the matching public key will be lost, short of successful crypto-analysis.


Key storage is different than key escrow.
Key storage mans the organization that issued the public/private key pairs retains a copy.  Key escrow means a copy is retuaned by a third-party organization(and sometimes multiple organizations), often for law enforcement purposes(this is another reason why I beleive self signed certs are a better option than certs from CAs)



A retired key may not be used for new transactions, but one may be used to decrypt previously encrypted plantexts.  A destroyed key no longer exists and therefore cannot be used for any purpose



#### SSL and TLS
Secure Sockets Layer (SSL) broughtr the power of PKI to
the web.  SSL authenticates and provides  confidientiality to web traffic.  Transport Layer Security(TLS) is the successor to SSL.  Both are commonly used as part of HTTPS(Hypertext Transfer Protocol Secure).

SSL was developed for the Netwscape Web browser in the 1990s.  

SSL was developed by Netscape Web Browser in the 1990s.  SSL 2.0 was the first released version' SSL 3.0 fixed a number of security issues with version 2.  TLS was based on SSL 3.0.  TLS is very similar to that version, with some security improvements.  Although typically used for HTTPS to seucre web traffic, TLS may be used for other applications, such as Internet chat and email access.


#### IPsec (Internet Protocol Security)
    - suite of protocols that p;rovide a cryptographic layer to both IPv4 and IPv6.
    - Used by VPNs
    - comprised of the two protocols
      - Authentication Header(AH)
        - authentication and integrity for each packet of network data
        - acts as digital signature
      - Encapsulating Security Payload(ESP)
        - encrypts packet data
      - Association and Key Management Protocol(IsAKMP)
      - Internet Key Exchange (IKE)

    -   Used in tunnel mode or transport mode.
    -   Security gateways use tunnel mode because they can provide point-to-point IPsec tunnels.
    -   ESP tunnel mode encrypts the entire packet

#### AH and ESP


## IKE
## PGP
## S/MIME
