url: https://www.oauth.com/oauth2-servers/access-tokens/


Access Tokens
===============================================================

Access tokens are the thing that appliations use to make API
requests on behalf of a user.  The access token represents the authorization ofa 
a specific application to access specific parts ofa user's data.

	*  Tokens allow for users to have specific access rights
           to specific data regarding some api

        *    Each API request requires a token that authorizes such
             access.

        *    All tokens are retrieved via GET request from a
             "Token Endpoint"...pretty much an "auth server




Access to tokens mus be kept confidential in transit and in stroage.
======================================================================
	*    The only parties that should ever see the access token
             are :
                -    The application making the request
                -    The authorization server
                -    The resource server

        *    The token can only be used over an http(s) connection




Verification of token requests...
==================================================

