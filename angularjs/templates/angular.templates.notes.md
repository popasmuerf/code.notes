url: https://angular.io/guide/template-syntax#!#ref-vars

Angular Templates
=================================




Template Syntax
=========================================

the Angular applicaiton manages what the user sees and can do, achieveing this through the
interaction of a component class instance(the component) and its user-facing template.


You may be familiar with the component/template uality form your experience wth the3 
model-view-contorller (MV) or model-view-viewmodel(MVVM).  In Angular, the component 
plays the part of the controller/view model, and the template represents the view.



This page is a comprehensive technical refernece to the Angular template langage  It explains basic
principles of the template language and describes t most of the syntax that you will encomounter
elsewhere in the docummentation.




Template reference variables (#var)
===========================================

A template reference variable is often a reference to a DOM elemement within a template.
It can also refer to a directive


It can also refer to a irective* which contains a component), an element, TemplateRef, or web component.


Example of template reference variables (#var)
------------------------------------------

	- component containing directivs
	- elements
	- TemplateRef
	- web component


We use the hash symbol(#) to declare a reference varaile.  the following reference
variable 

	#phone

declares a phone variale on an <input> element....

<input #phone placeholer="phone number" />


You can refer to a template reference variable anywhere i the coponent's template.
Here, a <button> futher down the template refers to the phone variable


<input #phone placeholder="phone number" />

	<!-- lots of other elements -->
	<!-- phone refers to the the input element; pass its `value` to an event handler -->

<button (click)="callPhone(phone.value)">Call</button>


	

How a reference variable gts its value ?
============================================

In most cases, Angular sets the reference varaible's value to the element on which it 
is declared.  In the previous example, "phone" refers to the phone number <input>  The button's
click handler passes the <input> value to the component's callPhone() method.


/src/app/hero-form.component.html

<form #itemForm="ngForm" (ngSubmit)="onSubmit(itemForm)">
  <label for="name"
    >Name <input class="form-control" name="name" ngModel required />
  </label>
  <button type="submit">Submit</button>
</form>

<div [hidden]="!itemForm.form.valid">
  <p>{{ submitMessage }}</p>
</div>



^^^^
The reference value of 

	#itemForm

without the attribute value of

	"ngFrom"

then the value of #itemForm defaults to the value of teh HTMLFormElement

HTMLFormElement inteface represents a <form> element in the DOM' it allows
access to annd in some cases modificatin of aspects of the form...as well as access to its
compnoent elements....


	EventTarget <------ Node <------- Element <------ HTMLElement <-------HTMLFormElement


	HTMLFormElement.elements
	HTMLFormElement.length
	HTMLFormElement.name
	HTMLFormElement.metho
	HTMLFormElement.target
	HTMLFormElement.action
	...etc.....



	
In the above example, 
	

    



