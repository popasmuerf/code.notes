Our Bean
=========================
Beans are just straight POJOs:


public class HelloWord{
	private String message;

   public void setMessage(String message){
      this.message  = message;
   }

   public void getMessage(){
      System.out.println("Your Message : " + message);
   }
}


Our MainApp
=============================
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXMLApplicationContext;

public class MainApp{
	public static void main(String[] args){
		ApplicationContext  context = new ClassPathXmlApplicationContext("Beans.xml");
		HelloWorld obj = (HelloWorld) context.getBean("HelloWorld");
		obj.getMessage() ;
	}
}



What's going on here ?
=============================
1. The first step is to create application context here we used framework
API:

	ClassPathXmlApplicationsContext()

2. The second step is used to get required bean using:
	getBean()

	method of the created context:

	ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
	HelloWorld obj = (HelloWorld) context.getBean("HelloWorld");

Now we have to create a Bean Configuration file...
===================================================
The Bean configuration file is an XML file and acts as cement that glues
the bean classes togethor.  This file is may be created uner the src directory

<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">

    <bean id="HelloWorld" class="com.test.HelloWord">
    	<property name="message" value="Hello World!"/>
    </bean>

</beans>

What's going on here ?
========================================================
When the Spring application gets loaded into memory,
The framework makes use of the above configuration
file to create all the beans defined and assing them a uniqu ID 
as defined in 
	<bean>
tag.  You can use the tag
	<property>
to pass the values of different variables used at the 
time of object creation.






