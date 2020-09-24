url:https://www.tutorialspoint.com/xsd/xsd_validation.htm

XML Schema (W3C)
=================================
XSD(XML Schema Definition), a recommendation of the 
Word Wide Web Consortium(W3C), specifies how to formally
describe  the elements in an Extensible Markup Language 
(XML) document


XSD can be used to express a set of rules to
which an XML document must conform in order tbe considered "valid"
accordring to that schema.


XSD is a way to describe precisely the XML language.
XSDs heck the validity of structure and vocabularly of
an XML document against the grammatical rules of
the appropiate XML language.



An XML document can be defined as

Well-formed 
    -   If the XML document adheres to all the general XML
        rules such as tags must be properly nested,
        opening and closing tags must be balanced,
        and empty tag must end with '/>' then it
        is called as **well-formed**
        
-or-

Valid
    -   An XML document said to be valid when it is not 
        only well-formed, but also conforms to available 
        XSD that specifies which tags it uses, what attributes
        thos tags can conain, and which tags can occur
        inside other tags, among other properties.
        
        
        <?xml version= "1.0"?>
        <xs:schema xmlns:xs = "http://www.w3.org/2001/XMLSchema">
           targetNamespace = "http://www.tutorialspoint.com" 
           xmlns = "http://www.tutorialspoint.com"
           elementFormDefault = "qualified">

           <xs:element name = 'class'>
              <xs:complexType>
                 <xs:sequence>
                    <xs:element name = 'student' type = 'StudentType' minOccurs = '0' 
                       maxOccurs = 'unbounded' />
                 </xs:sequence>
              </xs:complexType>
           </xs:element>

           <xs:complexType name = "StudentType">
              <xs:sequence>
                 <xs:element name = "firstname" type = "xs:string"/>
                 <xs:element name = "lastname" type = "xs:string"/>
                 <xs:element name = "nickname" type = "xs:string"/>
                 <xs:element name = "marks" type = "xs:positiveInteger"/>
              </xs:sequence>
              <xs:attribute name = 'rollno' type = 'xs:positiveInteger'/>
           </xs:complexType>
           
        </xs:schema>

        
        
 Features

Here is a list of some of the popular features of XSD −

    XSDs can be extensible for future additions.
    XSD is richer and more powerful than DTD.
    XSD is written in XML.
    XSD supports data types.
    XSD supports namespaces.
    XSD is W3C recommendation.
    
    
    
An XML XSD is kept in a separate document and then the document can be linked
to an XML document to use it.
====================================================================

<Schema>  Element
--------------------------------------------------------------------
        <xs:schema xmlns:xs = "http://www.w3.org/2001/XMLSchema">

The above fragment specifies that elements and datatypes used in the 
schema are defined in **http://www.w3.org/2001/XMLSchema**
These elements/datatypes shold be prefixed with **xs** 
This is ALWAYS required.

targetNamespace
--------------------------------------------------------------------
        targetNamespace = "http://www.tutorialspoint.com"

The above fragment specifies that elements used in 
this schema are defined 
in **http://www.tutorialspoint.com**
namespace. It is optional.


targetNamespace
--------------------------------------------------------------------
        targetNamespace = "http://www.tutorialspoint.com"

The above fragment specifies that elements used in 
this schema are defined 
in **http://www.tutorialspoint.com**
namespace. It is optional.



xmlns 
--------------------------------------------------------------------
        xmlns = "http://www.tutorialspoint.com"

The above frgament indicates that an elements declared in this schema
must be namespace qualified before using in any XML Document.
It is optional.



Referencing Schemas
===============================================================
Let's tak a took at the following Referencing Schema ---

        <?xml version = "1.0"?>

        <class xmlns = "http://www.tutorialspoint.com"
           xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation = "http://www.tutorialspoint.com student.xsd">  
           
           <student rollno = "393">    
              <firstname>Dinkar</firstname>
              <lastname>Kad</lastname>
              <nickname>Dinkar</nickname>
              <marks>85</marks>
           </student>
           
           <student rollno = "493">	 
              <firstname>Vaneet</firstname>
              <lastname>Gupta</lastname>
              <nickname>Vinni</nickname>
              <marks>95</marks>
           </student>
           
           <student rollno = "593">    
              <firstname>Jasvir</firstname>
              <lastname>Singh</lastname>
              <nickname>Jazz</nickname>
              <marks>90</marks>
           </student>
        </class>



What's going on here ?
-----------------------------

xmlns =  "http://www.tutorialspoint.com":

    The above fragment speicifies default namespace declaration.
    This namespace is used by schema validator chec that all
    the elements are part of this namespace...this is optional...
    

xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation = "http:www.tutorialspoint.com student.xsd">

    After defining the XMLSchema-instance xsi, use 
    **schemaLocation** attribute.  This attribute has two
    values, namespace and location of XML Schema, to 
    be used separated by a space it is optional.
    
    
    
    
We will use Java based XSD validator to validate 
**students.xml** against the **students.xsd**

<!--students.xml-->
        <?xml version = "1.0"?>

        <class>  
           <student rollno = "393">
              <firstname>Dinkar</firstname>    
              <lastname>Kad</lastname>
              <nickname>Dinkar</nickname>
              <marks>85</marks>	 
           </student>
           
           <student rollno = "493">	 
              <firstname>Vaneet</firstname>
              <lastname>Gupta</lastname>
              <nickname>Vinni</nickname>
              <marks>95</marks>
           </student>
           
           <student rollno = "593">    
              <firstname>Jasvir</firstname>
              <lastname>Singh</lastname>
              <nickname>Jazz</nickname>
              <marks>90</marks>
           </student>
        </class>
    
    

<!--students.xsd-->

        <?xml version = "1.0"?>

        <xs:schema xmlns:xs = "http://www.w3.org/2001/XMLSchema">
           <xs:element name = 'class'>
              <xs:complexType>
                 <xs:sequence>
                     <xs:element name = 'student' type = 'StudentType' minOccurs = '0' 
                        maxOccurs = 'unbounded' />
                 </xs:sequence>
              </xs:complexType>
           </xs:element>

           <xs:complexType name = "StudentType">
              <xs:sequence>
                 <xs:element name = "firstname" type = "xs:string"/>
                 <xs:element name = "lastname" type = "xs:string"/>
                 <xs:element name = "nickname" type = "xs:string"/>
                 <xs:element name = "marks" type = "xs:positiveInteger"/>
              </xs:sequence>
              <xs:attribute name = 'rollno' type = 'xs:positiveInteger'/>
           </xs:complexType>			 
        </xs:schema>
    

/XSDValidator

        import java.io.File;
        import java.io.IOException;

        import javax.xml.XMLConstants;
        import javax.xml.transform.stream.StreamSource;

        import javax.xml.validation.Schema;
        import javax.xml.validation.SchemaFactory;
        import javax.xml.validation.Validator;

        import org.xml.sax.SAXException;

        public class XSDValidator {
           public static void main(String[] args) {
              if(args.length !=2){
                 System.out.println("Usage : XSDValidator <file-name.xsd> <file-name.xml>" );
              } else {
                 boolean isValid = validateXMLSchema(args[0],args[1]);
                 
                 if(isValid){
                    System.out.println(args[1] + " is valid against " + args[0]);
                 } else {
                    System.out.println(args[1] + " is not valid against " + args[0]);
                 }
              }
           }
           
           public static boolean validateXMLSchema(String xsdPath, String xmlPath){
              try {
                 SchemaFactory factory =
                    SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
                    Schema schema = factory.newSchema(new File(xsdPath));
                    Validator validator = schema.newValidator();
                    validator.validate(new StreamSource(new File(xmlPath)));
              } catch (IOException e){
                 System.out.println("Exception: "+e.getMessage());
                 return false;
              }catch(SAXException e1){
                 System.out.println("SAX Exception: "+e1.getMessage());
                 return false;
              }
		        
              return true;
	        
           }
        }
   
    
    
    




