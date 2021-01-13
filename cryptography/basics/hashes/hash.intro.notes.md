#How can hashes be unique if the are limited in number?


##I'm curious, how can for example SHA-256 be unique if there are only a limited number
##of them ?


For clarification:
How many MD5 hashes are there ?
16^32 MD5 hashes can be produced.
16^64 SHA-256 hashes can be produced.
16^128 SHA-512 hashes can be produced.


For more clarification:
assume we want MD5 of all the SHA-256 hashes.
we can have 1632 number of MD5 hashes, while there are 1664 SHA-256 hashes.
we will have 3.4*1038

duplicate MD5 hashes!

And so is for SHA-256 hash, if we calculate SHA-256 of all the SHA-512 hashes, we will have 1.15*1077

duplicate SHA-256 hashes!

Edit: This is not limited to a particular hash like SHA-256.



##Hashes aren't really unique....they are psuedo-unique
-------------------------------------------------------------------------
Where our "issue" occurs is that they are not unique.  It is just very improbable that
they will recoccur.  **Unique** in this context is not meant to meet the requirment
of mathematical uniqueness, but rather meant to mean "unique" as in "the chance of colliding
hashes withen the contexual set of all possible hashes are very, very unlikely"


In terms of human numbers , 2^256 = 115792089237316195423570985008687907853269984665640564039457584007913129639936.

The chances of a collision in whatever context is 1/115792089237316195423570985008687907853269984665640564039457584007913129639936 the
qoutient of which is

8.636168555094445e-78


....statically "0"
