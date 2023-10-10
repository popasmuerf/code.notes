 # Undoing Things

 At any stage, you may want to undo something.
 Here, we will review a few basic tools for undoing changes that we ahve made.  Be careful, because you can't always undo some of these
 "undos."

 NOTE: This is one of the few areas in Git where you may lose some work if you do it wrong.

 # Common Undos
 -> commiting too early 
 -> forgetting to add some files 
 -> messing up a commit message.



### --amend 

-> we can use the --amend flag to 
to amend a commit.
-> The command takes your staging area and uses it for the commit.
-> If you have made no changes ins your last commit, then your snampshot will look exacty
the same, and all you will change is your commit mesage.

#### Scenario: I commit and then realize I forgot to stage the changes in a file I wante dto add to this commit
	> touch apple.txt
	> touch pear.txt
	> git add ./apple.txt
	> # we 'forget' to stage pear.txt
	> git commit -a -m "first commit for text files apple.txt and pear.txt"
	> #Oh shit, I forgot to stage pear.txt before the commit
	> #Time to amend my previous stage and commit 
	> git add pear.txt
	> git commit --amend
	> #Now we have a single commit...not an additonal one...just an ammendment of the last commit you made



### Unstaging a Staged File 
	-> When you need to wrangle our staging area and working directory changes.
	-> Comes in handy when you absent-mindedly stage everything but you only wanted to stage particular resources
	-> Example:

		mikeyb@Michaels-MacBook-Pro benchmarks % echo "#include <cherry.h>" > cherry.txt 
		mikeyb@Michaels-MacBook-Pro benchmarks % git status
		On branch main
		Untracked files:
		  (use "git add <file>..." to include in what will be committed)
			cherry.txt

		nothing added to commit but untracked files present (use "git add" to track)
		mikeyb@Michaels-MacBook-Pro benchmarks % git add .
		mikeyb@Michaels-MacBook-Pro benchmarks % git status
		On branch main
		Changes to be committed:
		  (use "git restore --staged <file>..." to unstage)
			new file:   cherry.txt

		mikeyb@Michaels-MacBook-Pro benchmarks % git reset HEAD cherry.txt  
		mikeyb@Michaels-MacBook-Pro benchmarks % git status
		On branch main
		Untracked files:
		  (use "git add <file>..." to include in what will be committed)
			cherry.txt

		nothing added to commit but untracked files present (use "git add" to track)
		mikeyb@Michaels-MacBook-Pro benchmarks % 

The command is a bit strange, but it works.
The cherry.txt file is modified but once again unstaged.


NOTE:
While git reset can be a most dangerous command if yu call with the switch --hard, 
in this instance the file in your working directory is not touched.
Calling git reset without an optin is not dangerous....as it only touches your staging area.






Ok....but why didnt' we just run the command ?:

	> git rm cherry.txt --cache 