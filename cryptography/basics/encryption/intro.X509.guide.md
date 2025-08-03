[X509 Certificates Howto – A Public Key Infrastructure Tutorial](https://grimoire.carcano.ch/blog/x509-certificates-howto-a-public-key-infrastructure-tutorial/)



## X.509 Certificates

- X.509 is under the X.500 standard 
- Deals with authentication
- Has been taken outside of it's inital scope
    * Used to create documents that provide an identify string

- A certificate however contains a lot of metadata: 
    * OpenSSL allows for easily printing the contents of X.509 certificates
    into human readable format by using the "x509" subcommand the "-text" option

    openssl x509 -nout -text /tmp/foo.crt


### X.509 Metadata : Subject

The subject is the string that provides the identity inside the certificate.
Since it is derived frm the X.500 standard, the tokens in the subject
string strongly recall the names of some LDAP attributes:

- C:Country
- S:State
- L:Location
- O:Organization
- OU:Organizational Unit
- Common Name: The actual identify of the X.509 object

    Subject: C = CH, ST = Tessin, O = Carcano SA, CN = www.baz.org

Some special certificates such as 

    Extended Validation certificates 

    Organization Validated certificates

may provide addtional attributest that help to beter identify the subject such as 

    jurisdictionOfIncorporationCountryName (OID: 1.3.6.1.4.1.311.60.2.1.3)
    jurisdictionOfIncorporationStateOrProvinceName (OID: 1.3.6.1.4.1.311.60.2.1.2)
    jurisdictionOfIncorporationLocalityName (OID: 1.3.6.1.4.1.311.60.2.1.1)
    businessCategory (OID: 2.5.4.15)
    serialNumber (OID: 2.5.4.5)
    streetAddress (OID: 2.5.4.9)
    postalCode (OID: 2.5.4.17)


NOTE: the Object Identifier (OID) is an unambiguous, long-term name fo rany type of 
object or entity.  It's use is heavily encouraged especially in use cases that 
call for tight security.

You can customize an OID for your digital certs for the purpose of extending the range of attributes
that can be put inside the certificate




### The Public Key
A certificate contains the 

    public key 

of the asymmetric key-pair

- The public key is a public object, it is perfectly safe to add to the 
certificate (DO NOT ADD YOUR PRIVATE KEY)
- The public key attached to the certificate is then exploited to perform cryptographic tasks
such as enchiperment and verfification of digital signature.



### The Signarture (Signed or self-signed certificates)

Digital Certificates are pretty much similar to real life certificates :
- All certificates must be signed
- You can self-sign your certificate or have a recognized authority sign your cerfiticate

- Self signed certificates are issued by the subject itself, while thirparty 
certificates are issued by `Authorities`.  You may request a certificae via 
providing a CSR to this authority that contains your public key


### The isssuer

The metadata for the acutal issuer of the certificate is included withing the cert's 
X.509 metadata


    Issuer: C = CH, ST = Tessin, O = Carcano SA, CN = CARC I100T

### The Life Time

X.509 certificates can be configured to live forever or expire after a certain amount of time
from the moment it is created

Lists of expired certificates will be available via `Certificate Revokation Lists` that 
themselves are available from the associated `Certificate Authority`


### Policy Constraints 

The certificate explicityly claims the contraints that must be enforecd when validating it's extensions

- There are only two types of constraints

    * Critical
        The CA's policy claims the condition if mandatory 
    * Non-Critical 
        The CA's policy advices the condition should be met, but it is not mandatory


#### Extensions 
`X.509v3` provides several extenstions and here we provide a non-exaustive list


