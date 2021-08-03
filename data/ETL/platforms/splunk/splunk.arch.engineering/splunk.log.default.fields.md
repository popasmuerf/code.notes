## Getting Data In.........
[source](https://docs.splunk.com/Documentation/Splunk/8.2.1/Data/Aboutdefaultfields)
### About default fields (host, source, sourcetype, and more)

When Splunk software indexes data, it tags each event with a number of fields.  These fields become part of the index [event data](https://docs.splunk.com/Documentation/Splunk/8.2.1/Data/Aboutdefaultfields).

#Default Fields serve a number of purposes:

>   **index**
    -   Identifies the index in which the event is located(why is this important ?)
>   **linecount**
    -   describes the number of lines the event contains

>   **timestamp**
    -   specifies the time at which the event occured

Splunk software uses the values in some of the fields, particulary **sourcetype**, when indexing the data
in order to create events properly.  Once the data has been indexed, you can use the default fields in your searchers

| Source Type     | Description                                       |
|-----------------|---------------------------------------------------|
| access_combined | For NCSA combined log format HTTP WEb server logs |
| apache_error    | For standard Apache Web server error logs         |
| cisco_syslog    | cisco_syslog                                      |
| websphere_core  | A core file export WebSphere                      |

For information about default fields from the search
prespective, see  [Using Default Fields](http://docs.splunk.com/Documentation/Splunk/8.2.1/Knowledge/Usedefaultfields)

We can also specify additiona, custom fields for inclusin in the index.  See [Create custom fields at index-time](http://docs.splunk.com/Documentation/Splunk/8.2.1/Data/Configureindex-timefieldextraction)



### Defining host, source, and sourcetype...
*   host
    An event host value is typically the 
        -   hostname
        -   IP address
        -   (or) FQDN

    of the network host from which the event orginated.
    The host value lets you locate data originating from a specific device.
    [About hosts][http://docs.splunk.com/Documentation/Splunk/8.2.1/Data/Abouthosts]

*   source
    The source of an event is the name of:
        -   File
        -   Stream
        -   other input
        -   etc
    For data monitored from files and directories, the value of the source is the full path...for example
    ```
        /archive/server1/varf/messages.0
        # or
        /var/log
    ```
    The value of source for network-based data sources is
    the protocol and port...for example
    ```
        DUP:514
    ```

    Events with the same cource type can come from different sources, for example, if you monitor 
    ```
        source=/var/log/messages
    ```
    and recieve direct syslog input from udp:514
    If you search **sourctype=linux_syslog**, events from both of those sources are returned.


    
*   sourcetype
    The sourcetype of an event is the format the data inputfrom which it originates such as
        -   access_combined
        -   cisco_syslog
        -   etc
    The source type determines how your data is to be
    formatted.  For more information on source types, see
    [Why sourcetypes matter](http://docs.splunk.com/Documentation/Splunk/8.2.1/Data/Whysourcetypesmatter)
    ```

### Source vs sourcetype
Source and source type are both default fields,
but it should be emphasized that they are two entirely
different things.

>   source : is the name of the file, stream, or other
    input from which a particular event originates

>   sourcetype : determines how Splunk processes the
    incomming datastream into indvidual events according
    to the nature of the data.



### Source type
A default field that identifies the data
structure of an event.  A source type determines
how Splunk Enterprise formats 
the data during during
the indexing process.

### More on how sourcetype's work....
The indexer identifies and adds the source type
field when it indexes the data.  As a result,
each indexed event has a **sourcetype** field

Use the sourcetype field in searches to find all 
data of a certain type(as oppoed to all data from 
a certain source)


### Examples of source types
    access_combined
    cisco_syslog


## Pre-defined source types
Splunk Enterprise comes with a large set of 
predefined source types, and it assigns a source
type to your data.  You can override  this
assignment by assigning an existing source type or
creating a custom source type.



#### Common Source types....

| Source Type     | Description                                       |
|-----------------|---------------------------------------------------|
| access_combined | For NCSA combined log format HTTP WEb server logs |
| apache_error    | For standard Apache Web server error logs         |
| cisco_syslog    | cisco_syslog                                      |
| websphere_core  | A core file export WebSphere                      |

### Why source types matter....
The source type is one of the default fields tht Splunk platform assigns to all incoming data.  

It tells the platform what kind of data you have, so that it can format the data intellgently during indexing.

Source types also lets you categorize your data for
easier searching.


## Override host assignment

**You might want to change your default host assignment when:**

> You load archive data in bulk that was originally generated from a different host and you want those events to have that host value.

> You forward data from a different host. (The forwarder assigns its host name unless you specify otherwise.)
You are working with a centralized log server environment, which means that all of the data received from that server will have the same host, even if it originated elsewhere.

For detailed information about hosts, see the chapter Configure host values.
[Override sourcetype assignment](http://docs.splunk.com/Documentation/Splunk/8.2.1/Data/Abouthosts)

**You might want to change your default sourcetype assignment when**:

    Splunk software cannot automatically format the data properly, resulting in problems such as wrong timestamping or event linebreaking.
    You want to apply source types to specific events coming through a particular input, such as events that originate from a discrete group of hosts, or even events that are associated with a particular IP address or userid.

There are also steps you can take to expand the range of source types that Splunk software automatically recognizes, or to simply rename source types. 





#### Case study:


I have installed Splunk version 5.0.2 and a universal
forwarder on one of the application servers to
forward glassfish logs to splunk central servers.


After adding a monitor I see all the glassfish log 
files as individual sources on the Splunk Search
dashboard.  Instead I visualie the log data to be
grouped into multiple logical/custom categories.

1. Is there a way to tag log data while adding a monitor?
2. Log files could then have multiple tags which could be seen as different source types.  Logs from differnt servers taggd with the same tag would be aggregated under the same group.
3. Is there a sway to customize the search dashobard to remove the source section ?  Our search use cases would
4. never invole search through indivicual source files
5. instead of search would mostly be done on a group of source files ?

### Answer 

1. The standard way to label data in Splunk is the **sourcetype** field, with a sourcetype setting in your 
```
monitor stanza:
[monitor:///var/log/glassfish]
sourcetype=glassfish
```

**source**, **sourcetype** and **host** are all fields that can be tagged like any other in Splunk.

2. You can customise the dasboard by editing the XML for the **dashboard_live** to change the summary page.  For example, you could replace the searchy with a query using the [rest command](http://docs.splunk.com/Documentation/Splunk/5.0.2/SearchReference/Rest) to get a list of tags, like so: **| rest /services/saved/tags count=0 | search field_name_value=host* | rename tag_name as tag | fields tag**  however this isn't recommened.
3. We can't delete sources or sourcetypes as these are metadata about the indexed events....however we can [alias sourcetypes](http://docs.splunk.com/Documentation/Splunk/5.0.2/Data/Renamesourcetypes) to a new name