[The IoC container](https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/beans.html)


## 51. Introduction to the Spring IoC container and beans


### Basis for Spring Framework's IoC container

The following packages are the basis for Spring Framework's IoC container: 

    org.springframework.beans
    org.springframework.context


* BeanFactory
The `BeanFactory` interface provides  an advanced configuration mechanism capable of managing any 
type of object.


* ApplicationContext
The `ApplicationContext` is a sub-interface of `BeanFactory`
    - Adds easier integration with Spring's AOP features
    - Adds Message resource handling 
    - Event publication
    - Applicaton-layer specfi context:
        * `WebApplicatonContext`


In short BeanFactory provies the configuration framework and basic functionality, and the 
`ApplicationContext` adds more enterprise-specific functionality.
The `ApplicationContext`is a complete superset of the `BeanFactory`, so we can effectively
subsitute ApplicationContext for any use case where we would use BeanFactory



In Spring, the objects that form the backbone of your application and that are managed by the Spring IoC
container are called `beans`.  A bean is an object that is instantiated, assembled, and otherwise 
managed by a Spring IoC container.  Otherwise, a bean is simply one of many objects in yoru appliction.
Beans, and the dependencies amoung them, are reflected in the configuration metadata used by comtainer.

## Container overview


* The interface `org.springframework.context.ApplicationContext` represents the Spring IoC container and is 
reponsible for :
    - instantiating
    - configuring
    - assembling
    -  
beans.

* The configuration metadata is represnted in:
    - XML
    - Java annotations
    - Java code 

* Configuration of the IoC allows you to express the objects that allows for the expression of objects that compose your application and the rich
interpendencies between such objects.
* Several implementation of the ApplicationContext interface are supplied out-of-the-box with Spring

* In standalone applications it is common to create an instance of 

        ClassPathXmlApplicationContext 

                -or-

        FileSystemXmlApplicationContext

* Wile XML has been the traditional format for defning congfiguration metadata
you can instruct the container to us Java annotations or code as the metadata 
you can instruct thecontainer to use Java annotations  or code as the metadata format by providing 
a small amount of XML configuration to declaritively enable supportfor the ese additioan meaetadata
formats.


In most application scenarios, explicit user coe is not erequired to instatiate one or more instances of a Spring IoC container.
* Foe example, in a web application senario, a simple eith (or so) lines of boilerplate J2EE web deesciprtior XML in the `web.xml`
file of the application will typically suffice.



##Liora Reznichenko


The following diagram is a high-level view of how Spring works.  Your application classes are combined with configuration
metadata so that 



        Your Business Objects(POJOs)-----------
                                                \
                                                 \
                                                  \	
        ------------------------------------->   {Spring Container}
        Configuration                              |
        Metadata                                   | produces 
                                                   |
                                                {Fully configured System READY FOR USE}


                                
            


        `
## Configuration metadata 

As the preceding diagram shows, the Spring IoC container consumes a form of `configuration metadata`; this configuration metada
represents how you as an application developer tell the Spring container to 
    * instantiate
    * configure
and assemble the objects in yoru application.


Configuration metadat is traditionally supplied in a simple and intuitive XML forma, whih is what most of this chapter uses to convey key conetps and 
reatures of the Spring IoC container.





## Using the container


The `ApplicationContext` is the interface for an advanced factory capable of maintaining a registry of different 
beans and their dependencies.  Using the method 

    T getBean(String name, Class<T> requiredType)

You can retrieve instances of your beans


The `ApplicationContext` enables you to read bean definitions and acess them as follows:


        // create and configure beans
        ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"services.xml","daos.xml"})

        // retrieved configured instance
        PetStoreServiceImpl service = context.getBean("petStore",PetStoreServiceImpl.class);

        // use configured instance
        List userList = service.getUsernameList();