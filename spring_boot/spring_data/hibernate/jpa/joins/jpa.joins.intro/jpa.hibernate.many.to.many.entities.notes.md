#Hibernate Mant to Many How to......

Source [Hibernate Many to Many Annotation Tutorial](https://www.baeldung.com/hibernate-many-to-many)



##1. Introduction

In this quick tutorial, we will have  a quick look at how the 
@ManyToMany annotation can be used for specifying this type of
relationships in Hibernate




##2. A typical Example

Let's stat with a simple Entity Relationshp Diagram -- which shows
the many-to-many associations between 
two entities employee and project 



┌─────────────────────────┐           ┌─────────────────────────┐           ┌─────────────────────┐
│ Employee                │           │ employee_project        │           │ project             │
│-------------------------│         xxx-------------------------xxx         │-----------------    │
│ employee_id INT(11)     ├────────xx── employee_id INT(11)     ┌─x─────────┤project_id INT(11)   │
│ first_name  VARCHAR(50) │         xxx project_id INT(11)      │xx         │                     │
│ last_name   VARCHAR(50) │           │                         │           │                     │
│                         │           │                         │           │                     │
└─────────────────────────┘           └─────────────────────────┘           └─────────────────────┘

In the above scenario, any given employee can be assigned
to multiple projects and a project may have multiple employees
working for it, leading to a many-to-many association between the two.


We have an employee table with employee_id as its primary
key and a project table with project_id as its primary key.
A join tabale employee_project is required here to connect 
both sides.



##3. Database Setup

Let's assume we have already created database with the name

***spring_hibernate_many_to_many***


We also need to create the ***employee*** and project tables along with
the ***employee_project*** join table with ***employee_id*** and 
***project_id*** as foreign keys:

                CREATE TABLE `employee` (
                  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
                  `first_name` varchar(50) DEFAULT NULL,
                  `last_name` varchar(50) DEFAULT NULL,
                  PRIMARY KEY (`employee_id`)
                ) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

                CREATE TABLE `project` (
                  `project_id` int(11) NOT NULL AUTO_INCREMENT,
                  `title` varchar(50) DEFAULT NULL,
                  PRIMARY KEY (`project_id`)
                ) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

                CREATE TABLE `employee_project` (
                  `employee_id` int(11) NOT NULL,
                  `project_id` int(11) NOT NULL,
                  PRIMARY KEY (`employee_id`,`project_id`),
                  KEY `project_id` (`project_id`),
                  CONSTRAINT `employee_project_ibfk_1` 
                   FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
                  CONSTRAINT `employee_project_ibfk_2` 
                   FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8;



###The model classes ***Employee** and ***Project*** to be created with
JPA annotations:

            @Data
            @Entity
            @Table(name="Employee")
            public class Employee {
                @Id
                @Column(name="employee_id")
                Long employeeId;
                
                @Column(name="first_name")
                String firstName;

                @ManyToMany(cascade = {CascadeType.ALL})
                @JoinTable(name = "Employee_Project",
                           joinColumns = {@JoinColumn(name = "employee_id"},
                           inverseJoinColumns = {@JoinColumn = "project_id"} )
                Set<Project> projects = new HashSet<>() ;

            }
            
            
            @Data
            @Entity
            @Table(name="Project")
            public class Project{
                @Id
                @Column(name="project_id")
                Long projectId;
                
                @ManyToMany(mappedBy = "projects")
                private set<Employee> employees = new HashSet<>() ;
            
            }
            
As we can see, both the Empolyee class and Project classes refere to one
another, which means that the association between them is bidrectional.   
    
