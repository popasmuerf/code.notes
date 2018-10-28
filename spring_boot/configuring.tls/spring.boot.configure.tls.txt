https://drissamri.be/



Configuring our app for encrypted communication 
================================================


For java....by default, your cacerts are stored in 

        JDK/jre/lib/security 
        
        
* Wait...what is X.509 ?
-----------------------------   
    In cryptography, X.509 is a standard defining the format
    of public key certificates.  X.509 certificates are 
    used in many Inernet protocols including:
    
        TLS/SSL
    
    which is the basis for HTTPS, the secure protocol for browing
    the web....public keys based on X.509 are also used in 
    offline applications, like electronic signatures.
        
    An X.509 cert contains a public key and an identity(a hostename, or an organization ,   or an individual), and is either signed by a certauthority or is self-signed:
    
            public cert
            --------------
            Name: ""
            Cert Authority/self Signature : ""
            Public Key : ""
            
    When a signed cert is released....we can within reason
    assume that that we can use this public key to secure
    communications with other parties or validate 
    documents digtially siged by the corresponding priate key.
        
            
    Besides the format for certificates themselves, X.509 specifies 
    certificate revocation lists which are a means to 
    distrube inforamtion about certificates that are no longer valid,
    and a certification path validation algorithm, which allows for
    certificates to be signed by intermediate 
    certificates, which are in turn signed by other
    certificates, eventuall reaching a trust anchor.
     
     
     X.509 is efined by the International Telecommunicatins Union's
     Standardization sector(ITU-T), and is based
     on ASN.1
    
* Wait...what is a ca root certificate
---------------------------------------
    In cryptography, and computer security,
    a root certificate is a public key certificate
    that identifies a root certificate authority(CA) is a
    public key certificate that identifies a root
    certificate authority(CA) ...A root certificate is the 
    top-most certificate of the tree, the private key of which is used to "sign"
    othe certificates....
    
    Root certs are self-signed and form the basis of an
    X.509-based public key infrastructor(PKI).  Either it 
    has matched Authority Key Identifier with Subjet Key
    Identifier, in some cases there is no 
    Authority Key identifier, then Issuer string
    shoudl match with Subject string (RFC5280)
    
    For instance, the PKIs supporting HTTPS for secure
    web browsing and electronic signature schemes depend on 
    a set of root certificates.
    
    
    A cert authority can issue multiple certs in a the form of a 
    tree structure.  A root cert is the top-,ost cert of the
    tree, the private key of which is used to "sign" other certis.
    All certs are signed by the root cert, with the CA field set to ture,
    inheriting the trustworthiness of the root cert. Such
    certs are called intermediate certs and all subsequent
    certs down the tree are in turn rely on the trust worthiness of it's 
    intermediate precursor....
    
    The root cert is usually made trustworthy by some mechanismother than
    a certificate, such as by a secure physical distrubtuion...
    for example...some of the most well-known root certs are distributed
    in operating systems by their manufacturers....
    
    
    
    
    End-entity Cert
    ---------------
    Owner's name
    Owner's public key
    Issuer's(CA's name)---------references
    Issuer's signature              |
    ------------------              |
          ^                         |
          |                         V
          |
          |                      Intermediate Cert
          |                      ---------------
          |                      Owner's name
          |---------sign------   Owner's public key
                                 Issuer's(root CA's name)---------referneces
                                 Issuer's signature                  |
                                 ------------------                  |
                                       ^                              |
                                       |                              V
                                       |                     End-entity Cert
                                       |                     ---------------
                                       |                     Owner's name
                                       |-------sign---------- Owner's public key
                                                            Issuer's(CA's)
                                                            Issuer's signature
                                                            ------------------

* Wait...what is a keystore ?
---------------------------------------
A Keystore is a repo of security certs --either authorization
certificates or public key certifications -- plus 
corresponding private keys, used for stuff like SSL encryption.


when you generate a pair of cryptographic keys, you use both
to produce a SSL certificate which is then stored within a 
keystore.

A keystore is a database of cryprographic keys, X.509 cert chains,
and trusted certificates.

With Spring Boot apps , if you want to enable HTTPS,
we'll provide a Spring Boot appliation with this 
keystore containing the SSL certificate


* Wait...what is Public Key infrastructure 
------------------------------------------
PIK is a set of roles, policies, and procedures
needed to create,manage, distribute, use, store, and 
revoke digital certificates and manage public-key encryption.

The purpose behind PKI is to facillitate the secure 
electronic transfer of information for a range of network activities
such as e-commerce, internet banking...etc.

It is required for activities where simple passwords
are an inadequate authentication method and more rigorous proof
is required to confirm the identity of the parties involved in the
communication and to validate the information being transferred.


In cryptograhphy, a PIK is an arrangement that binds public keys with
repsective identities of entitieies(like people and orgs). The binding
is established through a process of registration and issuance of certificates at and by
a certificate authority(CA)

* Wait...what is CAcert.org ?
-----------------------------
    CAcert.org is a community-driven certificate authority that issues 
    free public key certs to the public.
    
    CAcert has over 334,000 verified uses and has issued over 
    1,285,000 certificates as of July 2016.
    
    Thse certificates can be used to digitally sign and encrypt email,
    authenticate and authorize users connectiing to websites and
    secure data transmission over the internet.  Any aplication
    that supports the Secure Socket Layer (SSL) can make use of 
    certificates signed by CAcert, as can
    any application uses X.509 certificates 

    CAceert Inc is an incororated non-profit association
    registered in New South Wales since July 2003 which
    runs CAcert.org 
    
    
* Wait...what is Let's Encrypt
-------------------------------

    Let's Encrypt is a certificate authority that 
    provides X.509 certificates for Transport Layer
    Security(TLS)
    
    The certificate is valid for 90 days, during which
    renewal can take place at anytime.
    
    The offer is accompanied by an automated process designed to 
    overcome manual creation, validation, signing, installation, and reneal
    of ceertifiates for secure websites....
    
    The project claims to make encrypted connections to World Wide Web servers ubiquitous.[6] By eliminating payment, web server configuration, validation email management and certificate renewal tasks, it is meant to significantly lower the complexity of setting up and maintaining TLS encryption.[7] On a Linux web server, execution of only two commands is sufficient to set up HTTPS encryption and acquire and install certificates.[8][9]
    
    
    
Steps for self-signed certs
============================================
*   source : https://www.tutorialspoint.com/spring_boot/spring_boot_enabling_https.htm
*   generated a self signed cert

            keytool -genkey -alias tomcat -storetype PKCS12 -keyalg RSA -keysize 2048 -keystore keystore.p12 -validity 3650
            
            #generating a PKCS12 keystore file named as keystore.p12 and the ceertificate
            alias name is tomcat
            
            
*   configure HTTPS

        -   open application.properties(we are using spring boot)
        -   use the following configuration:
         
            server.port: 443
            server.ssl.key-store: keystore.p12
            server.ssl.key-store-password: springboot
            server.ssl.keyStoreType: PKCS12
            server.ssl.keyAlias: tomcat
            
        -   use the following configuration if you are using application.yml
        
            server:
                port: 443
                ssl:
                    key-store: keystore.p12
                    key-store-password: springboot
                    keyStoreType: PKCS12
                    keyAlias: tomcat
                    
Ok....So I got it running....this is how I did it...along withthe caveats......
================================================================

1. Step 1...you need to create a keystore....we all know by know a keystore is basically a database tat includes the following:

            certificates or public key certifications -- plus 
            corresponding private keys, used for stuff like SSL encryption.
            
            *   public key certifications
            *   corresponding private keys
            *   certificates
            
            
2). You have  a choice between two kind of the most commonly used keystores....JKS(Java Key Store) and PKCS.  We should always go with PKCS because it's an open standard.  We use the "keytool" that comes with Oracle's or OpenJDK's distribution of java sdk:

            keytool -genkey -alias tomcat -storetype PKCS12 -keyalg RSA -keysize 2048 -keystore keystore.p12 -validity 3650
            
            
            
3). Copy your new keystore file to your resource folder 



4). Configure your app to use TLS via configuring the application.properties file autogenerated in your app:

        # Define a custom port instead of the default 8080
        #server.port=8443
        server.port=4443
        # Tell Spring Security (if used) to require requests over HTTPS
        #security.require-ssl=true
        
        # The format used for the keystore
        server.ssl.key-store-type=PKCS12
        # The path to the keystore containing the certificate
        server.ssl.key-store=classpath:keystore.p12
        # The password used to generate the certificate
        server.ssl.key-store-password=passwd
        # The alias mapped to the certificate
        server.ssl.key-alias=tomcat
        
        
Apparently Spring will configure your app to TLS off of this base configuration....I made the "mistake" of adding the spring security boot starter/library to my gradle build file....which caused the app to demand that a user pass a user name and password before it could use any particular endpoint.....so I commented it out of my build.gradle file....and now I can use these endpoints over TLS......without the need for authentication.  I will need to investigate the world of Spring security tho.....because if the app is to be truely secured....we need both TLS to encrypt requests and responses....but also authenticating end users of the service....