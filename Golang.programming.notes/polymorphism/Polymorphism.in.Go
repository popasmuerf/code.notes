Polymorphism in Go
=========================


Interfaces
=========================
I can merely implement an interface by attaching a function(behavior)
it includes to any type I wish.


Inheritance
=========================
I can take on the characteristics
of any previous type by merely
including an "empty" field 
of the type's name in the 
new type as an attribute



Example:
=========================
package main

import "fmt"

type Hobby interface{
	myStereotype() string
}
type Human struct{
}
type Man struct{
	Human
}
type Woman struct{
	Human
}
type Dog struct{
}
func (h Human) myStereotype() string {
    return "I'm a Human, only an abstract concept, and I can have no hobby."
}
func(m Man)myStereotype() string{
	return "I am going fishing"
}
func(w Woman)myStereotype() string{
	return "I am going shopping"
}
func(d Dog)myStereotype() string{
	return "I am going to do dog-stuff"
}

func main() {
	m:= new(Man)
	w:= new(Woman)
	d:= new(Dog)
	hArr := [...]Hobby{m,w,d}
	
	for n,_ := range(hArr){
		 fmt.Println("I'm a human, and my stereotype is: ", hArr[n].myStereotype())
	}
	
}

}