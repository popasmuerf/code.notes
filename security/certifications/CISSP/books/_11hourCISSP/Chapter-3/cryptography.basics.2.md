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
	- Symetric Ciphers are used for confidentiality primarily 
	- AES is preferred over DES do to cryptographic strength
	
### Types of Cryptogray 
	- symmetric 
		--> single key
		--> FASTER
		--> less secure due to key sharing
		--> Strong crypto strength 
	- asymetric
		--> multi-key(two public/private key exchange)
		--> AKA "secret key encryption"
		-->
		
		
### Stream and block ciphers 
	--> Stream ciphers encrypt one bit at a time
	--> Block ciphers encrypt in blocks of bits.  typically 64 or 128 bit blocks
	--> DES(Data Encryption Standard) uses 64 bit blocks 
	--> AES (Advanced Encryption Standard) uses 128 bit blocks 
	
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
			
					

			
			