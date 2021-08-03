## Organizing Log Data In Splunk
[source](https://docs.splunk.com/Splexicon:Source)
### source
A default field that identifies the source of an event...that is, where the event orginated.  In the case of data monitored from files and directories, the source consists of the full pathname of the fiel or directory.

In the case of a network-based source,t he source field consists of the protocol and port such as **UDP:514**

Each event has a source field.  The indexer geenrates the source field at index time.  Searches ofthen ust eh source as a criterian.
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