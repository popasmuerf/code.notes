


## Splunk install directory 
    - /opt/splunk
    
    
    (base) mrblack@pop-os:~$ ls -al /opt/splunk
total 2348
drwxr-xr-x  9 splunk splunk    4096 Apr 19 20:04 .
drwxr-xr-x  6 root   root      4096 Apr 18 10:02 ..
drwxr-xr-x  4 splunk splunk    4096 Apr 18 10:02 bin
-r--r--r--  1 splunk splunk      57 Feb 22 07:02 copyright.txt
drwxr-xr-x 16 splunk splunk    4096 Apr 19 20:42 etc
drwxr-xr-x  3 splunk splunk    4096 Apr 18 10:02 include
drwxr-xr-x  7 splunk splunk    4096 Apr 18 10:02 lib
-r--r--r--  1 splunk splunk   85709 Feb 22 07:02 license-eula.txt
drwxr-xr-x  3 splunk splunk    4096 Apr 18 10:02 openssl
-r--r--r--  1 splunk splunk     845 Feb 22 07:06 README-splunk.txt
drwxr-xr-x  4 splunk splunk    4096 Apr 18 10:02 share
-r--r--r--  1 splunk splunk 2269949 Feb 22 07:25 splunk-7.3.9-39a78bf1bc5b-linux-2.6-x86_64-manifest
drwx--x---  6 root   root      4096 Apr 18 10:21 var



Understanding Directory Structure:

-   bin/
    *   directory contains the primary splunk binary as well as various other 
    *   Also contains scripts(Python scripts)
        
-   var/
    *   directory primarily contains all the data that gets indexed as well as
        log files
-   etc/
    *   directory contains all the configuration files as well as all the apps and
        ad ons that you install in splunk
-   lib/
    *   directory contains necessary libraries needed for splunk to run
    
    
Configuration Files Precedence:
-   servername:king ---------------------> local
-   servername:app -----------------------> app
-   servername:default  ------------------> default
