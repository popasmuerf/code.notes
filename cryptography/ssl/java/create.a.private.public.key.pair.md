url:https://www.educative.io/edpresso/keystore-vs-truststore
url:https://access.redhat.com/documentation/en-us/red_hat_jboss_data_virtualization/6.2/html/security_guide/extract_a_self-signed_certificate_from_the_keystore
url:https://access.redhat.com/documentation/en-us/red_hat_jboss_data_virtualization/6.2/html/security_guide/create_a_privatepublic_key_pair_with_keytool

**Quick NOTE** : A certificate alias is the name given to a CA
certificate located in the keystore.  Each entry in the 
keystore has an alias to help identify it.....
The certificate alias indentifies the alias of a specific certificate
in the system keystore that must be used when making HTTPS connection
the the specified URL

It is unknown at this time whether or not this is a feature peculiar to 
Java.


According to the documentation for keytool

#Create a Private/Public key pair
#pair with keytool
========================================
    
##Adding certificate to a truststore using keytool

1.  Run the keytool -export -alias *ALIAS* 
    -keyalg *ALGORITHM*
    -validity *DAYS*
    -keystore server.keystore
    -storetype *TYPE*
 
    
    
        > keytool -genkey \
          -alias teiid  \
          -keyalg RSA \
          -validity 365 \
          -keystore server.keystore \
          -storetype JKS
          

2.  Enter the keystore password when prompted:
    
        > Enter keystore password:  <password> 
        
        
3.  Answer the following questions when prompted:

        What is your first and last name?
        [Unknown]:  <user's name>
        What is the name of your organizational unit?
        [Unknown]:  <department name>
        What is the name of your organization?
        [Unknown]:  <company name>
        What is the name of your City or Locality?
        [Unknown]:  <city name>
        What is the name of your State or Province?
        [Unknown]:  <state name>
        What is the two-letter country code for this unit?
        [Unknown]:  <country name>
        
        
4.1  Enter yes to confirm the provided information

        Is CN=<user's name>, OU=<department name>, O="<company name>",
        L=<city name>, ST=<state name>, C=<country name>  correct?
        [no]:  yes
        
        
4.2 Enter your desired keystore password

        Enter key password for <server>
        (Return if same as keystore password)
                
        
4. Result :  The certificate in **public.cert** has been added to the
   new truststore named **server.truststore**
   





##What is an SSL cert ?
 SSL Certifications are small data files
    *   digitally binds a cryptograhic key to an
        organization's details
        -   domain name, server name,hostname
        -   org identity
        -   org location
        
    *   Uses public key cryptography
        - uses two strings of randomly generated
          prime numbers.
          
          
    *   Root certs must be resent on teh end user's machine
        in order for the certificate to be trusted.
        
        
        
Working with Certiicates and SSL in Java
=============================================================

##Keystore file
    *   keystore.jks
    *   contians application certificate
    *   contains private key
    *   protected by password(initially 'changeit')
    *   password can be changed withkeytool
    *   eachkeystory entry as a unique alias
    *   After installatio the Application 
        Server keystore has a single entr with
        alias slas
  
A keystrore is used to store **private key and identity certificates
that a specific program should present to both parties(sever or client)
for verfification.   i.e. my consumer needs to present my certificate
to the server I wish to consume resources from during negotiation before
we set up an ecrypte session.






##Truststore file
    *   cacerts.jks(this is what it is named in glassfish I guess)
    *   contains the app server's trusted certificates
        -   public keys for other entities
    *   For trusted certificates, the server has confirmed
        that the public key in the certificate belongs
        to the certificates owner.
            -   Trusted certificates generally include those of
                certification authorities(CA)

A truststore is used to store the certificates from Certified Authorities (CA)
that verfiy the certificate presented by the server in SSL connections  i.e.
PRIME backend's certs from CA4 should be included in the TrustStore of 
my consumer and my consumer's cert(maybe?) should be contained within the
truststore of the server in two verfification.




Key Differences
=========================================================================
Keystore stores **YOUR CREDENTIALS**            Truststore stores other credentials(CA)
(server or client)




Keystore is needed when you                     Truststore setup is required
are setting u the server side                   for the successful connection
on SSL                                          on the client side


Keystore is where you store                     Servers will authenticate the 
your private key and identity                   client against the certificate
certificate                                     stored on the server's Trustore


**javax.net.ssl.keyStore** is                   **javax.net.ssl.trustStore**
used to specify the keystore                    is used to specify Truststore
filed




##One way and Two way authentication
========================================
*   1-Way
    -   clieant always verfies the server via cert
    -   The server is unconsernced with
        the identity of of the client

*   2-Way
    -   Client veifies the server via cert
    -   The Server verifies the client via cert
    
    
    
##Adding certificate to a truststore using keytool

1.  Run the keytool -import -alias *ALIAS* -file
    public.cert -storetype *TYPE -keystore
    *server.trustore*   command
    
    
        > keytool -import -alias teiid \
          -file public.cert \
          -storetype JKS  \
          -keystore  server.truststore
      
2.  If the specified trustore already exists, enter the
    existing password for that truststore, otherwise
    enter a new password when prompted:
    
        > Enter keystore password:  <password> 
        
        
3.  Enter "yes" when prompted to trust the certificate:

        Owner: CN=<user's name>, OU=<dept name>, O=<company name>, L=<city>, ST=<state>, C=<country>
        Issuer: CN=<user's name>, OU=<dept name>, O=<company name>, L=<city>, ST=<state>, C=<country>
        Serial number: 416d8636
        Valid from: Fri Jul 31 14:47:02 CDT 2009 until: Sat Jul 31 14:47:02 CDT 2010
        Certificate fingerprints: 
                 MD5:  22:4C:A4:9D:2E:C8:CA:E8:81:5D:81:35:A1:84:78:2F
                 SHA1: 05:FE:43:CC:EA:39:DC:1C:1E:40:26:45:B7:12:1C:B9:22:1E:64:63
        Trust this certificate? [no]:  yes
        
        
        
4. Result :  The certificate in **public.cert** has been added to the
   new truststore named **server.truststore**
   
   
   
   
   
    
    
    
    
        
