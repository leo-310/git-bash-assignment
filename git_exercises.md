# master
Just to verify that the setup is complete.
 ```shell
   git verify 
```

# commit-one-file
Add a file to staging area and commit it along with a message
```shell
git add A.txt
git commit -m "add A.txt"
git verify
```
# commit-one-file-staged
Used reset command to remove the files from staging area that have not been committed.

```
git reset
git add A.txt
git commit -m "add A.txt"
git verify
```
# ignore-them

Created a .gitignore file 
```
vim .gitignore
```
stored the following file types : 
 ```
 *.exe
*.o
*.jar
libraries/
```
Then ran the following command to commit : 
```
git add .
git commit -m "ignored files"
git verify
```
# chase-branch
Initially the commit tree looks like this : 
```
   HEAD
     |
chase-branch        escaped
     |                 |
     A <----- B <----- C
```
 Now, to merge the chase-branch with the escaped branched I used the folowing command :
 ```
git merge escaped
git verify
```
Now the commit tree looks like this :
```
                    escaped
                       |
     A <----- B <----- C
                       |
                  chase-branch
                       |
                      HEAD
```
# merge-conflict

Our current commit tree looks like this : 
```
        HEAD
         |
    merge-conflict
         |
A <----- B
 \
  \----- C
         |
another-piece-of-work
```
We need to make it like this : 
```
                HEAD
                  |
             merge-conflict
                  |
A <----- B <----- D
 \               /
  \----- C <----/
         |
another-piece-of-work
```
So I ran `git merge another-piece-of-work` and it gave me the following conflict.
```
$ git merge another-piece-of-work
Auto-merging equation.txt
CONFLICT (content): Merge conflict in equation.txt
Automatic merge failed; fix conflicts and then commit the result.
```
The conflice was in equation.txt, so I viewed it and it showed the following : 
```
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
Then I changed the content in equation.txt to 2+3=5 using the vim editor, then added and commited.
```
git add equation.txt
git commit -m "resolve conflict"
git verify
```

# save-your-work

used the command 
```
git stash
```
which saved the current uncommitted changes.
Then viewed using `cat bug.txt`.It displayed the following :
```
This file contains bug
It has to be somewhere.
I feel like I can smell it.
THIS IS A BUG - remove the whole line to fix it.
How this program could work with such bug?
```
removed the intended line, added and commited bug.txt.
used ` git stash pop ` to return to previous uncommitted changes.
Added "Finally, finished it!" at the end of bug.txt and committed.
```
echo "Finally, finished it!" >> bug.txt
git add bug.txt program.txt
git commit -m "finish work"
git verify
```
# change-branch-history

Initial commit tree looked like this :
```
        HEAD
         |
change-branch-history
         |
A <----- B
 \
  \----- C
         |
     hot-bugfix
```
we have to make it like this :
```
                  HEAD
                  |
         change-branch-history
                  |
A <----- C <----- B
         |
     hot-bugfix
```
Used the following command to change the base of change-branch-history commit to hot-bugfix :
```
git rebase hot-bugfix
git verify
```
# remove-ignored
Used -- to remove the the file only from staging area and not from the working directory permanantly :
```
git rm --cached ignored.txt
git commit -m "remove ignored.txt"
git verify
```

# case-sensitive-filename
Renamed File.txt to file.txt using ` git mv File.txt to file.txt `, then added and commited.

```
git mv File.txt file.txt
git add file.txt
git commit -m "Rename File.txt to file.txt"
git verify
```
# fix-typo
Read and fixed the typo error in nano editor by using 
```
nano file.txt
```
then added and committed using --amend flag which basically makes changes to the most recent commit :

```
git add file.txt
git commit --amend -m "Add Hello world"
```

# forge-date
used --no-edit to make no changes in the commit message and --date to change the date
```
      git commit --amend --no-edit --date "Mon 10 March 1987 12:00:16 IST"
      git verify
```
# fix-old-typo

Firstly used 
```
git rebase -i HEAD~2
``` 
to open interactive rebase to edit last 2 commits
then changed `pick e794bf2 Add Hello world` to `edit e794bf2 Add Hello world` by pressing ctrl+x and exited the editor.
then fixed the typo in file.txt, added and amended to commit.
```
git add file.txt
git commit --amend
```
fixed the commit message in the editor to "Add hello world"
then 
``` 
git rebase --continue
```
A merge conflict arises, edited the content in file.txt and changed it to 
```
Hello world
Hello world is an excellent program.
```
Then finally added and continued and made no changes in the last commit.
```
git add file.txt
git rebase --continue
git verify
```
## Finally Finished! :')