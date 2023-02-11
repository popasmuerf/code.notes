1. We have a new scanner deployed in test-aaa.  David and I will be linking it to Tenable and testing it out after this meeting
2. We are goin to run DB scans in test-ill2
3. We have one more scanner to go w/r to deployment AAA-prod(this db isn't showing up via the GCP connector) 
4. Fortify issues have been escalated by my assigned FF support engineer last Week.  No update yet.
5. Pickup any HG/SCA request 
6. David and I are going to get up and discuss the HG change request workflow.
7. David and I are going to discuss Tenable Regex work.
8. David and I are going to devise a concise process to get all associated technical PoCs for testing Tenable agent/scanning 
testing.

1. New scanner deployed and running in GCP project Test-AAA 
2. New scanner planned for deployment in GCP project Ill2-Prod
3. Albacore is working on DB client response issues for both project Test-AAA and Test-Ill2


1. review the approved hardening guide process. 
2. 

XOR
----------------------
1 || 1   --> 0
1 || 0   --> 1
1 || 0   --> 1
0 || 0   --> 0



### Protocol Governance 
	- describes the process of selecting the right method (ie, cipher) and implementation
	- digital signatures provide integrity but not confidentiality (you know what the key is, likely a provided PGP key)
	- Symetric Ciphers are used for confidentiality primarily :
		--> encrypting hardrives
		--> encrypting files, etc.
	- AES is preferred over DES do to cryptographic strength
	NOTE: Do not confuse DES, AES, et all with symmetric and asymetric cryptography.  
### Types of Cryptogray 
	- symmetric 
		--> single key
		--> FASTER than Asymmetric algorithms
		--> less secure due to key sharing
		--> Strong crypto strength
		--> used for general confidentiality typically
	- asymetric
		--> multi-key(two public/private key exchange)
		--> AKA "secret key encryption"
		--> used for confidentiality communication between remote hosts typically.  Think TLS/SSL, SFTP, etc. 
		--> SLOWER than Symmetric algorithms 
		--> STRONGER per bit Symmetric algorithms 
		
		
### Stream and block ciphers 
	--> Stream ciphers encrypt one bit at a time
	--> Block ciphers encrypt in blocks of bits.  typically 64 or 128 bit blocks
	--> DES(Data Encryption Standard) uses 64 bit blocks 
	--> AES (Advanced Encryption Standard) uses 128 bit blocks 
	Note: DES 64 bit blocks
		  AES 128 bit blocks
	
### Initialization vectors and chaining
	--> Some symetric ciphers use initialization vectors(IV) to ensure 
	    that the first encrypted block of data is random(meaning it could be the first block, or not
	--> IVs ensure that identical plain texts encrypt to a different ciphertext 
	--> Two messages that begin the same will encrypt the same way up to the first difference
	    IVs solve this problem.
		
	--> Chaining (called feadback in stream modes)
	--> Chaining seeds the previoius encrypted block into th enext block ready for encryption.
	--> This destroys patterns in the resulting ciphertext.
	--> DES Electron Code Book (ECB) mode does not use an initialization vector or chaining and 
	    patterns can be clearly visible in the rsulting ciphertest
	--> DES ECB provides relatively weak confidentiality
	
### DES
	--> Data Encryption Standard 
	--> Describes the data encryption algorithm (DEA)
	--> Designed by IBM
	--> Based on IBMs Lucifer symmetric 64 bit block cipher 
	--> Uses a 56-bit key.
	--> Commonly refferred to as an algorithm, however it is actually a published standard that 
	    describes DEA.  REMEMBER THIS!!!!
	--> DES has 5 different modes 
	--> Primary diffrences between modes 
		----> Block versus emulated stream(you can have a block of 1 bit hypothetically)
		----> Use of IV 
		----> Error propagation 
		
		
### Modes of DES (5 total)
	--> Electronic Code Book (ECB)
		----> Simplest and weakest
		----> 64 bit blocks 
		----> 56 bit key
		----> 16 rounds of encryption
		----> No use of an IV
		----> No use of chaining 
		----> Identical plain text provides identical ciphertext 
		----> susceptable to brute force attacks using modern CPUs/GPUs
		----> There is no chaining so there is no propagation of errors.
	--> Cipher Block Chaining (CBC)
		----> Block mode
		----> XORs previous encrypted block with next plaintext block to be encrypted 
		----> First Encrypted block is used as the IV that contains random data.
		----> Chains
		----> Chaining algorthim destroys patterns
		----> Propagates encription error  in one block will cascade  to subsequent block 
		----> Error propagation destroys data integrity
	--> Cipher Feedback (CFB)
		----> Stream mode 
		----> Uses feedback(Chaining if it were block based) to destroy patterns
		----> Uses an IV full of nonsense data to encrypt the first bit 
		----> like CBC, errors propagates and will destroy data integrity 
	--> Output Feedback (OFB)
		----> Stream ?
		----> differs from CBC and CFB due to nature of it's feedback 
		----> Uses previous ciphertext for feedback 
		----> Previous cipher text is actually a sub-key; is XORed to the plain text
		----> The subkey is used before it is XORed to the plaintext 
		----> Sub-keys are not subject to propagation encryption errors
	--> Counter Mode (CTR)
		----> uses a counter which has the same advantages of OFB's subkey algorithm as feedback     
		      that destroys patterns and avoid propagation errors 
	    ----> The feedback can be as simple as just incremented numbers so CTR mode can be 
		      executed in parallel.
			  
			  
	--> Modes of DES Summary 
	                                   type		Initialization Vector	Error Propagation
									   -----	---------------------	-----------------
		Electronic code book (ECB)     Block     No 					YES 
		Cipher block chaining (CBC)    Block     YES					YES 
		Cipher feedback(CFB)           Stream    YES					YES 
		Output feedback (OFB)          Stream    YES					NO 
		Counter mode (CTR)             Stream    YES					NO 


### Implementations of DES
	--> Single DES (ECB)
		----> Original implementaion of DES
		----> 64 bit blocks 
		----> 56 bit key
		----> 16 rounds of encryption
		----> Work factor for breaking DES in 1976 was reasonable. No longer
		----> susceptable to brute force attacks using modern CPUs/GPUs


	--> Triple DES
		----> Applies Single DES encryption three times per block
		----> Formally known as TDEA(Triple data encryption algorithm)
		----> 64 bit blocks 
		----> 56 bit key
		----> 16 rounds of encryption * 3 per block
		----> Recommended statndard since 1999
		
	--> International data encryption algorithm
		----> IDEA is a symmetci block cipher
		----> Designed as an international replacement to DES
		----> 64 bit blocks 
		----> 128 bit key
		----> IDEA has patents in many countries
		----> 16 rounds of encryption * 3 per block
	

	
	
### Advanced Encryption Standard (AES)
	--> AES is the current US standard in symmetric block ciphers
	--> 128-bit blocks 
	--> Types/Modes
		----> AES 128-bit
			-----> 10 rounds of encryption 
		----> AES 192-bit
			-----> 12 rounds of encyrption
		----> AES 256-bit
			-----> 14 rounds of encryption

	--> Rijndael AES Implementation
		----> Four functions
			--------> SubBytes
			--------> ShiftRows
			--------> MixColumns
			--------> AddRoundKey
			
			
### Blowfish and TwoFish 
	--> are both symetric ciphers 
	--> created by Bruce Schneier, author of Applied Cryptography 
	--> Blowfish
		----> 64 bit blocks
		----> Key size ranges from 32 - 448 bit keys 
		----> Default key size = 128 bit 
		----> Twofish was an AES finalist
		----> 
	--> TwoFish 
		----> Was an AES finalisht
		----> Symetric cipher 
		----> 128 bit blocks
		----> 256 keys 
		
		
### RC5 and RC6  
	--> create by RSA laboratories 
	--> are both symetric ciphers 
	--> AES finalists
	--> RC5 
		----> 32 bit blocks (testing purposes
		----> 64-bit blocks 
		----> 128 bit blocks
		----> Key size ranges from 0 - 2040-bit keys 
		----> Was later modified to meat AES requirements  
		----> Twofish was an AES finalist
		---->
	--> RC6 
		----> Was an AES finalisht
		----> Symetric cipher 
		----> 128 bit blocks
		----> 128, 192, 2560 bit  keys 	
		

			
# Asymetric Encryption 
	--> Involves two keys 
	--> 1st key :  encryption 
	--> 2nd key : decryption 
	-->  AKA public key encryption 
	--> one key is public 
	--> one key is private
	--> public keys are public and downloadable
	--> public keys cannot decrypt on their own
	--> secret keys are used to decrypt
	--> plaintest that has been encrypted with a private key can be decrypted with the public key
	--> math is what powers assymetric encryption.
	-->
	
	
### Factoring prime numbers 
	An exqample of one-way function is factoring a componsite number into primes.
	Multiplying th eprime number of 6269 by the prime number 7883 resutlst 
	in a composite number of 49,418,527.
	
	Computing 49,418,527 takes less than milliseconds for any modern CPU/GPU.
	finding the inverse(factoring)....that is which two primes where used in the calculation is 
	far more difficult and time consuming.
	Factoring is the bassis of the RSA algorithm.
	
	
### Discrete logarithm. 

A logarithm is the opposite of exponentiation.  computing 7^13  is easy on modern calculator:
96,889,010,407.

Asking if the log of 96,889,010,407 = 7  is far more diffiuclt.
Discrete logarithms apply logarithms to groups, which is a much more difficult. 
Discrete logarithms apply logarithms to groups, which is a much harder problem.

Discrete logarithms to groups which is a much harder problem to solve.
This one-way function is the basis of the Diffie-Hellman and ElGamal asymmetric algorithms.


### Diffie-Hellman key agreement protocol
	--> Asymmetric
	--> Key aggreement allows two parties the security with which to 
	    to agree on a symeetric key  via a public channel. witout 
		any prior key exchange.
	--> Attackers who are able to sniff the entire conversation are unable
	    to dervice the exchanged key.
	--> Diffie_hellman Key Agreement Protocol or key-exchange Invented in 1976
	--> Diffie_hellman uses discrete logarithms to provide seucrity.
	
	
	
### Elliptic curve cryptography (ECC) 
	--> Asemmetric 
	--> ECC leverages a one-way function that uses discrete logarithms.
	    as applied to elliptic curves.
	--> Solving this problem is harder than solving discrete logarithms, so algorithms
	    based on elliptic curve cryptography (ECC).
	--> ECC is much stronger per bit than systems using discrete logarithms alone.
	--> ECC requires less computational resources because it uses shorter keys in comparison to 
	    other asymmetric methods.
	--> Low powered devices often use ECC for this reason.

### Asymmetric methods 
	--> Math lies behind the asymetric breakthrough.
	--> Are all one way functions 
	--> One way functions are easy to compute
	--> Inversing (these) one way functions are difficult to compute.
	
	
### Factoring prime numbers 
	--> An examaple of a one-way function is factoring a composite number into it's prime
	--> Multiplying the prime number of 6269 with prime 7883 resutls in the product of 
	    49,418,527.
	--> Factoring 49,418,527 is computationally difficult.
	