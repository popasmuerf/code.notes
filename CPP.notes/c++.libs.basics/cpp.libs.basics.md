[Static vs Dynamic Libraries](https://www.bogotobogo.com/cplusplus/libraries.php)

A atatic library contains object code linked with an end-user application, and then becomes part of that executable.
A statick library is sometimes called an acrchive since it is just a package of compiled object files.  These libraries are in directions
sauch as 
	- /lib 
	- /usr/lib 
	- /usr/local/lib 
	
	
	
### How static libs are linked
	- Linker resolves various function references from the main program to th emodules in the static lib 
	- Linker extracts copi8es of the required object modules from the library and copies these into the resultant executable file 
	- Linking finishes up and is known as **static linking** or **early binding** AKA known as an archive
	- Originally only static libs existed.  Static linking must be performed when any modules are recompiled
	
	
	|Application code|--------
							 |---------------> Executable + Library Code
							 |
	|Static Library|----------
	
	
	
All of the modules required by a program are sometimes statically linked and copied into the executable file.  
This process, and the resulting stand-alone file, is known as a static build of the program.