

/*


    HttpClient < 4.3 
    
    
    The TrustStrategy now overrides the standard
    certificate verfication process (which would have otherwise
    consulted a convigured trust manager)

*/

        HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();

        CloseableHttpClient httpClient = (CloseableHttpClient) requestFactory.getHttpClient();

        TrustStrategy acceptingTrustStrategy = (cert, authType) -> true;
        SSLSocketFactory sf = new
        SSLSocketFactory(acceptingTrustStrategy,ALLOW_ALL_HOSTNAME_VERIFIER) -> true ;

        httpClient.getConnectionManager()
            .getShcemeRegistery()
            .resister(new Sheme("https", 8443,sf)) ;
            
            
         ResponseEntity<Strng> response = new RestTemplate(requestFactory) ;
         
 
 
 
    


/*


    HttpClient < 4.3 
    
    
With the new HTTPClient, now we have an enchanced, 
redesigned default SSL hostname verifier.  Also with the
instroduction of **SSLConnectionSocketFactory** and
**RegistryBuilder**,  it is easy to build
SSLSocketFactorys....let's re-write our shit....  

*/

        HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();

        CloseableHttpClient httpClient = (CloseableHttpClient) requestFactory.getHttpClient();

        TrustStrategy acceptingTrustStrategy = (cert, authType) -> true;
        
        SSLContext sslContext = new SSLContexts
                .custom()
                .loadTrustMaterial(null,acceptingTrustStrategy)
                .build() ;
                
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext,NoopHOstnameVerifier.INSTANCE) ;
        
        Registry<ConnectionSocketFActory> socketFactoryRegisterRegisteryBuilder
        .<ConnectionSocketFactory> create()
        .register("https",sslsf)
        .register("http",new PlainConnectionSocketFactory())
        .build() ;
        
        BasicHttpClientConnectionManager connectionManager = new BasicHttpClientConnectionManager(socketFactoryRegistry) ;
        CloseableHttpClient httpClient = HttpClients.custom()
        .setSSLSocketFactory(sslsf)
        .setConnectionManager(connectionManager)
        .build()
        
        HttpComponentsClientHttpRequestFactory(httpClient);
	    ResponseEntity<String> response = new RestTemplate(requestFactory)
	      .exchange(urlOverHttps, HttpMethod.GET, null, String.class);
	      
	    assertThat(response.getStatusCode().value(), equalTo(200));




//FIXED


        HttpCoponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory() ;

        DefaultHttpClient httpClient = (DefaultHttpClient) requestFactory
                                        .getHttpClient() ;
                                        
        TrustStrategy acceptingTrustStrategy = (cert,authType) -> true ;


        SSLSocketFactory = sf = new SSLSocketFactory(acceptingTrustStrategy, ALLOW_ALL_HOST_NAME_VERIFIER) ;

        httpClient
            .getConnectionManager()
            .getSchemeRegistry()
            .register(new Scheme("https",8443,sf)) ;
            
        String url = "https://localhost:8443/httpclient-simple/api/bars/1";

        ResponseEntity<String> response = new RestTemplate(requestFactory)
                                              .exchange(url,HttpMethod.GET,null, String.class) ;
                                              
        assertThat(response.getStatusCode().value(),equalTo(200)) ;
    







