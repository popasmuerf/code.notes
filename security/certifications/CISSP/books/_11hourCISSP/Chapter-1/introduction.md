## Introduction

-   The common thread is risk, which is
    part of all Cyber-Security job descriptions

-   The Security and Risk Management domain
    focuses on risk analysis and mitigation.
        *   Security Governance
        *   Organizational structure

-   Risk = Vulnerability + Threat
-   Vulnerability is a weakness...that may be a 
    a problem or not...dependining on the context
    that it exists in......from zero-day to known
    vulnerabilities.
-   Asset management is the method by which we detect 
    and identify vulnerabilities

-   Asset management can be handled by actual apps designed specifically for this purpose like Qualys, GCP asset manager, or apps that can somewhat fill that role like ELK and Splunk

-   Threat modeling?  
-   Risk analysis
    -   Budget analysis
    -   How much is the asset costing me now
    -   How much will it cost me for any asset 
        compromise.....
    -   single_lose_expectancy = asset_cost + .10(asset_cost)
        -   lost of income
        -   lose of revenue
        -   single_lose_expectancy(SLE)
    -   SLE vs ALE

-   sUPPLY Chain risk management
-   ISSO
-   Castellan/Operation
-   Monitor
-   Operational Control
-   Standards
-   Guidelines
-   Best practice
-   Due Care vs Due Dilligence
-   Threat vulnerability
-   Thread assessment
-   quantitative analysis




## Cornerstone Information Security Concepts

Before we can explain access control, we 
must define cornerstone information security concepts.
These concepts provide the foundation upon which the
eight domains of the Common Body of
knowledge are built


Confidentiality, integrity, and availability are
referred to as the CIA triad, which the cornerstone
concept of information security. 

#### Confidntiality
    -   Seeks to prevent unauthorized disclosure
    -   Keeps data secret
    -   Theft of PII is an example of lack of confidentiality
#### Integrity
    -   Seeks to prevent unauthorized modification of data
    -   In other works, integrity seeks to prevent unauthorized
        write access to data or system configuration
    -   There are two types of **Integrity** within his context
        -   System Integrity 
        -   Data Integrity
#### Availability
    -   Ensures that data is available when needed.
    -   Systems need to be usable(available) for normal business
    -   An example of attacke on avaliability would be a denial
        of service DoS attack or a zero day exploit that encrypts the data of a system thereby making he 
        system completely useless

## Disclosure, alteration, and destruction (DAD)
...is an alternate description of the CIA triad

#### Disclosure
    -   Unauthorized release of information
#### Alteration
    -   Unauthorized modification of data
#### Destruction
    -   Destruction of data...data that is unrecoverable is 
        essentially destroyed
        Systems that are DDosed into oblivion are essentally
        within that period of time "destroyed


The CIA triad, which the cornerstone concept of information security...the three legged stool upon which security
is built.  The order of the acronym  may change to avoid
association with a certain intelligence agency. 

## Identity and Authentication, Authorization, and Accountability 

The term AAA is often used to described the 
cornerstone concepts of authentication, authorization,
and accountability.  Left out of the *AAA* is **indentifcation**
before the 3 AAAs can be achieved

#### Identity and authentication
Identity is a claim:
    If your name is "Foo" then
    you identify yourself via asserting that
    your name is "Foo"

  - Proving an identity claim is called **authentication**
  - You authenticate a claim to identity via supplying          addtional information that reasonably lends to weight to your claim of identity
  - Additional data that reasonably proves your claim of identityare
    - passwords
    - Security questions(whom's answers essentally  are also passwords)
    - unique 


#### Authorization
Authorization describes the actions ou can perform
on a system once you have been identified and authenticated.
Actions may include reading, writing,
or executing files or programs

#### Accountability
Acoountability holds users accountable for their actions.
This is typically done by logging and analysing  log data
Enforcing accountability helps keep honest people honest.
For some users...knowing that data is logged is not enough to provide accountability; they must know that data is logged and audited, and
that sanctions may result from violation of policy.


## Nonrepudiation

Nonrepudiation means a user cannot deny(repudiate)
havingpeformed a transaction.  It combines authentication
and integrity;  nonrepudiation authenticates the indentity of a user who peforms a transaction and ensures theintegrity of that traansactin.  You must have both authentication and integrity to have nonrepudiation; for example, proving you signed a contract to buy a car (authenticating your identity as the purchaser) is not useful if the car dealer can change the price from 20k to 40k(violate the integrity of the contract).  For example, immutable or signed data would be an example of integrity and identification would be your login id and password...


## Least Privilege and need to know
Self explanitory


## Subjects and Objects
A subject is an active entity on a data system.  Most examples of subjects involve people acceing data files.
However , computer programs can be subjects as well.  A DLL or a Perl script that updates a database file with new information is also a subect

An object is any passive data within the system.  Objects can range from documents on physical paper to database tables to text files.

The important thing to remember about objects is that are passive whein the system;  They do not change the state of other objects.....what is and is not either a subject or object is contextual


## Defense in Depth


Defense in depth(also called layed defense) applies
multiple safeguards(also called controls,which are measures taken to recuce risk) to protect an asset.  Any single security control may fail; by deploying multiple controls, you improve the confidentiality, integrity
and availability of your data.




## Legal and Reulatory Issues
Though general understanding of major legal systems
and types of law is important, it is critical that
information security professionals understand the
concepts described in the next section.  With the
ubiquity of information systems, data, and applications
comes a host of legal issues that require attention.

## compliance with Laws and Regulations
Complying with laws and regulations is a priority
for top information security management, bot in the
real world and the CISSP exam.  An organization must be
in compliance with all laws and regulations that 
apply to it.  Ignorance of the law is never a valid excuse for breaking the.


## Major Legal Systems
In order to begin to appreciate common legal concepts
at awork in today's global economy,an understanding of the major legal systems is required.  These legal systems
provide the framework that determines how a country develops laws pertaining to information systems in the first place.  The three major systems of law are
-   civil
-   common
-   religious












