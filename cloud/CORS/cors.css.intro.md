#CORS
url:[https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy]
url:[https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy]

Cross-origin resource sharing or CORS isd a mechanism that allows AJAX reuests to
circumenvent same orgin limits


##A bit of history
--------------------------------------------------------------------------
The ability of a browser to request a resource froma server without reloading
the page hasn't been available from day one.



Back in the year 2000, websites that needed to do any kind of background request
used alternative techniques.  One of these primitive tecfhniques involved the use
of an iframe.  Iframes, like JavaScript were available in major browsers in 1996.



If we point our browser to http://localhost:3000/iframe we will see a list of 
results.  As intended, clicking in the button makes the page refresh the list of 
results but avoiding a full page reload.


Asynchronous JavaScript and XML
----------------------------------------------------------------------------
To avoid this hackyness(back in 1999) Microsoft added XMLHttpRequest as a JavaScript
extension to Internet Explorer 5.  With XMLHttpRequest htere's no need 
to use an iframe to do background requests.


It remained quite as a properietary rarity until the early 
when several webapps started using it.


Shotly afterwards, somehow the techniue was names as **AJAX**.  the name is rather 
misleading, as it allows not only the page to request a resource asynchronously, but
synchronously too.  Evenmore, it is not restricted to XML, because
JSON or plain HTML can be sent as well....but AJAX is widely accepted.

The XMLHttpRequest is conveniently wrapped in jQuery by .ajax, .load, .get and .post
methods.

Back to our example app, in http://localhost:3000/ajax clicking the button will reolad 
the results.  Exactly like the previous example, just using the new technique


+--------------+            +---------------+
|  Browser     |            | Server        |
|              |            |               |
|              |            |               |
|              |            |               |
+------+-------+            +-------+-------+
       |   GET Request              |
       +--------------------------->+
       |   GET Response             |
       +<---------------------------+
  +----+ update vsectionv           |
  |--> |                            |
+------+-------+            +-------+-------+
| Browser      |            | Server        |
|              |            |               |
|              |            |               |
|              |            |               |
|              |            |               |
+--------------+            +---------------+





**However, AJAX is an open door for insecurity.  Yur page may contain a third party script that
silently sends your session cooke to another server**


##Same Origin policy
To prevent security risks, the browser enforces a same origin policy


##What is Same-ogirin policy ?


The same-origin policy is a critical security mechanism that restricts
how a document or script loaded from one origin can interat with resource from another
origin.  It helps isolate potentially malicious documents, reductin gpossible attack
vectors.


###Definition of an orgin
---------------------------------------------------------
Two URLs have the same origin if the protocol, port(if specified), and host are the
same for both.



the following table gives examples of origin comparision with the URL

        **http://store.company.com/dir/page.html**

**URL**                                   **Outcome**     **Reason**
----------------------------------------|---------------|-----------------------
http://store.company.com/dir2/other.hmtl|  Same origin  |   Only path differs
----------------------------------------|---------------|------------------------   
http://store.company.com/dir/inner      |  Same origin  |   Only path differs
/another.html                           |               |
----------------------------------------|---------------|----------------------- 
https://store.company.com/page.html     |  Failure      |   Protocol differs            
----------------------------------------|---------------|----------------------
http://store.company.com:81/dir/page.htm|  Failure      |   Port differes
----------------------------------------|---------------|-----------------------
http://news.company.com/dir/page.html   |  Failure      |   Different host





###Inherited origins
----------------------------------------------------------
Scripts executed frm pages with an **about:blank**  or **javascript:**
URL inherit the origin of the document conteaning that URL, since these types of URLs do not contain
information about an origin server.




##Exceptions in Internet Explorer





