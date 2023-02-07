# C vs C++ Header files

In C, the names of the Standard Library header files
usually end in **.h**, such as <stdio.h>, and 
namespaces are not used.


In C++, the .h suffix is omitted for Standard Library
headers, such as <iostream>, and everything
is definted  in the std namespace or a 
subnamespace of std.


The Standard Library headers from C still exist in 
C++ but in two versions.


	- the recommended versions without a **.h**
	suffix but with a **C** prefix.  These versions 
	put everything in the std namespace for example:

		<cstdio> 

	- The old versions with the .h suffix. These 
	versions do not use namespaces.  For example:

		<stdio.h>

The C standard library headers are not guaranteed to 
be immportable with tan import declaration.  To be safe, use


	#include <cxyz>

		//instead of 

 	impport <cxyz> ;




 The following table  shows some of the most common preprocessor 
 directives:


PREPROCESSOR DIRECTOR:
	#include [file]
		FUNCTIONALITY:
			the specified file is inserted into the code at the 
			location of the directive
		COMMON USES:
			Almost always used to included header files so that code 
			can make use of functionality defined elsewhere



PREPROCESSOR DIRECTOR:
	#define [id] [value]
	FUNCTIONALITY:
		Every occurence of the specified
		identifer is replaced with the specified 
		value
		COMMON USES:
			Often used in C to define a constant
			value or a macro.  C++ provides  better
			mechanisms for constants and most types
			of macros.  Macros can be dangerous, so use them
			cautiously 


PREPROCESSOR DIRECTOR:
	#ifdef [id]
	....
	....
	#endif

	#ifndef[id]
	....
	....
	#endif

	FUNCTIONALITY:
		CODE WITHIN THE IFDEF ("if defined") or 
		ifndef ("if not defined") blocks 
		are conditionally indluced or mitted based on whether the
		specified indentifer has been defined with 
		#define
		COMMON USES:
			Used most frequently to protect against circu circular
			includes.  Eachheader file starts with an 
			#ifndef checking the absence of an identifier
			followeed by a #define directive to defijne that identifier.
			The header file ends wian an #endif.
			This prevents the file from being included multiple times.


PREPROCESSOR DIRECTOR:
	#pragma [xyz]
	FUNCTIONALITY:
		xyz is compiler dependent.  Most compilers support a
		#pragma to display a warning or error if the directive is reached
		during preprocessing
		COMMON USES:
			Using preprocessor directives is to avoid 
			multiple includes, as shown here:
				#ifndef MYHEADER_H
					#define MYHEADER_H
					//...the contents of this header file
				#endif 

		If our compiler supports the #pragma **once** directive, and most
		modern compilers do, then this can be rewritten as follows:

			#pragma once 
			// .. the contents of this header file 




			

























