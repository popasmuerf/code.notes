#Miscelaneous Utilities in std::net
====================================================
Another important type in the standard library is 
**IpAddr**, which represents an IP address.
Not suprisingly, it is an enum with two variants...
    -   v4
    -   v6
    
All of these types have methods to classify addresses
according to their types

    -   global
    -   loopback
    -   multicast
    -   public
    -   private
    -   dynamic
    -   static

As of this writing...many of these methods are still in BETA
and as such are only available via the nightly compiler.

//chapter3/udp-multicast.rs

use std::{env, str};
use std::net::{UdpSocket,Ipv4Addr};


fn main(){
    let mcast_group: Ipv4Addr = "239.0.0.1".parse().unwrap() ;
    let port:u16 = 6000;
    let any = "0.0.0.0".parse().unwrap() ;
    let mut buffer = [0u8 ; 1600];
    if env::args().count > 1 {
        //client case
        let socket = UdpSocket::bind((any,port))
        .expect("Error binding to client socket");
        
        socket.join_multicast_v4(&mcast_group, &any)
        .expect("Fialed to write to server") ;
        
        print!("{}", str::from_utf8(&buffer)
        .expect("Could not write buffer as string));
    }else{
        //server case
        let socket = UdpSocket::bind((any,0))
        .expect("Could not bind socket");
        
        sockect.send_to("Hello World!!".as_bytes(), &(mcast_group,port))
        .expect("Failed to write data) ;
    }
    
}









1. main()
    1.1 TcpListener is our server
    1.2 TcpListener::bind("0.0.0.0:8888") creates a socket 
        for our server to make use of...
    1.3 0.0.0.0 tells the kernel to bind this socket to
        all avaialble interfaces on this host....
    1.4 The **expect()** method serves as our **"try-catch()"** statement
        if the socket bind fails...
    1.5 **listerner.incoming()** returns an iterator over streams that have connected
        to the server.  We loop over the list of extant connecting streams checking
        if the have failed or if they are ok(with each stream in the being of Type
        Result::Err(e) or Result::Ok(stream)
        If Result::Ok(stream)
            a. spawn a new thread encapsulating:
               a.1 An instance of handle_client
               a.2 Read data from each of the client streams
               a.3 We must spawn a thread for each stream else running
                   this in a single thread will block everytime a stream is 
                   being read so no other streams will be read
               a.4 Each therad recieves a closure that calls this function,
                   The logic of reading from each stream and writing it back is
                   encapsulated in the function **handle_client**
                   
               a.5 This closure must be a **move** closure, since this must read
                   a variable (stream)  from the enclosing scope.
                   
               a.6 In this function, we pring the remote endpoint address and port,
                   and then define a buffer to hold data temporarily.  
                   We make sure that the buffer is zeroed out.
                   
               a.7 We iterate through each stream to read all the data
               
               a.8 If we reach the end of the stream (when stream.read() returns 0
                   then break with return Ok(()) else write the data back the same
                   stream...
                   


        fn handle_client(mut stream:TcpStream)-> Result<(),Error>{
            println!("Incoming connection from : {}",
                     stream.peer_addr()?);
                     let mut buf :[u8;512] = [0; 512];
                     loop{
                         let bytes_read : usize = stream.read(&mut buf)? ;

                         if bytes_read == 0{
                             return Ok(());
                         }
                         stream.write(&buf[..bytes_read])? ;
                     }
        }


        fn main() {
            let listener:TcpListener = TcpListener::bind("0.0.0.0:8888")
            .expect("Could not bind");

            for stream in listener.incoming(){
                match stream{
                    Result::Err(e) => {eprintln!("Failed: {}",e)}
                    Result::Ok(stream) =>{
                        thread::spawn(move || {
                            handle_client(stream)
                            .unwrap_or_else(|error| eprintln!("{:?}",error));

                        });
                    }
                }
            }

        }
        
        

