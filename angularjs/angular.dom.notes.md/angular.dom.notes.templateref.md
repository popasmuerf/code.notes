url:https://blog.angularindepth.com/exploring-angular-dom-abstractions-80b3ebcfc02

We can manipulate the DOM using angular via
======================================================
	-	Angular(Angular.js) injected DOM 'element' into 'link' funciton
		and you could query any mode within component's template,

	-	Using the 'link' funciton  we could query any
		node within a component's template...and do other stuff like
		*	Query nodes within a component

		*	add or remove chil nodes

		*	modify styles etc

		*	disadvantage:
			- tied to individual browser





What we know as Angular now(v.2-*) runs on different platforms,  in a browser, 
on a mobile platform or insided a web worker.  So a lovel of abstraction is requried to 
stand between platform specific API and the framework intefaces.  In angular these 

In Angualr these abstraction come in a form of the following reference types:

	-	ElementRef
	-	TemplateRef
	-	ViewRef
	-	ComponentRef
	-	ViewContainerRef



Before we explore the DOM abstractions, let's understand how we access these 
abstractions inside a component/directive class 


Angular provides a meachanism called DOM queries.  It comes ina form of 
@ViewChild 



@ViewChild   @ViewChildren
=============================================================
these decorators work in pair with template reference variables



@ViewChild
-----------------------------------------------------------
-	Returns one references


@ViewChildren
----------------------------------------------------------
-	Returns multiple references as a 
	*	QueryList Object



Usually, these decorators work in pari with template reference varaibles.

A template reference variable is simply a named referenc to a DOM 
element withn a template.  You can view it a something similiar to 
the "id" attribute of an html element.  You mark a DOM element with a template 
reference  and then query it inside a class using the decorator ViewChild decorator.
Here is the basic example:

//Syntax 




//example code 

@Component({
    selector: 'sample',
    template: `
        <span #tref>I am span</span>
    `
})

export class SampleComponent implements AfterViewInit{
	@ViewChild("tref", {read:ElementRef}) tref:ElementRef ;

	ngAfterViewInit():void{
		//outputs `I am span`
		console.log(this.tref.nativeElement.textContent) ;
	}

}



In this example you can see that i specified "tref" as a template reference 
name in html...an drecieved back an "ElementRef" associated with this element.

The second parameter "read" isn't always requir4ed, since angular can infer the 
reference type by the type of the DOM element.  For example, if it's a simple 
html element like span, angular returns "ElementRef"


If it's a template element, it ruents "TemplateRef"


RECAP :   tref --> average, standard html tag attribute then we get back: ElementRef
          tref --> custom template element attribute then we get back : TemplateRef



Some references , like "ViewcontainerRef" cannot be inferred and have to be asked for
specificaly in "read" paramter...


Others, like "ViewRef" cannot be returned form the DOM and have to be constructuced manullay





ElementRef
=========================================================================
This is the most basic abstraction.  If you observe it's class structure, you will
see that it ony holds th enative element it's assocated with.

It's useful for accessing native DOM elements as we can see here...:


//code
//outputs `I am span`

console.log(this.tref.nativeElement.textContent) ;




^^^ this is discoraged as it is a potential security risk and 
tightly couples your implementation to specific browser implementations...

ElementRef can be returned fro any DOM element using ViewChild decorator.

But since all components are hosted inside a custom  DOM element and all directives are applited to DOM elements, component and 
directive classes can obtain an instace of ElementRe associate with their
host element through DI mechanism:


@Component({
	selector: 'sample',
	...
})


export class SampleComponent{
	constructor(private hostElement: ElementRef){
		console.log(this.hostElement.nativeElement.outerHTML	
	}	
}


So while a component can get access to it's own host element through DI, the 
ViewChild decorator is used most often to get a referenc to a DOM element
in their view (template).   And it's vice verse with directives --- they have no views and they usually work directly with the element they are attached to....




TemplateRef
=========================================================================
The notion of template should be familar for most web wevelopers.  It is a group
of DOM elements that are reused in views across the app.  Before HTML5 standard introduced template tag, most templates arrived to a browser wrapped in a script tage with some variations of
"type" attribute....

for example....


<script id="tpl" type="text/template">
	<span> I am span in template</span>
</script>


the above had many drawbacks like the semantics and the necessity to manullay create DOM models.
With the "template" tag a browser parses html and create3 DOM trees but not renders it.
It then can be accessed through content property.

<script>
	let tpl = document.querySelector('#tpl');
	let container = document.querySelector('.insert-after-me') ;
	insertAfter(container, tpl.content) ;
</script>
<div class="insert-after-me"></div>
<ng-template id="tpl">
    <span>I am span in template</span>
</ng-template>

