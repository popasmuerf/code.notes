(source)[https://medium.com/@sankar.p/how-grpc-convinced-me-to-chose-it-over-rest-30408bf42794]

## When to use gRPC over REST


## Why REST ?


As REST is most preferred for microserverices architecture today, 
it has some distiince advantages

#### REST Pros
1. Easy to understand
2. Web infrastructure is already built on top of http
3. Tools for inspection, modification, testing are readkly available.
4. Loose coupling between client and server makes changes relatively easy.
5. There are a lot of frameworks in most of the widely used languages to create REST APIs
6. HTTP status codes are well defined and help in identifying causes of problems
7. HTTP status codes are well defined and helps in indentifying cause of problems

#### REST Cons

1. Client libraries need to updated everytime the API is updated(??? not sure
about this.  It depends on the nature of the API)
2. Straming is difficult and its highly impossible inmost of the languages (hummmm
I call bullshit.  Every major streaming service does so over HTTP)
3. Duplex streaming is not possible(I need to look this up....but I accept this for now)
4. Hard to get multiple resources in a single request(This is fair)
5. Need semantic versioning whenever the API contract needs to be changed(that the case with any app)
6. Will always need some kind of client.



## Protobu or Proto: 

Google protobuf or proto is jus a mechanism for serializing sturctured data.
Proto is smaller, simpler, faster and language neutral.  Yuo can see this similar to JSON or XML but its smaller and
faster comparred to it.


1. Language agnostic
2. Machine Reaable: Protobuf can be used to exchange messages between
services and not over over browsers because proto's are binary or machine readabler and not human readable
(LOLz whut ? what does protos being binary blobs have to do  intra service communication ?  )
3. Provides Generators to Serialize or Deserialize: 
Protobuf can easily compiled to source code (Currently it supports 8 different languages 
	- Java
	- Objective-C
	- Python
	- C#
	- Ruby
	- Go
	- C++)
with protobuf compiler (call it as protoc) and with which serialization or deserialization is 
easier and ther ed is no need o fhand parsing.

3. Supports types and Validations: 
Unlike JSON, we can specify field types and add validations for the same in the .protofile


4. Lesser Bilerplate code: Since it supports types and has source code 
generators, we don't need to write much of the boilerplate code foor hand
parsing, the response.  Supports interface to RPC: 
if you want to use your message types with an RPC(Remote Procedure Call) system, you can 
define an RPC service interface in a proto file and the protocol buffer compiler
will generate service interdface code and stubs in your chosen language





Human Readable      XML		JSON   Proto
---------------------------------------------------------------------------------------------------------
Browser consumable| Yes     | Yes | No
JS Support		  | Yes     | Yes | No
Data Security     | None    | None| Difficult to decode without knowing schema
Processing Speed  | slow    | slow| fast
Cost              | high    | high| low
Interfaces for RPC| No      | No  | Yes
Validations       | No      | No  | Supported via keywords



//Example


package greetor ;

option java_package = "com.thoughtworks.greetor"
option java_outer_classname = "GreetorProtos"
option java_multiple_files = true ;

//Declaration for rpc service 

service Greetor{
	rpc greetPerson(GreetorRequest) returns 
}






















