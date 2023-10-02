(source)[https://www.freecodecamp.org/news/an-introduction-to-docker-tags-9b5395636c2a/]

docker tags are just an alias for an image ID
The tag's name must be an ASCII character string.
In additionk, the tag names must not begin with a period or a dash, and they can only contian 128 characters.




### Docker tags typically look something like this :

		image_name:1

##### Syntax break down

<image_name> : <tag>

	the tag isn't always specified when tagging images, but we will ge to the bottom of that later.



### What are Docker tags exactly ?

	-> tags convey useful information about a specific image version/variant
	-> They are aliases to the ID of you rimage which often look like this:

		f1477ec11d12

	...this is why you need aliases. Cause who is going to see this and know what it represents ?
	-> A good analogy is how Git tags refer to a particular commit in your history 


### Common cases for tags 

1. When building an image, we use the following command: 

	docker build -t username/image_name:tag_name .

Let's unpack this 
	-> The Docker daemon fetches the Docker file present in the current directory
	-> docker daemon then builds the image 
	-> docker daemon labels the image being built with the specified tag
	-> if you run the command 

		docker images
	you should see an image whose repository is username/image_name where the tage is the tag_name

	-> username/image_name is not a mandatory format for specifying the name of the image, however it is a usefule and common
	convention used to avoid tagging yoru image again when you need to push it to a registry.

	-> You can name the image anything you want, but there are some caveats 
		--> The Public Docker registry restricts you are restricted to a 2-level naming hierarchy
			---> you image cannot have a name like a/b/c:1 
			---> this restriction does not exist for private registries 
			---> again..it's not necessary to have a tag name....but you should.  We will get into why later


2. Explicityly tagging an image through the tag command

	dockr tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

This command just creates an alias (a reference) by the name of the TARGET_IMAGE 
that references the SOURCE_IMAGE.  That's it.  That's all it does. 
It is like assigning an existing image another name to refere to it.   Notice how the tag
is specified as optional here as well, by the brackets.



### What happens when we don't specify tags ?

	-> Whenver an image is tagged witout an explicti tag
		--> it is given the latest tag by default.
		--> this can cause a lot of confusion
		--> the latest tag in a sense is also the default tag within this context
		-->  A lot of confusion around **latest** is caused due to the expectation that 
		it is the latest version of the image, especially in Dockerfiles.

### Scenario 1: 
Suppose the following statement is present in our Dockerfile:

	FROM debian

Since we didn't specify any tag, Docker will add the **latest** tag and try to pull the 
image 


	**debian:latest** 


### Scenario 2: 

	FROM debian:9.3

Since the tag is explictily mentione here, Docker will pull the Debian image
tagged 9.3


Another thing to keep in mind is that there is no rule which states that an image needs to have just one tag.
An image can have multiple tags and the are usually used to specify major an dminor versions 

For example:

Debian stables/slim/Dockerfile
	stable-slim 
	
Debian  stretch/Dockerfile
	streatch 
	stretch-20171210,
	9.3,
	9,
	latest 


