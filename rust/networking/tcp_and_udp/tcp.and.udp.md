**TCP and UDP Using Rust**
=================================================================
Being a system programming language, 
the Rust Standard Library has support for interacting
with the network stack.  All the 
networking-related functionality is located in the 

	std::net

namespace; reading and writing to sockets also uses
the Read and Write traits from **stdio::io**.  Some of
the most important structures here are **IpAddr**, which 
represents a generic IP address that can either be
v4 or v6, **SocketAddr** , which represents a generic socket
address (a combination of an IP and a port on a host),
**TcpListener** and **TcpStream** for communication over TCP,
**UdpSocket** for UDP, and more.


What std::net doesn't support at the moment...
-------------------------------------------------------
Currently, the standard library does nt provide
any APIs to deal with the network stack
at a lower level.  While this might 
change in the future, a number of crates fill this gap.
The most important of these is **libpnet**, which provides a
set of APIs for lower-level networking.  Some other important
crates for networking are **net2** and **socket2** .  these
were meant to be incubators for APIs that might be moved to 
the standard library.  Some of the functionality here is
ported to Rust core repo when it is deemed to be useful and stable
enough.

Unfortunately, this doesn't work out as planned always.  On the
whole, the community now suggests using the tokio ecosystem of
crates for writing high-peformance networking applications that do not
require fine-graned control of socket semantics.




