url:https://www.atlassian.com/git/tutorials/syncing
url:https://www.atlassian.com/git/tutorials/using-branches

git synching ----- git remote
===================================================

SVN uses a singl centralized repository to serve as the communication hub for 
developers, and collaboration takes place  by passing changesets between
the developers working copies and the central repo.

This is not how Git does things....


Git uses a truely distributed collaboration model, which gives every developer
their own copy of the reposity , complte with it's own local histor and branch 
tructure.


Users typically need to share a weries of commits rather than a single changeset.

Instead of commiting a changeset from a working copy to the cetral repority,
Git lets you share entire branches between repositories.



The git remote command is one piece of the broader system which 
is responssible for syncing changes.  Reocords rgistered
through the git remote command are used in conjucntion with
the commands

	> git fetch
	> git push
	> git pull


These commans also have their own syncing reponsiblilities.....


> git remote
=========================================================
The git remote command lets you create, view and delete
connections to other repositories.  Remote connections are
more like bookmarks rather than direct  links inot other
repositories.  Instead of providing real0time access to another
repository, they serve as convenient names that can be used to
reference cumbersome URLs





>git remote #usage overview
========================================================
The git remote command is essentailly an interface for managing 
a list of remote entries that are stored in the 
repository's file:


	./.git/config


> cat ./.git/config 
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = https://github.com/popasmuerf/code.notes.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master



Listing the remote connections you have to other repositories

	> git remote -v


Creating and modifying git remote configurations
=============================================================
The command is also a convenience or 'helper'
method for modifying a repo's 

	./.gitconfig file
> git remote add <name> <url>


WE can create a new connection to a remote repository.
After adding a remore, you will be able to use <name> as a convenient
shourt cut for <url> in other Git commands...


> git remote rm <name>

Removes the connection to the remote repository called <name>


> git remote rename <old-nam> <new-name>

Rename a remote connection from <old-name> to <new-name>





Git remote discussion
========================================================
Git is designed to give each developer an entirely isolated
development enviroment.  This means that information is not
automatically passed back and forth between repositories.

Insteadd, developers need to manulallypull upstream commits
into their local repos or manaugally push their local commits
back up to the central repository.  The git remote command
is really just an easier way to pass URLs to these "sharing" 
commands ..





The origin Remote
===========================================================
When you clone  a repo with git clone, it automatically
create a remote connection called 

	origin

pointing back to the cloned repository.  Ths is useful for 
developers creating a local cop of a central repo, since it provides a 
an easy way to pull upstream changes or publish local commits.

This is why most projects using Git for version control 
call their central repository "orgin"













For example, the followning diagram shows two remote
connectis from your repo into the central repo and another
developer's(John) repo.  Insrtad of references the by their full URLs,
you can pass the origin and John's shortcuts to other  Git commands...



(my repo)  ----------------------> Central Repo
|
|
|--------------------------------> John's Repo







Git fetch
================================================================
> git fetch
	*	git fetch downloads from a remote repo
		-	commits
		-	files
		-	refs

	*	Fetching is wht ou do when you want to see what everybody else
		has been up to

	*	Similar to "> svn update" in that it allows you to see the progress
		so far reflected in the history of the central repo.
		except for the fact that >git fetch doesn't force a merge(that's 
		> git pull)

	*	git isolates fetched content from existig local content, it has
		absolutely no effect on your local development work.

	*	Fetcched content has to be explicitly checked out using the 
		command:
			> git checkout

	*	fetching is a safe way to review commits before integrating them
		with your local repository

	*	> git pull
		-	under the hood executes both
			*	> git fetch
			*	> git merge



How git fetch works with remote branches
=================================================================
To better understand how git fetch works let us discuss how
Git organizes and stores commits.

Behind the scenes, in the reporsitory's ./git/objects directly, Git stores all
commits local and remote....

Git keeps remote and local branch commits distinctily separte for 
obvious reasons ...through the use of branch refs.


The refs for local brdanches re stored int he ./git/refs/heads


Executing the git branch command will output a list of the local branch refs.

	> ls ./.git/refs/heads
	master



Git branching
====================================================================
url:https://www.atlassian.com/git/tutorials/using-branches

In Git, branches are a part ofyour everyday development.
Git branches are effectively a pointer to a snapshot ofyour changes.  When you
wnat to add an w feature or fix a bug --no matter how big or
how samll.

