risk = asset * vulnerability * threat * impact

BIA = business implication analysis



total risk vs. residual risks

total risk = AV * threats * ulnerabilities
residual risk = total risk - controls gap,

Vulnerability and Threats :
    Check the Market:
        - Hack5
        - PWNAGOTCHI
        - HackRF1
        - Great Scott Gadges

Social engineering is your weakest leak
in your Security plan



### Chapter 8Principles of Security Models, Design, and Capabilities

Objectsubjects:
    -   Active entity that makes a request
        to access resource
        -   Authenticated user
        -   REST request

    -   

Closed and Open Systems

Secure Defaults


Fail Securely


Keep it Simple


Zero Trust:
    https://st1.zoom.us/web_client/4eughr/html/externalLinkPage.html?ref=https://www.paloaltonetworks.com/network-security/zero-trust

Privacy by Design

Trust but Verify

Techniques for Ensuring Confidentiality

INtegrity and Availability

Controls

Trust and Assurance


Common Criteria:
    -   assurance that equipment/software/whatever has been certified for Generic security evalution criteria conformity
    -   https://www.commoncriteriaportal.org/


Security Model Terms:
    -   Security Model
    -   Token
    -   Capability
    -   Security Label
    -   Lattice-Based Access Controls
    -   Rainbow Series


Trusted Computing Base
    - Trusted computing base (TCB)
    - HW, SW and controls that work together to enforce security
    - Security


State Machine Modle
    -   Always secure no matter what state the machine is in
    -   Finite State machine (FSM)
    -   State transistion
    -   Secure state machine
    -   the basis for most other security models


Information Flow Model
    -   Focuses on contorlling the flow of information, both direction and type
    -   Based on the stae machine model
    -   Prevent uanuthorized, insecure, or restricted information flow
    -   Controls flow between security levels
    -   Can be used to manage state transistions
    -   Example:
        -   user land security issues should not effect kernel level security issues

Componsistion theories
    -    Explain how  outputs from one system rleate to inputs to another system
    -    Cascading
    -    Feedback

Gant Models:
    -   DAG
    -   Dictates how rights can be passed between subjects
    -   Take rule
    -   Grant rule
    -   Create rule
    -   Remove rule

Access Control Matrix
    -   Table of subjects, objects and access
    -   Columns are ACLs
    -   Rows are capability lists
    -   CAn be used in DAC, MAC, or RBAC

Bel-Lapdula Model 1/2(important!!!!!!!)
    - Bason on DoD multilevel security policy
    - Focuses only on confidentiality
    - Lattice based access control
    - Simple security property
      - No read up (medium level access example)
      - Read down(medium level access example)
      - Write down(medium level access example)
      - No write down(medium level access example)
      - *(star) secirotu [rp[ertu]]

Brewer and Nash MOdel
    - Permit access controls to change dynamically based on a user's previous activity
    - Based on state machine model
    - Pevents conflicts of interest
    - access to conflicting data is temporarily blocked
    - AKA "ethical wall" and "cone of silence"


Goguen-Meseguer Model
    -   Focuses on integrity
    -   The basis of the noninterference model
    -   B

Sutherland MOdel
    -   Focuses on integrity
  
Graham-Denning Model


Harrison-Ruzzon-Ullman modle


Common Criteria
    -   dynamic subjective product evaluation model
    -   ISO 15408-1/-2/-3
    -   Objectives

Authorization to Operate
