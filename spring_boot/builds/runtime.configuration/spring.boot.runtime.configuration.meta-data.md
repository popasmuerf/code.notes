Configuration meta-data
=========================================================
https://docs.spring.io/spring-boot/docs/2.3.3.RELEASE/reference/html/appendix-configuration-metadata.html#configuration-metadata




Spring Boot jars includes metadata files that provide details of all supported
configuration properties.  The files are designed to let IDE developers offer
contextual help and "code completion" as users are working with

        application.properties
            -or-
        application.yml
        
        
        
The majority of the metadata file is generated automatically at compile time
by processing all items annotated with @ConfigurationProperties.  However,
it is possible to write part of the metadata manually for corner cases or
more advanced used cases...


1. Metadata Format

Configuration metadata files are located inside jars under 

        META-INF/spring-configuration-metadata.json
        
They use a JSON format with items categorized under either
"groups" or "properties and additional values hints categorized under
"hints", as shown in the following example:


        {"groups": [
            {
                "name": "server",
                "type": "org.springframework.boot.autoconfigure.web.ServerProperties",
                "sourceType": "org.springframework.boot.autoconfigure.web.ServerProperties"
            },
            {
                "name": "spring.jpa.hibernate",
                "type": "org.springframework.boot.autoconfigure.orm.jpa.JpaProperties$Hibernate",
                "sourceType": "org.springframework.boot.autoconfigure.orm.jpa.JpaProperties",
                "sourceMethod": "getHibernate()"
            }
            ...
        ],"properties": [
            {
                "name": "server.port",
                "type": "java.lang.Integer",
                "sourceType": "org.springframework.boot.autoconfigure.web.ServerProperties"
            },
            {
                "name": "server.address",
                "type": "java.net.InetAddress",
                "sourceType": "org.springframework.boot.autoconfigure.web.ServerProperties"
            },
            {
                  "name": "spring.jpa.hibernate.ddl-auto",
                  "type": "java.lang.String",
                  "description": "DDL mode. This is actually a shortcut for the \"hibernate.hbm2ddl.auto\" property.",
                  "sourceType": "org.springframework.boot.autoconfigure.orm.jpa.JpaProperties$Hibernate"
            }
            ...
        ],"hints": [
            {
                "name": "spring.jpa.hibernate.ddl-auto",
                "values": [
                    {
                        "value": "none",
                        "description": "Disable DDL handling."
                    },
                    {
                        "value": "validate",
                        "description": "Validate the schema, make no changes to the database."
                    },
                    {
                        "value": "update",
                        "description": "Update the schema if necessary."
                    },
                    {
                        "value": "create",
                        "description": "Create the schema and destroy previous data."
                    },
                    {
                        "value": "create-drop",
                        "description": "Create and then destroy the schema at the end of the session."
                    }
                ]
            }
        ]}
        
  


Each "property" is a configuration item that the user specifies with a given value.
For example 

    **server.address**

might be specified in 

    **application.properties**
    
as follows:

    server.port=9090
    server.address=127.0.0.2

The "groups" are higer level items that do not themselves specify a value but
instead provide a contextual grouping for properties.

For example, 

    **server.port**
        -and-
    **server.address**
    
are all a part of the **server group**
    
         {"groups": [
                    {
                        "name": "server",
                        "type": "org.springframework.boot.autoconfigure.web.ServerProperties",
                        "sourceType": "org.springframework.boot.autoconfigure.web.ServerProperties"
                    },
                    {
                        ....
                    }
                    ...
                ],"properties": [
                    {
                        "name": "server.port",
                        "type": "java.lang.Integer",
                        "sourceType": "org.springframework.boot.autoconfigure.web.ServerProperties"
                    },
                    {
                        "name": "server.address",
                        "type": "java.net.InetAddress",
                        "sourceType": "org.springframework.boot.autoconfigure.web.ServerProperties"
                    },
                    
                    
                    ....
                    ....
                    ....
          }
                 


**NOTE**  :  It is not required that every property has a group.  Some properties
might exist in their own right....


Finally **hints** are additional information used to assist the user in configuring
a given property.  For example, when a developer is configurating the 

**spring.jpa.hibernate.ddl-auto property**, a tool can use the hints to offer some
auto-completion help for the values of :

    * validate
    * update
    * create
    * create-drop
    * none
    
    
 Adding Additional Metadata
 ======================================

Spring Boot’s configuration file handling is quite flexible, and it is often the case that properties may exist that are not bound to a @ConfigurationProperties bean. You may also need to tune some attributes of an existing key. To support such cases and let you provide custom "hints", the annotation processor automatically merges items from META-INF/additional-spring-configuration-metadata.json into the main metadata file.

If you refer to a property that has been detected automatically, the description, default value, and deprecation information are overridden, if specified. If the manual property declaration is not identified in the current module, it is added as a new property.

The format of the additional-spring-configuration-metadata.json file is exactly the same as the regular spring-configuration-metadata.json. The additional properties file is optional. If you do not have any additional properties, do not add the file.


