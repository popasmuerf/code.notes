
Debugging SSL/TLS Connections
Understanding SSL/TLS connection problems can sometimes be difficult, especially when it is not clear what messages are actually being sent and received. The SunJSSE has a built-in debug facility and is activated by the System property javax.net.debug.

What follows is a brief example how to read the debug output. Please be aware that the output is non-standard, and may change from release to release. We are using the default SunJSSE X509KeyManager and X509TrustManager which prints debug information.

This example assumes a basic understanding of the SSL/TLS protocol. Please see the The SSL Protocol Overview section of the JSSE Reference Guide for more information on the protocols (handshake messages, etc.).

In this example, we connect using the SSLSocketClientWithClientAuth sample application to a simple HTTPS server that requires client authentication, then send a HTTPS request and receive the reply.

    java  -Djavax.net.debug=all  \
        -Djavax.net.ssl.trustStore=trustStore
        SSLSocketClientWithClientAuth bongos 2001 /index.html







keytool -genkeypair -keyalg RSA -keysize 2048 -alias server -dname "CN=demo_misc_lab,OU=thirdplanet,O=io,C=US" -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore ./keystore.jks -storepass secret -keypass secret -deststoretype pkcs12



keytool -genkeypair -keyalg RSA -keysize 2048 -alias server -dname "CN=demo_misc_lab,OU=thirdplanet,O=io,C=US" -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore ./keystore.jks  -deststoretype pkcs12

keytool -genkeypair -keyalg RSA -keysize 2048 -alias stackoverflow -dname "CN=stackoverflow,OU=Hakan,O=Hakan,C=NL" -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore identity.jks -storepass secret -keypass secret -deststoretype pkcs12


keytool -genkeypair -keyalg RSA -keysize 2048 -alias demo_misc_lab  -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore keystore.jks -storepass r3dbl@ck -keypass r3dbl@ck 


keytool -import -alias demo_misc_lab  -file demo_misc_lab.cer -storetype JKS -keystore truststore.jks


keytool -import -noprompt -trustcacerts -alias demo_misc_lab -file  demo_misc_lab.cer  -keystore truststore.jks -storepass r3dbl@ck


keytool -import -noprompt -trustcacerts -alias demo_rest_client -file  demo_rest_client.cer  -keystore truststore.jks -storepass r3dbl@ck



keytool -export -keystore keystore.jks -alias demo_misc_lab  -file demo_misc_lab.cer

keytool -export -keystore keystore.jks -alias demo_rest_client  -file demo_rest_client.cer

keytool -keystore keystore.jks -genkey -alias demo_rest_client




 ./mvnw spring-boot:run  -Djavax.net.debug=SSL,keymanager,trustmanager,ssl:handshake

 ./mvnw spring-boot:run  -Djavax.net.debug=all


 ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=one_way_ssl"  -Djavax.net.debug=ssl,handshake

  
 
 
 ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=two_way_ssl  -Djavax.net.debug=ssl,handshake"

 





