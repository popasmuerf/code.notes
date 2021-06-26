   1. Stateful
   2. Each firewall rule has priority (0-65535) assigned to it
   3. Priority
      3.1. highest -> 0
      3.2. lowest -> 1
   4. Priority can be overriden
   5. Default implied rule with lowest priority(65553)
      5.1. Allow all egress
      5.2. Deny all ingress
      5.3. Default rules can't be deleted
      5.2. Default rules may be overriden via defining new rules  with priority 0-65534
    6. Default VPC has 4 additional rules with priority 65554
      6.1. Allow incoming traffic from VM instances in same network (default-allow-internal)
      6.2. Allow incoming TCP traffic on port 22(SSH) **default-allow-ssh**
      6.3. Allow incoming TCP traffic on port 3389 (RDP) **default-allow-rdp**
      6.4 Allow Incoming ICMP from any source on the network default-allow-icmp

      