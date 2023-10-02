   git rm  <file>
   git rm -f <file>
   git rm --cached <file>
   git mv <old-name> <new-name>
   git log 
   git log -p -2
   git log --stats
   git log --pretty
   git log --pretty=oneline 
   git log --pretty=format:"%h %an, %ar : %s"
   git log --short
   git log --full
   git log --fuller
   

#globbing 
You can pass files, directories, and file-glob patterns to 
the git rm command however they need to be character escaped.



   git rm log/\*.log 
   git rm /*~



Unlike many other VCS systems, Git doesn't 
explititly track file movement.  If you rename 
a file in Git, no metadata is stored in Git that tells gityou renamed the file, however Git is pretty 
smart about figring that out after the fact.


Always remember that git keeps it's own database that is completely seperate from 
the filesystem's journaling database.


if I used bash's mv command on a file tracked by git...and you want the change to  
be mirrored in the git database(git knows this is the same tracked file...but the name change won't be mirrored in the Git
git database )...you must then bother with the following starting 
from the actual mv:

   mv foo bar 
   git rm -f foo  # we use -f as we assume that it is being tracked 
   git add bar


https://github.com/schacon/simplegit-progit


