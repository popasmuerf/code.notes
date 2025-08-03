[Security Pillar - AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html)

## Security




- Security should always be a top priority in both on-premises and cloud architectures.

	*  Implemente a strong identity foundation
	* Apply security at all levels
	* Automate security best practices 
	* Protect data in transit and at rest 
	* Keep people away fromd ata
	* Prepare for security events 



#### AWS Well-Architected Framework 

You can find the security pillar checklist from the 
Well-Architected tool below, which has ten questions with one or more options 
relevant to your workload :

	- Evaluate external customer
	- Evaluate internal customer needs
	- Evaluate governance requirments
	- Evaluate compliance requirements
	- Evaluate threat landscape
	- Evalute tradeoffs
	- Manage benefits and risks
	- None of these

Answering these questions will help you to determine the current stte of your workload 
security and highlight if there are any gaps in the WAR report such as `High-Risk Issues (HRIs)`

You can find more details on the security pillar by reffering to the AWS Well-Architected Framework 

[Security Pillar - AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html)



To gain practical experience in implementing optimal seucrity practices, it is advisable to complete the well-architeted secuity labs



## We can calculate the probability of Mean Time Between Failures (MTBF):


	MTBF =  (total-elapsed-time - sum-of-downtime) / number-of-failures


MTBF represents the time elapsed between component failures in a system.
The metric used to measure time in MTBF is typically hourses but it can 
also be measured in other unites of time such as 
days, weeks, or years depending onthe the specific sytem,, component, or product being evaluated.

Note:  Hypothetically with respect to logic based systems.....if we are just purely speaking on 
logic....there is no MTBF if the logic is correct.  `faulty logic` is actually a misnomer.....logic is logic.


So for example...if we have a public facing web archtecture that is composed of 

	* Front end
		- Node.js

	* Middle tier
		- Spring Boot 

	* Persistance 
		- MySQL


So we have 3 components....what is the MTBF if we only conscider software ?





