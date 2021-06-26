* Set primary and secondary zones within the same region
* Two instances Primary and Secondary
* All writes/updated from Primary are replicated synchronously to secondary
* Failure will trigger fail over to seconardy instance
* HA configuration does not aloww for Read Replica use
* 