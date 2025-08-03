[source](https://openssl-ca.readthedocs.io/en/latest/create-the-root-pair.html)





# OpenSSL CA


## Introduction

- A certificate authority (CA) is an entity that signs digital certificates
- May websites are required to configrm that your connection is secure and thus 
will pay for internationally trusted CA via the common CA cert authorities
    * VeriSign
    * DigiCert
for signing certificates for their domain(s)

- In some cases it may make more sense to act as your own CA as opposed 
to paying a Certificate Authority like DigiCert
- Common cases for acting as your own CA 
    * Securing intranet services
        - Web sites
        - backend, services
        - Databases 
        - issusing certificates to clients to allow them to 
        authenticate to a server



## Create the root pair 

- Acting as a certificate authority (CA) means dealing with cryptographic pairs of private
keys and public certificates.  
- The very first cryptographic pair we weill create is the root pair.
- This consists of the 
    * rootkey 

        ca.key.pem

    * root certificate

        ca.cert.pem


- This pair forms the identidy of your CA.

- Typicaly the root CA does not sign server or client certificates directly.
- The root CA is only ever used to creae one or more intermediate CAs which are trusted 
by the root CA to sign certificates on their behalf.  This is actually the best practice 
- This is best practice.
- It allows the rook key to be kept offline and unused as much as possible, as any compromise
of the rook key is disastrous

### NOTE :
It's best practice to create the root pain in a secure enviroment.  Ideally, this should be on a fully
encrypted, air gapped computer that is permanently isolated from the Internet.  Remove the 
wireless card and fill the ethernet port with glue(Sure thing....if you got money to be destroying
equipment like that...then go for it...but I think I will pass).



## Prepaare the root directory

- Choose a directory to store all keys and certs to store all keys and certifates

    >  mkdir     /root/ca

Create the directory structure.  The `indext.txt` and `serial` files act as flat file 
databse to keep track of signed cers

    > cd /root/ca
    > mkdir certs crl newcerts private
    > chmod 700 700 private
    > touch index.txt
    > echo 1000 > serial 


### Preparing the configuration file 

You must create a configuration file for OpenSSL to sue.  Copy this root config file to 
the following path :

    /root/ca/openssl.cnf


The actual contents of openssl.cnf explained 

The `[ ca ]` section is mandatory.  Here we tell OpenSSL to use the options from the 
[ CA_default ] section 

    [ ca ]
    # `man ca`
    default_ca = CA_default


The [ CA_default ] section contains a range of defaults.  Make sure you declare the directlory you
chose earlier  (/root/aca)

    [ CA_default ]
    # Directory and file locations.
    dir              = /root/ca
    certs            = $dir/certs
    crl_dir          = $dir/crl
    new_certs_dir    = $dir/newcerts
    database         = $dir/index.txt
    serial           = $dir/serial
    RANDFILE         = $dir/private/.rand

    # The root key and root certificate.
    private_key      = $dir/private/ca.key.pem
    certificate      = $dir/certs/ca.cert.pem

    # For certificate revocation lists.
    crlnumber        = $dir/crlnumber
    crl              = $dir/crl/ca.crl.pem
    crl_extensions   = crl_ext
    default_crl_days = 30

    # SHA-1 is deprecated, so use SHA-2 instead.
    default_md       = sha256

    name_opt         = ca_default
    cert_opt         = ca_default
    default_days     = 375
    preserve         = no
    policy           = policy_strict



We will apply `policy_strict` for all root CA signatures, as teh root CA is only being used to create
intermediate CAs.  


    [ policy_strict ]
    # The root CA should only sign intermediate certificates that match.
    # See the POLICY FORMAT section of `man ca`.
    countryName            = match
    stateOrProvinceName    = match
    organizationName       = match
    organizationalUnitName = optional
    commonName             = supplied
    emailAddress           = optional


Options fromt the `[ req ]` section are applied when creating certificates or certificate or certicate signing
requests. 

    [ req ]
    # Options for the `req` tool (`man req`).
    default_bits       = 2048
    distinguished_name = req_distinguished_name
    string_mask        = utf8only

    # SHA-1 is deprecated, so use SHA-2 instead.
    default_md         = sha256

    # Extension to add when the -x509 option is used.
    x509_extensions    = v3_ca

The [ req_distinguished_name ]  section declares the information normally normally required in a certificate
signing required in a certificate signing request.  You can optionally specify some defaults.


        [ req_distinguished_name ]
        # See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
        commonName                      = Common Name
        countryName                     = Country Name (2 letter code)
        stateOrProvinceName             = State or Province Name
        localityName                    = Locality Name
        0.organizationName              = Organization Name
        organizationalUnitName          = Organizational Unit Name
        emailAddress                    = Email Address

        # Optionally, specify some defaults.
        countryName_default             = GB
        stateOrProvinceName_default     = England
        localityName_default            =
        0.organizationName_default      = Alice Ltd
        #organizationalUnitName_default =
        #emailAddress_default           =




## Create the root key 

Create the root key (`ca.key.pem`) and keep it absolutely secure.  Anoyone in possesion of the root key
can issue trusted certificates.  Encrypt the root key with AES 256-bit encryption and a strong password.

## NOTE:
Use 4096 bits for all root and intermediate certificate authority keys.  You will still be able to sign 
server adn client certificates of a shorter length

    > cd /root/ca
    > openssl genrsa -aes256 -out private/ca.key.pem 4096

    Enter pass phrase for ca.key.pem: secretpassword
    Verifying - Enter pass phrase for ca.key.pem: secretpassword

    > chmod 400 private/ca.key.pem



## Create the root certificate

Use the root key ( `ca.key.pem` ) to create a root certificate (`ca.cert.pem`).  Give the root certificate a 
long expiry date, such as twenty years.  Once the root certificate expires, all certificates signed by the
CA become invalid.

## WARNING
Whenever you use the req tool, you must specify a configuration file to use with the `-config`
option, othewise OpenSSL with default to `/etc/pki/tls/openssl.cnf`


    > cd /root/ca
    > openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 \
        -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem



    Enter pass phrase for ca.key.pem: secretpassword
    You are about to be asked to enter information that will be incorporated
    into your certificate request.
    -----
    Common Name []:Alice Ltd Root CA
    Country Name (2 letter code) [XX]:GB
    State or Province Name []:England
    Locality Name []:
    Organization Name []:Alice Ltd
    Organizational Unit Name []:Alice Ltd Certificate Authority
    Email Address []:   


    > chmod 444 certs/ca.cert.pem

## Verify the root certificate

    > openssl x509 -noout -text -in certs/ca.cert.pem

The output shows :

* The  `Signature Algorithm` used
* The dates of certificate `Validity`
* The `Public-Key` bit length
* The `Issuer`, which is the entity that signed the certificate
* The `Subject, which refers to the certidicate itself 

If the Issuer and the Subject are identical...then we know the certificate is self-signed.
Please note that all root certs are self-signed 


    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=GB, ST=England,
                O=Alice Ltd, OU=Alice Ltd Certificate Authority,
                CN=Alice Ltd Root CA
        Validity
            Not Before: Apr 11 12:22:58 2015 GMT
            Not After : Apr  6 12:22:58 2035 GMT
        Subject: C=GB, ST=England,
                O=Alice Ltd, OU=Alice Ltd Certificate Authority,
                CN=Alice Ltd Root CA
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (4096 bit)



## Intermediate Cert creation 


An intermediate certificate authority (CA) is an entity that can sign certificates on behalf of the root CA. The root CA signs the 
intermediate certificate, forming a chain of trust.The purpose of using an intermediate CA is primarily for security.
The root key can be kept offline and used as infrequently as possible. 
If the intermediate key is compromised, the root CA can revoke the intermediate
 certificate and create a new intermediate cryptographic pair.


 ### Prepare the intermediate directory

 The root CA files are keptin `/root/ca`.   Choose a different directory  `/root/ca/intermediate` to
 store the intermediate CA files 

    > mkdir -p /root/ca/intermidate



#### NOTE

In this example, the intermediate folder resides inside /root/ca. That is just for convenience, 
furthermore, this is to be considered a bad practice: root CA and intermediate CA should be on
different machines.


    > cd /root/ca/intermediate
    > mkdir certs crl csr newcerts private
    > chmod 700 private
    > touch index.txt
    > echo 1000 > serial


Add a `crlnumber` file to the intermediate CA directory tree. `crlnumber` is used to keep track of 
certificate revocation lists.

    > echo 1000 > /root/ca/intermediate/crlnumber


Copy the intermediate configurtion file to `/root/ca/intermediate/openssl.cnf`.  Five options have
been changed compared to 

"What is an animal that men are compared to that is a general common name and society that we use as much as bitch? "  <--- People like you engage in normalized Misandry on a daily basis.  
You are at this moment trying to justify the dehumanization of Men via you cosigning the absolute pudding brained "hypothetical" that your average Woman would be safer with an 
ill-tempered, massive, apex-predator than a random man when THE VAST MAJORITY of woman have lived their entire lives interacting with, passing by ; whether it be in a crowd or 
alone with Men every day to absolutely no incident....let alone that these men will more often than not stop to help if these women for whatever reason requests it.
So yeah....this rhetorical question ain't the mic-drop you think it is Sis.  You might want to sit this one out.
