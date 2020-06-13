For big size files, a user should, when downloading, wait for a period 
of time.  You need to provide some following information to the
browser
==========================================================



Content-Disposistion
------------------------------------------------
Content-Disposistion: means information on the 
Header part of Response.
It shows the contents expected to be displayed on the browswer.

	*inline: Content that will display automatically
	*attachment: Attached fi


So if we wanted serve a file to be downloaded as an attachement:

Content-Disposistion:inline
Content-Disposistion:attachment
Content-Disposistion:attachment; filname="java-tutorial.pdf"

Content-Type
=========================================
this information is helps a broswer to know which applications
can open this content and suggest to uses to open a program
available on their computer when the content is downloaded 
successfully.   

Set

	Content-Type=application/octet-stream 

if you want the browser to download such content immediately without
asking users....



Content-Type:application/octet-stream
Content-Disposistion:attachment;filename="picture.png"

Content-Type:application/png
Content-Disposistion:attachment'filename="picture.png"


Content-Type:image/png
Content-Disposistion:inline;filename="picture.png"


I am not sure you are using the correct toolset for the job.

1. PHP is a server side technology.  You are trying to build a client
   
2. BASH is a command shell

3. Java...well Java is general purposes programming language...that is mostly 
   used for Server/Backend applications...tho it has and is continued to be used
   for game engines...front end clients...native apps..etc

4. DreamWeaver is for site design.

Start with the basics I laid out...then when you are confident enough read 
up on those three front-end frameworks I listed...decide which one you want 
to use...and you should be set.


