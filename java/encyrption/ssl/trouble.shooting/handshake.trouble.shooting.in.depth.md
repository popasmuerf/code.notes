SSL Handshake Failures
===============================

# 1. Overview

Secured Socket Layer(SSL) is a cryptographic protocol which provides
security in communication over the network.



# 2. Terminology

*   SSL as a messaging encryption standard is superseded by TLS
*   Most programming languages, including Java, have libariers to support
    both SSL and TLS as part of their STL
    
*   Despite the fact that SSL and TLS aren't the same thing...for some
    reason people insist on using the term 'SSL' to refer to both SSL and
    TLS respectively....so keep this in mind that 'SSL' is often a 
    'catch all' term for cryptographic protocols....
    
    
    
# 3. Setup

*   SSL as a messaging encryption standard is superseded by TLS
*   Most programming languages, including Java, have libariers to support
    both SSL and TLS as part of their STL
    
*   Despite the fact that SSL and TLS aren't the same thing...for some
    reason people insist on using the term 'SSL' to refer to both SSL and
    TLS respectively....so keep this in mind that 'SSL' is often a 
    'catch all' term for cryptographic protocols....
    
    
# 4. Creating Certificates in Java

*   SSL provides secrecy, integrity, and authenticity in network
    communications.
    
*   Certificates play an important role as far as establishing 
    authenticity
    
*   Typically, these certificates are purchase and signed by a
    Cert Authority, but for these notes...we will assume the use of 
    Self signed certs...
    
*   ##To achieve this ,we can use keytool, which ships with he JDK:

        > keytool -genkey -keypass password \
                          -storepass password \
                          -keystore serverkeystore.jks

    
    
 The above command stars an interactive shell to gather
 information for the certificate like:
 
    *   Common Name(CN)
    *   Distinguished Name(DN)
    
When we provide all relevant details, it
generates the file 

    **serverkeystore.jks**
    
 which contains the private key of the server and its public 
 certifiate.
 
 
 AGAIN...WHAT DOES THE FILE **serverkeystore.jks** contain?
 
    *   private key
    *   public certificate
    
Where is this file *.jks stored ?
It's stored in the (we are talking Java here) in the
**Java Key Store** (JKS) format which is proprietary 
to Java.


These days, while running keytool, it will remind us that we
out to consider using **PKCS#12**, which it also supports.
  
  
We can further use **keytool** to extract the public certificate
from the generated **keystore** file

###On the server

        > keytool -export -storepass password \
                  -file server.cer \
                  -keystore serverkeystore.jks
                  
The above command exports the public cert from the keystore file(*.jks)
as a file **server.cer**.  We can now use the exported certificate fro the client
by adding it to its truststore:

###On the client

        > keytool -import -v -trustcacerts \
                            -file server.cer \
                            -keypass password \
                            -storepass password \
                            -keystore cleinttruststore.jks
                            
                            
We have now generated a keystore for the server and 
corresponding trustore for the client.  We will go over the use of
these generated files when we discuss possible handshake failures

And more details around the usage of Java's keystore can be found 



# 5. SSL Handshake

SSL handshakes are a **a mechanism by which a client and server establish
the strust and logistics reqired to secure their connection over the network**

This is a very orchestrated procedure and understaning the
details of this can help understand why it often fails, which we 
intend to cover in the next section.....

**Typical steps in an SSL handshake are :**

1.   Client provides a list of possible SSL version and cipher suites to use
    
2.   Server agrees on a particular SSL version and cipher suite.  Server sends
     Client it's certifcate

3.   Client recieves certifcate from the Server.  The Client extracts the
     public key fromt he certificate.  The Client sends the Server it's 
     encrypted "pre-master key"
     
4.   The Server recieves the encrypted pre-master-key from the Client that the
     Client generated using the public key it extracted from the Server's certificate
     The Server decrypts the pre-master-key" using it's private key.
     
5.   The Client and the Server both compute a "shared secret" using the 
     exchanged "pre-master key"
     
6.   Client and Server exchange messages confirming the successful encyrption
     and decryption using the "shared secret"
     
     
The above steps describes the general steps taken to establish an SSL connetion
between two hosts....but there is more than one kind of SSL Handshake....



# 6. The Handshake in One-way SSL

If we refer to the stand model of steps of SSL negotian mentioned above,
step #2 mentions the certificate exchange.  One-way SSL requires that
a client can trust the server through its public certificate.  **This 
leaves the server to trust all clients** that request a connection

...in other words...there is no two way trust between client and server
because all the Server needs is for the client to trust it's cert.....
There is no way for a sever to request and validate the public certicate from clients
which can pose a security risk.....

**Typical steps in an SSL handshake are :**

1.   Client provides a list of possible SSL version and cipher suites to use
    
2.   Server agrees on a particular SSL version and cipher suite.  Server sends
     Client it's certifcate

3.   Client recieves certifcate from the Server.  The Client extracts the
     public key fromt he certificate.  The Client sends the Server it's 
     encrypted "pre-master key"
     
4.   The Server recieves the encrypted pre-master-key from the Client that the
     Client generated using the public key it extracted from the Server's certificate
     The Server decrypts the pre-master-key" using it's private key.
     
5.   The Client and the Server both compute a "shared secret" using the 
     exchanged "pre-master key"
     
6.   Client and Server exchange messages confirming the successful encyrption
     and decryption using the "shared secret"
     
     
The above steps describes the general steps taken to establish an SSL connetion
between two hosts....but there is more than one kind of SSL Handshake....and
this is a consciderable security risk.



# 7. The Handshake in Two-way SSL

The server in this version of the handshake **must** establish that
the clients....all clients are trusted.  During a two-way handshake, **both the client
and the server must present and acept each other's public certiciates before a succesful
connection can be established.**

**Typical steps in an SSL handshake are :**

1.   Client provides a list of possible SSL version and cipher suites to use
    
2.   Server agrees on a particular SSL version and cipher suite.  Server sends
     Client it's certifcate

3.   Client recieves certifcate from the Server.  The Client extracts the
     public key fromt he certificate.  The Client sends the Server it's 
     encrypted "pre-master key"
     
4.   The Server recieves the encrypted pre-master-key from the Client that the
     Client generated using the public key it extracted from the Server's certificate
     The Server decrypts the pre-master-key" using it's private key.
     
5.   The Client and the Server both compute a "shared secret" using the 
     exchanged "pre-master key"
     
6.   Client and Server exchange messages confirming the successful encyrption
     and decryption using the "shared secret"
     
     
The above steps describes the general steps taken to establish an SSL connetion
between two hosts....but there is more than one kind of SSL Handshake....and
this is a consciderable security risk.



# 8. Handshake Failure Scenarios

Now that we have a general idea of how SSL handshakes work,
and the two different version of the handshake...we sort of now
have a better idea of what might be going on should these handshakes
ever fail.....

**Typical steps in an SSL handshake are :**

1.   Client provides a list of possible SSL version and cipher suites to use
    
2.   Server agrees on a particular SSL version and cipher suite.  Server sends
     Client it's certifcate

3.   Client recieves certifcate from the Server.  The Client extracts the
     public key fromt he certificate.  The Client sends the Server it's 
     encrypted "pre-master key"
     
4.   The Server recieves the encrypted pre-master-key from the Client that the
     Client generated using the public key it extracted from the Server's certificate
     The Server decrypts the pre-master-key" using it's private key.
     
5.   The Client and the Server both compute a "shared secret" using the 
     exchanged "pre-master key"
     
6.   Client and Server exchange messages confirming the successful encyrption
     and decryption using the "shared secret"
     
     
The above steps describes the general steps taken to establish an SSL connetion
between two hosts....but there is more than one kind of SSL Handshake....and
this is a consciderable security risk.










