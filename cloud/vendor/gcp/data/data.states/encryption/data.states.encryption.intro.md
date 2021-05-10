#GKE - Symmetric Key Encryption 



-   Symmetric encryption algorithms use the same key for encryption  and 
    dycryption
    * Key factor 1:  is using the right encryption algorithm
    * Key factor 2:  How do we secure the encryption key ? 
    * Key factor 3:  How do we share the encryption key ?
    
-   Asymmetric Key Encryption (AKA Public Key Cryptography)
    * Use different key for encryption and a different key for decryption
    * Public and Private Keys
    * Public key -> encrypt
    * Private key -> decrypt
    
-   How do you create Aysmmetric Keys in GCP  ?
    * via Cloud KMS
        -   Create and manage cryptoghraphi keys
                *   Symmetric and aysmmetric
        -   Control their use in your applications and GCP Services 
        -   Provides an API for :
            *   encryption
            *   decryption
            *   sign data
            
        -   Allows for the use of keys from any source
        
    *   Interation with almost all GCP services that need data encryption
        -   Google-managed key
                * Requires no configuration 
        -   Customer-managed key
                *   Use key from KMS
        -   Customer-suppliec key
                *   Provide your own key
    
    
    
    


