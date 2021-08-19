

See FIPS 140-2 "Security Requirements for Cryptographic Modules" --- defines
hardware and software requirements for cyrptographic modules that the federal governemtn uses.

### Features
1. Nonrepudiation
2. Authentication
3. Confidentiality
   1. Data at rest
   2. Data in motion
   3. Data in use/process
4. Integrity(via digital signature)


## Anti-Crypto Analysis
1. Primary method of defeating cryptography is key neglegence/abuse
2. Pattern matching
3. Knowledge of Cryptogrpahic process
4. Brute force


### Keys
1. Are limited to key space
2. Key space is dictated by number or bit size
3. Keys are basically numbers...the longer the better
4. Keys are sometimes referred to cryptographic variables or crypto variables
5. Plain text that has been encrypted with a key are transformed into cipher-text
   

### Kerckhoff's Principle
1. Algorithms are known and public...so that people may test them
2. The enemy knows the system...but they can't circumvent it
3. Kerchhoff's principle is the opposite of security via obscurity
4. Kerchohoff's approach is trail by fire...use what demonstrably works...and
5.  improve or discard which doesnt
   


## Cryptogrpahic Mathematics
Cryptography is no different from most computer science discplines in that it finds its foundations in the science of mathematics.  To fully understand cryptography, you must first understand the basics of binary mathematics and the logical opeations used to manipulate binary values.  Teh following sections present a brief ook ast some ofthe most fundamental concepts with whicy yu whould be familar.


## Boolean Mathematics
1. AND operator -> ^
2. OR operator -> v
3. Exclusive OR operator -> +
4. NOT operator ->  ~
5. Modulo operator -> %


### One-Way Functions
1. Mathematical operation that easily produces output values for each possible combination of inputs but makes it impossible tor etrieve the input values.
2. Public Key cryptosystems are all aseed on one-way functions.
3. In practice, however, it is neer beenproven that any specific known, function is truly one way.
4. Depnending on the algorithm used....one way functions can be broken...for example...if your algorithm depens on the multiplication of 3 single digit numbers...then the total number of permutations is is 11 * 11 * 11 = 1311 possible "keys"...this isn't difficult to cover this key set for all possible values with today's computing power.
5. The output value 15  by using the input values 1,3,5.  However suppose you restrcit the input values to five-digit prime numbers....we can still obtain anoutput value by sing a computer or good calculator...but reverse-engineering is not quite so simple.  Canyou figure out what the the three prime numbers were used to obtain the output value 10,718,488,075,259?  As it turns out the product of the prime numbers 17,093; 22,441;
6. There 86,363 five-digit prime numbers, so this problem might be attacked using a computer and a brute-force algorith, but hter is not easy way to figure out in your head, that's for sure!



### The Nonce!!!
Cryptography often gains strength by adding randomness to the encryption proess.  One method by which thjis is accomplished is through the use of a nonce.  A nonce is a random number tht acts as a placholder variable in mathematical functions.  When the function is executed, the nonce is replaced with a random number generated at the moment of processing for one-time use.

One of the more recongniazble examples of a nonce is an initialization vector(IV), a random bit string that ist he same length as the block size(the amount of data to be encrypted in each operation_ and is XOed with the message.  IVs are used to create unique cyphertext every time the same message is encrypted using the same key.




## Zero-Knowledge Proof
One of the beenfits of cryptography is found in the mechanism to prove your knowledge of a fact toa third party
without revealing the fact itself to that third party.  This is often done with passwords and other secret authenticators.

The classic example is **zero-knowledge proof** which involves to individuals: Peggy and Victor.  Peggy knows the password to a secret door located inside a circular cave.  Victor wouldliek to buy the password from Peggy, but he wants Peggy to prove that she knows the password efore paying her for it.  Peggy doesn't wan't to give Victor the password outright because he might not pay her.  Zero-Knowledge can solve this issue.



Victor can stand at the entrance to the cave and watch Peggy depart down the path.  Peggy then reaches the door andopens it using the password. She thenpasses thorought the door an dreturns via path 2...proving that she most know the correct password.

In summary **Split Knowledge**

## Split Knowledge
   -  Information or privilege to execute some authorization is split amount multilple users
   -  No single entity(person) has sufficient privileges tocompromise the security of an enviroment
   -  Sepreation of duties and two-person contorl contained in a single solution called **split knowledge.
   -  Example of split knowledge is **key escrow**


## Key Escrow
   - Cryptographic keys keys are stored with a third party for safe keeping.
   - When certain conditions are met, the third party may us the escrowed key to eithe rresotre an authorized user's access or decrypt the material themselves
   - The 3rd Party is known as the "recovery agent"
   - Multimple key recovery agents should be used as there exists potential for fraud and abuse of this privilege as a single agent could unilaterally decide tod ecrypt the information.
   - **M of N Control** where the mininum number of agents (M) ouf of the total number of agents (N) work together to perform high-security  tasks
   - 3 controls out of 8  would require three people out of the eith wi th asigned work task of key escrow recovery agent to work togther to pull a single key out of the key escrow database(thereby also illustrating thatM is always less than or equal to N)  M <= N


### Work Function
-  Strength of crypto system is measured in the effort i nterms of cost and or time using a **work function** or **work factor**
-  usually the time and effort rquired to peform a complete burte-force attack against an encryption system is whaty th work function represents.
-  The security and protection offered by a crypto-system is directly proportional to the value of the work function/factor
-  The size of the work function should be matched against the relative value of the protected asset.
-  The work function need be only slightly greater than the time value of the asset...in other words, all security including cryptography should be cost-effective and cost-efficient.


## Ciphers
Cipher systems have long been used by individuals and governments interested in preserving the confidentiality of their communications. In the following sections, we'll cover the definition of a cipher and explore several common cipher types that form the basis of modern ciphers. It's important to remember that these concepts seem somewhat basic, but when used in combination, they can be formidable opponents and cause cryptanalysts many hours of frustration.


### Codes vs Ciphers
- Terms are often incorrectly or inacurrately used interchangeably.
- Codes ar cryptographic symbols that rpresent words or phrases, are sometimes secret, and are not necessarily meant to provide confidentiality 
- Common does is the "10 system" used by LOE and Truckers
- Semaphores and Morse code are also examples of codes.  Both like the 10-System are well known by the public and offer little next to know confidentiality.
- Some codes are secret tho....and are meant to allow for some confidentiality.
- "EveryGreen"(from the Borne series) and "The Eagle has landed" are examples of secret codes
- Ciphers on the other hand are MEANT to provide confidentiality.
- Ciphers are not symbols or semaphores but convert plaintext to encrypted ciphertext one bit,character, or block basis.

## Cipher Types
   -  Transposition Ciphers
      -  Use an ecnryption algorithm to rearrange theletters of a plaintext message, forming the ciphertext message
      -  Decryption simply is a reverse of the encryption transformation
      -  Example : apple ---> elppa
      -  Example columar transposition
   -  Subsitution Ciphers
      - Replaces characters in plain text with a different character than before.
      - Example ---> Caesar's Cipher 
        - C = (P + 3) mod 26 //encrypt
        - C = (P - 3) mod 26 //decrypt
   -  One-Time Pads
      -  Powerful subsituion Cipher
      -  Uses different subsitution alphabet for each letter
      -  C = (P + K) mod 26
      -  Known as **Vernam Ciphers**
      -  CANNOT BE CRACKED
      -  KEY CANNOT BE REUSED AT ALL IN WHOLE OR IN PART
      -  KEY MUST BE KEPT COMPLETELY SECRET
      -  Uses a single-use, pre-shared key that is completely random.
      -  CANNOT BE SMALLER THAN THE MESSAGE BEING ENCRYPTED
   -  Running Key Ciphers
   -  Block Ciphers
   -  Confusion
      -  encryption/decryption patterns are so wild you can't conclude a pattern
      -  Subsitution is an example of confusion
   -  Diffusion
      -  multiple changes happening thru the ciphertext during encryption
      -  Transposistion is an example of diffusion


## Modern Cryptography
   -  Does not realy on algorithm secrecy
   -  Relies on key secrecy 

##### Symmetric Cryptography
   - Uses ephemeral keys
   - Does not implement nonrepudiation.
   - Algorithms are not scalable(doesn't scale well for large deployments)
   - Keys must be generated often
   - Key distirbution is a problem...as there is only one key.  Secure methods such as out of band key sharing is a commmon method of sharing keys in a secure manner.
   - Are SUPER FAST. 1000x -> 10,000 faster than Asymmetric Cryptography



##### Asymmetric Cryptography
   - Provides the weknesses of symmetric key encyrption
   - Public Key algorithms are the most common.
   - Improves on the weakness of using one ephemeral shared key between parties
   - Keys must be generated often
   - Key distirbution is a problem...as there is only one key.  Secure methods such as out of band key sharing is a commmon method of sharing keys in a secure manner.
   - Are SUPER FAST. 1000x -> 10,000 faster than Asymmetric Cryptography
   - Opposite and related keys must be used in tandem to encrypt and decrypt
     - public key encrypts
     - private key decrypts
     - private key encrypts
     - public key decrypts


| Number of participants | Number of symmetric keys required | Number |
|------------------------|-----------------------------------|--------|
| 2                      | 1                                 | 4      |
| 3                      | 3                                 | 6      |
| 4                      | 6                                 | 8      |
| 5                      | 10                                | 10     |
| 10                     | 45                                | 20     |


Fromula for connectin **N** parties using symmetric encryption keys

(N*(N-1))/2
In [13]: N = 20

In [14]: (N*(N-1))/2
Out[14]: 190




### Some other things about Asymetric Cryptography
1. addition of new users requires the generation of only one public-private key pair
2. Users can be removed far more easily from asymmetric systems(via key revocation mechanisms)
3. Key regeneration is required only when a user's private key is comporomised
4. Asymmetric key encryption can provide
   1. Integrity
   2. Confidentiality
   3. Authentictation
   4. anti-repudiation
      1. Creating digital signatures

   5. Key distribution is a simple process.
      1. Users who want to particpate in the systme simply make their public key available to anyone with whome they are want to communicate.
      2. there is no method by which the private key can be derived fromthe public key.

   6. No preexisting communication link needs to exist.


| Symmetric            | Asymmetric                                                                |
|----------------------|---------------------------------------------------------------------------|
| Single shared key    | Key pair sets                                                             |
| out-of-band exchange | In-band exchange                                                          |
| Not scalable         | Scalable                                                                  |
| Fast                 | Slow                                                                      |
| Bulk encryption      | small blocks of data digital signatures digital envelopes digital certs   |
| Confidentiality      | Confidentiality Integrity non-repudiation(via digital certs) authenticity |






Hashing Alorithms
   - Cryptosystems can provide digital signatures(Asymetric) when used with a message digest
   - A message digest is a summary of a message's content(like a check-sum)
   - A message digest is also known as a **hash**
   - It is nearly impossible to unencrypt a hash(it is one way)
   - When a hash function produces the same value for two different methods...it's called a **Collision**