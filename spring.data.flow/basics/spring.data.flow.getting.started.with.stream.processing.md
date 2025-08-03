(Getting Started with Stream Processing)[https://dataflow.spring.io/docs/stream-developer-guides/getting-started/stream/]



# Getting Started with Stream Processing 

Spring Cloud Data Flow provides over 70 prebuilt streaming applications that you can use righ away to 
implement common streaming use cases.



The The [Installation guide](https://dataflow.spring.io/docs/installation/)  includes instructions for registering these prebuilt applications with Data Flow.


## Stream DSL overview


- Stream Creation options 
	* Domain Specific Language (DSL) through the shell or the dashboard
	* Programmatically in Java through teh shell or the dashboard
- Dashboard
	* drag and drop applications on a palette and  connect them visually
	* programmatically via sheel or dahsboard
- DSL
	* modeled after the Unix pipes and filter syntax 
		- Exmaple 

			syntax : 

				http | log  //piping data from an HTTP post to the messaging middleware

			Explanation: 

				- Piping some http POST data to the messaging middle ware
				- the log application recieves the message with that data form the messaging middleware and logs it to the terminal
				- Each name in the DSL is associated with an application throught he application rgistration process.
				- The applications are connected througha a `|` pipe symple that represents the messaging 
				middle ware, which acts as the "pipe" between the applications


	* The following diagaram shows the Stram processng life cycle : 

																					source.time= maven://o.s.c.s.app:time-source-rabbit:2.1.1
																					source.time.metadata=maven://o.s.c.s.app:time-source-rabbit:jar:metadata:2.1

																												|
																												|
																												|
																												|
																		(register metadata)						|
																			------------------------------->{Apps Registry}<----------- (Get Artifiact)
																			|	                                                      |
																			| 														  |
																			|														  |
																			V                                                         V
			time | transform | log -------->{Data Flow API}-----------{Data Flow Server}---------------------> {Skipper API}-----{Skipper Server}-----|
																																					  |
																																					  |
																																					  |
																																					  |
																																					  |
																																					  |
																																					  |
																																					  |
			      -------------------------------------------------------------------------------------------------------------------------------------
			      |
			      |
			      |--->{Deployer SPI}----> (Platforms: Local,Kubernetes, Cloud Foundry) -----> {time} ----> {transform} -----> {log}