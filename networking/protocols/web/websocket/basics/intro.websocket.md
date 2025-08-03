[Web Socket vs HTTP Intro](https://www.geeksforgeeks.org/what-is-web-socket-and-how-it-is-different-from-the-http/)

# WebSocket 




In the beginning, the Web was built on top of a model that consists of the following:

- The client sending an HTTP request to the web server
- The web sever returning an HTTP response witht he requested resource
- the works really well, and almost eveyr web application is entirely based on this model.

- As web applications got more advanced and pages more dynamic, a new model emerged called Ajax
- Using Ajax, it's possible to perform an HTTP request and get the HTTP respnse without having to 
request and get the HTTP response without having to request and get the HTTP response without having to refresh
the whole page, shich is amazing because pages now can be very dynamic.
- When using JS libs such as JQuery, it becomes even easier.  So we have nothing more to worry about, right?


## What is web socket and how it is different from HTTP ?

- HTTP and WebSocket both are communication protocols used in client-server communication.

### HTTP protocol 

- Unidirectional 
    * URL/URI syntax :

        http://<host- : ||

    * Stateless
    * Client sends the request
    * Server responds
    * Any bi-directonal communication between client and server requires two TCP connections to be made respectively
    every single time there is bidirectonal connection needs to be made
    * Connectione oriented
        - guarantees delivery 
        -  3 way handshake 
    * runs over any connection based transport protocol
        - TCP
        - SCTP
    * HTTP message information encoded in ASCII 
        - HTTP/1.1
        - HTTP/2
        - Methods 
            * GET
            * POST
            * DELETE
            * PUT
            * etc
        - Headers
            * 200 bytes to 2 kilobytes in size
            * Common size of HTTP header is 700-800 bytes
            * Use of cookies  and other tools at the client-side that expand storage
            features of the agen it reduces the HTTP header payload.


    {Client } --------------request------------> {server}
    {client} <--------------request------------- {server}
    {client} -------------Conection Terminated-- {server}

### WebSocket protocol 
    - URL/URI syntax

        ws://
        wss://


    - Bidirectional
    - full duplex
    - stateful
    - connection is kept alive until it is terminated by either party
    -  

    {Client } --------------request--------------> {server}
    {client} <--------------Handshake------------- {server}
    {client} ------------- open WebSocket--------- {server}


    - Real-time web application
    - Gaming applications
    - Chat applications 




### WebSocket Connect                                           HTTP Connection 

### Polling vs WebSocket




### Raw WebSocket Configuration 

Although your are not going to use a raw WebSocket configuration 
in our propesed chat app, here is what its configuration on Spring would look like:

### Client

        var ws ;

        function connectWebSocket(){

            ws = new WebSocket('ws://localhost:8080/rawwebsocket');
            ws.onmessage = function (event){
                renderServerMessage(event.data);
            };
        }

        function sendMessageToServer(){
            var text = document.getElementById('myText').value;
            var jsonMessage = JSON.stringify({'content':text});
            ws.send(jsonMessage);
        }





### Server


        @Configuration 
        @EnableWebSocket

        public class RawWebSocketConfiguration implements WebSocketConfigurer {


            @Override 
            public void registerWebSocketHandlers(WebSocketHandlerRegistry registry){
                registry.addHandler(myRawSocketHandler(), "rawebsocket");
            }

            @Bean
            public WebSocketHandler myRawWebSocketHandler(){
                return new MyRawWebSocketHandler();
            }
        }


        public class MyRawWebSocketHandler extends TextWebSocketHandler {

            public void afterConnectionEstablished (WebSocktSesion session) {
                TextMessage msg = new TextMessage (" Client connection success!");
                session.sendMessage(msg);
            }

            public void handleTextMessage (WebSocket session, TextMessage message){
                System.out.println(message.getPayload());
                TextMessage msg = new TextMessage("Message recieved. Thank you , client!!!");
                session.sendMessage(msg);
            }

        }



### What's going on here ?

NOte that the client is sending messages in JS Object Notation (JSON) format to 
the server.  actually, it's sending JSON because it's sending JSON because it wants to send 
a JSON message (because the client already knows that the server is expecting a json mesage),
but keep in mind that it could be sending a plain-text message, an xml mesage or whatever 
(that's how raw WebSocket works!!!!)


Note:  
If you want to enable  WebSocket browser compatibility, you would have to use 
something to emulate the WebSockt behavior when it's not available because of compatibility
issues.  Fortunately libs like SockJS can handle this for you painlessly.  Enabling 
SockJS support using Spring is as simple as adding a  `.withSockJS()`
method call to the handler, as show here.



        @Configuration
        @EnableWebSocket

        public class RawWebSocketConfiguration implements WebSocketConfigurer {

            @Override
            public void registerWebSocketHandlers(WebSocketHandlerRegistry registry){
                registry.addHandler(myRawWebSocketHandler(), "/rawwebsocket").withSockJS();
            }

            @Bean public WebSocketHandler myRawWebSocketHandler(){
                return  new MyRawWebSocketHandler();
            }

        }



## WebSoect over STOMP Configuration

Here is how to configure WebSocket over STOMP using Spring.
To work with STOMP, you need a STOMP broker.  Basicially, this is the 
component that keeps track of subscriptions and that boradcasts messages
to subscribed users.  In the previous configuration, note the following:

- An in-memory STOMP broker is enabled by declaring two destinations
    * /queue/
    * /topic/
This helps in the development phase, but it's not recommended for prod enviroments
We will delve deeper into this once we start looking into the multi-node architecture later in this
books.


        @Configuration 
        @EnableWebSocketMessageBroker

        public class WebSocketConfiguration extends AbstractWebSockerMessageBrokerConfigurer {

            @Override
            public void configureMessageBroker(MessageBrokerRegistry config){
                config.enableSimpleBroker("/queue/", "/topic/");
                config.setApplicationDestinationPrefixes("/app")
            }

            @Override
            public void registerStompEndpoints(StompEndpointRegistry registry){
                registry.addEndpoint("/stompwebsocket").withSockJS();
            }
        }

NOTE:  The meaning of `destination` is intentionally left opaque in the STOMP specification.
It can be any string, and it's entirely up to STOMP servers to define the semantics
and the syntax of the destinatins that they support (for example, RabbitMQ defines a dot notation where
detination names should be separated by a dot, as in /topic/public.messages). 

It is common, however, for destinations to be pathlike strings where /topic/ implies a publish-subscribe
pattern (one-to-many) and /queue/imples a point-to-point (one-to-one) message
exchange.


/queue/ and /topic are broker destinations, which means that any frame sent to a 
destination starting with these prefixes will be handled directly by the STOMP broker.


-  The application destination prefix is /app
-  Basically, when a frame is sent to a destiantion that starts with /app, a class
annotated with `@Controller` will handle the frame before forwarding it to the broker.
More specifcally, a method annotated with `@MessageMapping` inside the `@Controller` annotated
class will handle it

- Clients are going to connect to the STOMP endpoint 
using JavaScript (ws://localhost:port/stompwebsocket )



Let's understand what's happening here

* When the `connect` function is called, a new 
WebSocket connection is opened using STOMP as a sub-protocol 

* In the success callback, an anonymous function is executed, and the user 
subscribes to the `/topic/public.messages` destination.

From now on, this user will be able to receive any message that is sent
(from any client or even from the server side) and pass it to the 
`renderPublicMessages` function, which will append the message to a `div`, for 
example.


* When teh sendMessage function is called, a frame with the message is sent tothe 
`/app/send.mesage` destination.  Remember that every message destination.  Remember
that every message sent to a destination starting with `/app` will be handled by an 
`@MessageMapping` method in a `@Controller` annotated class ?  This is the method hanlding it


@Controller
public class ChatRoomController {
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate ;

    @MessageMapping("/send.message")
    public void sendPublicMessage(InstantMessage instantMessage){
        simpMessagingTemplate.convertAndSend("/topic/public.messages", instantMessage);
    }
}



####  JS client

        function connect(){
            socket = new SockJS('/stompwebsocket');
            stompClient = Stomp.over(socket);
            stompClient.connect ({},function(frame){
                stompClient.connect.subscribe('/topic/public.messages', renderPublicMessages);
            });
        }

        function renderPublicMessages(message){
            //append the message to a div, for example 
        }

        function sendMessage(){
            var instantMessage;
            instantMessage = {
                'text' : inputMessage.val(),
                'toUser' : spanSendTo.text()
            }
            stompClient.send("/app/send.message",{},JSON.stringify(instantMessage));
        }




## The Source so Far.....

####  JS client

        function connect(){
            socket = new SockJS('/stompwebsocket');
            stompClient = Stomp.over(socket);
            stompClient.connect ({},function(frame){
                stompClient.connect.subscribe('/topic/public.messages', renderPublicMessages);
            });
        }

        function renderPublicMessages(message){
            //append the message to a div, for example 
        }

        function sendMessage(){
            var instantMessage;
            instantMessage = {
                'text' : inputMessage.val(),
                'toUser' : spanSendTo.text()
            }
            stompClient.send("/app/send.message",{},JSON.stringify(instantMessage));
        }


#### Server

        @Configuration
        @EnableWebSocket

        public class RawWebSocketConfiguration implements WebSocketConfigurer {

            @Override
            public void registerWebSocketHandlers(WebSocketHandlerRegistry registry){
                registry.addHandler(myRawWebSocketHandler(), "/rawwebsocket").withSockJS();
            }

            @Bean public WebSocketHandler myRawWebSocketHandler(){
                return  new MyRawWebSocketHandler();
            }
        }


        @Controller
        public class ChatRoomController {
            @Autowired
            private SimpMessagingTemplate simpMessagingTemplate ;

            @MessageMapping("/send.message")
            public void sendPublicMessage(InstantMessage instantMessage){
                simpMessagingTemplate.convertAndSend("/topic/public.messages", instantMessage);
            }
        }





####  Broker 
        @Configuration 
        @EnableWebSocketMessageBroker

        public class WebSocketConfiguration extends AbstractWebSockerMessageBrokerConfigurer {

            @Override
            public void configureMessageBroker(MessageBrokerRegistry config){
                config.enableSimpleBroker("/queue/", "/topic/");
                config.setApplicationDestinationPrefixes("/app")
            }

            @Override
            public void registerStompEndpoints(StompEndpointRegistry registry){
                registry.addEndpoint("/stompwebsocket").withSockJS();
            }
        }