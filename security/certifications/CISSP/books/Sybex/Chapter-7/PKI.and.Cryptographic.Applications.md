# PKI and Cryptographic Applications

### Asymmetric key cryptography
* Notice that the process does not require the sharing of private keys...
* Once the sender encrypts the message with the recipient's private key
* Public Keys can freely be shared using unsecured communications
* Encurs higher computing complexity than Symmetci key cryptography
* Due to cost of asymmetric cryptography...many cryptologists are content with using symmetric cryptography on anything but relatively short messages.
* Keys used for public  key cryptography must be longer than the keys used in private key styems to produce systems of equivalent strengths


### RSA
* One of the first  Asym public key cryptisystems
* Most famous public key cryptosystems
* Invented by  Ronald **R**ivest, Adi **S**hamir, and Leonard **A**dleman (RSA)
* Algorithm relies on the factoring of larger prime numbers
* formula for RSA:
* Was patented...now is OSS(circa 1998??)



### Merkle-Hellman Knapsack
* Early Asym algorims
* Developed one year after RSA was publicized
* Algorithm also employes sety theory known as super-increasing sets rather than on large prime numbers
* A trash algorithm that was broken in 1984


### Importance of Key Length
* The length of the cryptographic key is perhps the most important security parameter that can be set at the discrestion of the security administrator.  

*  Understanding the capabilities of your chosen algorithm is important w/r to chocing a proper and suitable key length
*  This judgement can be made by weighing the difficulty of defeating a given key length(measured by the amount of processing cytels required to defeat the algorithm) against the importance of the data
*  The more critical your data is...the longer the key needs to be..however timeliness of the data is also an important factor.
*  Moore's law dictates that if it takes a year to beat an encryption now...then four years later...it would take 3 months for a then contemporary CPU to crack the encryption(or even faster if using a GPU)
*  You should plan out the design of your 
*  Attackers can leverage "unlimited" computing resources via their own cloud accounts...which includes scalable gpu clusters for the sole purpose of attacking encrypted data.
* To illustrate the importance of careful key design...The following table of encryption schemes are all relatively of the same strength.

| Crypto-System  | Key Length |
|----------------|------------|
| Symmetric      | 128 bits   |
| RSA            | 3,072 bits |
| Elliptic Curve | 256 bits   |


## ElGamal
* Diffie-Hellman algorithm uses large integers and modular arithmetic to facilitate the secure exchange of secret keys over insecure communications channels
* Dr. Taher Elagaml publiced an artical describing how the mathematical principles behind the Diffie-Hellman key exchange algorithm could be extended to support an entire public key cyrptosystem used for encrypting an decrypting messages.
* It was OSS from the start.
* ElGamal  doubles th esize of any message that it encrypts....
* ElGamal is only really useful with very small messages


## Elliptic Curve(ECC)
* Published the same year as ElGAmal
* Neal Koblitz
* Victor Miller
* Is a pretty complex algorithm
* Ellictical Curve(ECC) is defined by
    <div class="aside">
        y<sup>2</sup> = x<sup>3</sup> + ax + b
    </div>
*   **x**,**y**,**a** and **b** are all real numbers
*   Each ECC has a corresponding **ECC group** made upf of the points on teh elliptic curve along with the point **O**, located at infifinity.
*   Two points within the same elliptic curve group (P and Q) can be added together with an elliptic curve addtion algorithm.  This operation is expressec as :
    P + Q

* This problem can be extended to involve multiplication by assuming that **Q** is a multiple of **P**, meaning :
    Q=xP

* Computer Scientists and matematicians believe that it is extremely hard to find **x**, even if **P** and **Q** are already known.
* The difficult poroblem, known as the **elliptic curve discrete logarithm problem** forms the basis of ECC cryptography.
* It is believed that EEC curve discrete logarithm is harder to crack than RSA.  There is some evidence for this hypothesis as the bit size of RSA encryption schemes are usually nearly 12 times the size of a ECC curve discrete logarithm scheme of equal strength.


### Diffie-Hellman Key Exchange
*   Another example of public key cryptography
*   Allows two users to generate a shared secrete that both know without every actually transmitting that secret.
*   Allows for public key cryptography to generate a shared secret key that they then use to communicate with a symmetric encryption algorithm.
*   This is known as **hybrid cryptography**
*   Works by using the math of prime numbers, similar to the RSA algorithm.
*   Diffie-Hellman IS NOT an encryption protocol, as it is technially a key exchange protocol.
*   commonly used to crate a shared secret key for use in TLS, whre it is referred to as either DHE, or EDH.


### Quantum Cyrptography
*   Theoretical at this point.
*   uses **qubits**
*   qubits are multi-dimential and thus are not limited to a binary state
*   Hypothetically could break encryption that silicon based computers cannot....otherwise known as **Quantum Supremacy**
*   Hyupotherically could create cryptography schemes that are superior to present asymetric, factorization/ECC encyrption systems known as **Quantum Cryptography**
*   Their already exists implementations of**quantum key distribution(QKD)**, an approach to use quantum computing to create a shared secret key between twor users similar to Diffie-Hellman, but has yet to reach th estage of practical use. 


### Hash Functions
* simple purpose: generate unique outpute value derived from the content of the message.
* The unique output is known as a "message digest"
* Message digests can be generated by the sender of a message and transmitted to the recipient along with the full message for two reasons.
  - First, the recipient can use the same hash function to recompute the message digest from the full message for comparison.  If the two hashes don't match then we can be confident that the original message has been altered.  Any changes will result in a different hash.  There is no way to tell to what degree relative to some base standard has occured if the hashes(digests) don't match.
  - Second, the mesage digest can be used to implement a digital signature algorithm.
  
  - Most cases will have a digestthat is 128 bits or larger, however a single-digit value can be used to perform the function of parity, a low-level or single-digit checksum value used to provide a single indivicual point of verfication.
  - According to RSA Security, there are five basic requirements for a cryptographic  hash function:
    * The input can be of any length
    * The output has a fixed length
    * The hash function is relatively easy to compute for any input
    * the hash function is one-way.
    * The hasch function is collision resistant(it is extremely difficulut to produce the same hash)

-   common hashing schemes
    * SHA
        - SHA-1
        - SHA-2
          * SHA-256
          * SHA-224
          * SHA-512
          * SHA-384 
        - SHA-3
          * Same functionality and options as SHA-2
          * Slower than SHA-2
          * Not commonly used 
        - Goverment standard
        - promoroted by NIST
        - Secure Hash Standard(SHS)
        - FIPS 180
    * MD5
      - Implements additional security features that reduce the speed of message digest production significantly.
      - Is vulnerable to collisions and thus isn't so great for guaranteed messaged integrity
      - It has been demonstrated in 2005 that it is possible to create two digital certificates from different public keys that have the sam MD5 hash
      - Some tools still depend on MD5
      - It is best to rely on SHA-2 for creating digests if you can.

    * RIPEMD (RIPE Message Digest)
      - series of has functions is an alternative to the SHA family that is used in some applications, such as Bitcoin HASH implementations.  The family contains  a series of increasingly sophisted functiones
        * RIPEMD
          - 128 bit digest
          - Structural issues that rendered it insecure
        * RIPEMD-128
          - Replace RIPMD
          - 128 digest
          - no longer considered secure
        * RIPEMD-160 
          - Replaces RIPEMD-128
          - Remains secure to this day
          - 160 bit digest
          - Most commonly usued RIPEMD variant 

    * RIPE Message Digrest(RIPEMD)
    * Hash message authentication code(HMAC)



### Digital Signatures
ONce you have chosen a cryptographic  sound hash sfunction and cyrptogrpahic algorithm, you cna use it 
to implement a **digital signature** system.  Digital
signature infrastructures have two distinct goals:
  * non-repudiation
  * integrity of information in transit which protects info from attack while in transit or corruption due to electrical interference or for some other reason
  

### HMAC (Hashed Message Authentication Code)
The hashed message authentication code(HMAC) algorithm 
implements a partial digital signature----it guarantees the integrity of a message during transmission, but it does not provide for nonrepudiation





### PKI Key Infrastructure
The major strenght of public key encryption is it's ability to facilitate communication between parties previously unknown to each other.  This is made possible
via **public key infrastrucute(PKI)**

Digital certificates are essentially endorsed copies of an individual's public key....

Again...a PKI cert is little more than a copy of 
a public key that is endorsed by some trusted CA.
..so self signed certs are still conscidered PKI?
I am thinking...yeah..I think so..because "trust" is relative.

1. User verifies that a cert(endorsed public key) has been signed by a trusted certificate authority(CA) then they "know" that their public key is legit.

### Internaltional standard -- X.509
1. Serial number(from cert creator)
2. Signature algorithm identifier
3. Signature 



Certificates....