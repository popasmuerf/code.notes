keytool -genkeypair -keyalg RSA -keysize 2048 -alias server -dname "CN=demo_misc_lab,OU=thirdplanet,O=io,C=US" -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore ./keystore.jks -storepass secret -keypass secret -deststoretype pkcs12



keytool -genkeypair -keyalg RSA -keysize 2048 -alias server -dname "CN=demo_misc_lab,OU=thirdplanet,O=io,C=US" -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore ./keystore.jks  -deststoretype pkcs12

keytool -genkeypair -keyalg RSA -keysize 2048 -alias stackoverflow -dname "CN=stackoverflow,OU=Hakan,O=Hakan,C=NL" -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore identity.jks -storepass secret -keypass secret -deststoretype pkcs12


keytool -genkeypair -keyalg RSA -keysize 2048 -alias demo_misc_lab  -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -validity 3650 -keystore keystore.jks -storepass r3dbl@ck -keypass r3dbl@ck 


keytool -import -alias demo_misc_lab  -file demo_misc_lab.cer -storetype JKS -keystore truststore.jks


keytool -import -noprompt -trustcacerts -alias demo_misc_lab -file  demo_misc_lab.cer  -keystore truststore.jks -storepass r3dbl@ck



keytool -export -keystore keystore.jks -alias demo_misc_lab  -file demo_misc_lab.cer



keytool -keystore keystore.jks -genkey -alias demo_rest_client




 ./mvnw spring-boot:run  -Djavax.net.debug=SSL,keymanager,trustmanager,ssl:handshake

 ./mvnw spring-boot:run  -Djavax.net.debug=all
 
 
 





