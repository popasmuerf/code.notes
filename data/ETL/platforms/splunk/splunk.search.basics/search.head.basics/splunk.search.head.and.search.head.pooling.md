## Understand splunk search head and search head pooling

[source](https://www.learnsplunk.com/splunk-search-head.html)

**Splunk search head**
is the main GUI/front end for splunk, commonly accessed via browser.  Search head is somewhat similar to google where you have to enter
keywords and click on search to get expected
result.  Like any other splunk components you can install splunk search head on 
a seperate server with another splunk component on the same server.

There is no separate installion file for search head, you just have to enable splunkweb service on the splunk server to enable it.


Search Heads can run searches across multiple Indexers at the ssame time.  Splunk web services are responsible for providing GUI access to
splunk through the browser.  Splunk Web Services is a web application written using a combination of Python, AJAX, XML, XSLT etc.

Spunk is one of the few products that still uses C++ and Python and thus provides sometwhat of an advantage w/r to processing large amounts of data quickly(this is the author's of this information nonsense assertion...not mine)



### How many search heads to install ?

Basically splunk searches for logs in splunk indexers.  Search head is directly connected to indexers in background. 


## How search head works -- How search head searches for logs ?


Basically splunk searches 