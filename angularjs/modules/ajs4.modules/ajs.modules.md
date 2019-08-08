Angular - Module
==========================================

Modules in ajs refers to a place where you can group :
	-	components
	-	directives
	-	pipes
	-	services
all relatd to the application


In case you are developing a website, the header, footer, left
center and the right section become part of a module.


To define module, we can use the NgModule directive.  
When you create a new project usint ajs cli, the ngmodule is creted in the
app.module.ts file by default and it looks as follows....

//code for app.module.ts
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppComponent } from './app.component';

	@NgModule({
	   declarations: [
	      AppComponent
	   ],
	   imports: [
	      BrowserModule
	   ],
	   providers: [],
	   bootstrap: [AppComponent]
	})

	export class AppModule { }






