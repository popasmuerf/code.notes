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