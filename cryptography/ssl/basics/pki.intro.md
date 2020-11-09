url:https://www.golinuxcloud.com/tutorial-pki-certificates-authority-ocsp/



##PK-----------------------------------------------------
    *   Public Key Infrastructure (PKI) provides the means to establish trust
    *   Trust is established via binding public keys and identtities that provide
        reasonable assurance that we are communicating securly with who we
        think we are.
    *   PKI is important to using public key cryptography 
    *   A firm grap of PKI is essential to understanding SSL
    *   PKI ensures that encrypted data can be decrypted with the a corresponding
        private key.
    *   A message digest algorithm is used also to provide for a computed signature
        that further ensures that the encrypted data has not been tampered with.
        
        
        
##PK-----------------------------------------------------
    *   Public Key Infrastructure (PKI) provides the means to establish trust
    *   Trust is established via binding public keys and identtities that provide
        reasonable assurance that we are communicating securly with who we
        think we are.
    *   PKI is important to using public key cryptography 
    *   A firm grap of PKI is essential to understanding SSL
    *   PKI ensures that encrypted data can be decrypted with the a corresponding
        private key.
    *   A message digest algorithm is used also to provide for a computed signature
        that further ensures that the encrypted data has not been tampered with.
        
        
##Certificates--------------------------------------------------
    *   At the heart of PKI is the certificate
    *   In simple terms, a certificate binds a public key with a **distinguished name**
    *   A distinguished name (**DN**) is simply just the name of the person or entity that owns the
        public key to which  it is bound
    *   A certificate is signed with the issuer's private key, and it contains almost all
        of the information necessary to verify its validity
        
    *   Certs are also created with a serial number embeded in them.
    *   serial numbers are unique
    *   Serial numbers are often used to identify a cert quickly
        
Note: Quick review...a Cert:
    *   binds your DN with your public key
    *   Your cert is signed with your private key
    *   Your cert has all your validation info
    *   Certs have unique serial numbers embedded in them for quick look up 
        and identifcation
    
##Certificate Types--------------------------------------------------
    *   Wildcard:
        - Certs that are assigned a common name when created, and the common name matches
          the url of the site or entity using the cert
          
    *   SAN  
        - Subject Alternative Name(SAN) cert can have multiple common names assoicated with the 
          cert
          
    *   Code Signing:
        -   this cert is used to digitally sign application code that you create
        

    *   Self-signed
        -   A self-signed cert is used by the root CA.  Each entity within the PKI
            requires a cert
            
        
    *   Root:
        -   When a PKI is created, the first cert authority installed is known as
            the root CA.
            
         
##Certification Authorities--------------------------------------------------
    *   Private CA:
        - A private CA has the responsiblity of issuing certificates only for members
          and is likewise trusted only by members of its own organization.
          
    *   Public CA:  
        - Example of public CAs are Verisign or Thawte, has teh responsibility of
          issuing certificates for any member of the pubic and must be trusted by the public
          
 
 
 ##Certification Hierarchies--------------------------------------------------
    *   Private CA:
        - A private CA has the responsiblity of issuing certificates only for members
          and is likewise trusted only by members of its own organization.
          
    *   Public CA:  
        - Example of public CAs are Verisign or Thawte, has teh responsibility of
          issuing certificates for any member of the pubic and must be trusted by the public
          
          

