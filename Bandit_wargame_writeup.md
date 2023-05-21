# Level 0
Used `ssh bandit0@bandit.labs.overthewire.org -p 2220` to connect to remote server on port 2220 with username and password as bandit0.

# Level 0 to 1
Used `cd` to navigate to home directory, then used `ls` to list all files, then used cat readme to display password **NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL**. Then logged out using `exit` command and used `ssh bandit1@bandit.labs.overthewire.org -p 2220` and entered the password.

# Level 1 to 2
Used `cd` to navigate to home directory, then used `ls` to list all files, then used `cat ./-` to display password **rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi**. Here I used `./` to ensure that `–` is a file in current directory and not a Then logged out using exit command and used `ssh bandit2@bandit.labs.overthewire.org -p 2220` and entered the password.

# Level 2 to 3
The password **aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG** for next level was stored in the file named as "spaces in this filename".Since it had spaces I used the command `cat spaces\ in\ this\ filename` to ensure that the whole was a single file.

# Level 3 to 4
The password **2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe**, for the next level was stored in a hidden file in the _inhere_ directory. So I used `cd inhere` to go to the _inhere_ directory. Then I used `ls -a` to view the hidden file, and then used `cat .hidden` to display the password.

# Level 4 to 5
The password **lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR** was stored in a single human readable file out of 10 files in the _inhere_ directory. Since the file names were starting with - I used command `cat ./-file*` to ensure that is was a file name, also I used `*` which displayed all the files at once instead of displaying them individually, from there I got to see that file -file07 contained the human-readable password.

# Level 5 to 6
Firstly I used `ls` to display all the files/directories, and there were 20 directories. So I used `du` command which displays the file space usage along with `-a` which checks all the files in all the directories and `-b` which displayed the file sizes in bytes. `du -a -b` displayed all the files with their file sizes in bytes, from there I found _.file2_ from directory _maybehere07_ had the size 1033 bytes. Then I used `cd maybehere07` and `cat ./.file2` and got the password to be **P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU**.

# Level 6 to 7
For finding a file belonging to user bandit7 and group bandit6 with size 33bytes I used the following command,
``` find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null ```
Here,
* `find` : is used to find files/directories.
* `-type f` : is used to search only regular files excluding directories and other files.
* `-user bandit7` & `-group bandit6` : is used to specify that the file must belong to user bandit7 and group bandit6.
* `-size 33c` : ensures that the file must be exactly 33bytes in size.
* `2>/dev/null` : redirects the standard error output of the find command to `/dev/null` to prevent error message from being displayed on the terminal.

Hence I found the path of the file as _/var/lib/dpkg/info/bandit7.password_ and used the `cat` command to display the password, which is **z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S**.

# Level 7 to 8
Firstly I used `ls -a` to list all the files and found data.txt which contained lots of random words with the password somewhere between. So I used the `grep` command which find specific pattern in a file. Using ` grep "millionth" data.txt` gave me the word millionth along with the password next to it, which was **TESKZC0XvTetK0S9xNwm25STk5iWrBvP**

# Level 8 to 9
To find the password of the next level I use the following command `sort data.txt | uniq -u`.
Here,
* `sort` : is used to sort all the lines of data.txt in alphabetical order.
* `uniq -u` : is used to filter out all the duplicate lines and leaving the non-repeating lines.
* `|` : is used to pipe the output of `sort data.txt` as input to `uniq -u`.
Hence, I got the password to be **EN632PlfYiZbn3PhVK3XOGSlNInNE00t**

# Level 9 to 10
``` strings data.txt | grep "=" ```
Here I firstly used `strings data.txt` command to extract all the human-readable strings, then piped it into `grep "="` which displayed all the lines containing "=". Hence I found the password along with a series of "=", which was **G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s**

# Level 10 to 11
Since the password was encoded in base64 format, I used the `base64 -d data.txt` command to decode the data inside data.txt, where `-d` tells base64 to decode the data in data.txt. Hence I got the password **6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM**.

# Level 11 to 12
Here, I used the command,
```cat data.txt | tr "A-Za-z" "N-ZA-Mn-za-m"```
where tr is used to perform ROT13 decryption on the contents of data.txt, which basically rotates the alphabets to their 13th position. Hence the decrypted data was "_The password is **JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv**_".

# Level 12 to 13

Firstly I made a new directory by `mkdir /tmp/ayush` and copied the file _data.txt_ to that directory by `cp data.txt /tmp/ayush/` . Then I used `xxd -r data.txt > data` command to reverse hexdump and put it into file data. Then I used file data to indentify the file type, then used the following commands for the respective file types : 
* For _gzip_ file : 
    * `mv data data.gz`
    * `gzip -d data.gz`
* For _bzip2_ file : 
    * `mv data data.bz2`
    * `bzip2 -d data.bz2`
* For _tar_ file : 
    * `mv data data.tar`
    * `tar -xf data.tar`
Since the file was compressed multiple times I had to decompress it multiple times depending upon its file type. Finally I received a file _data_ whose type was ASCII text, used `cat data` and received the password : **wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw**.

# Level 13 to 14
First I used `ls -a` to list all files and found a file named sshkey.private . Then to log into the next level I used the command `ssh sshkey.private bandit14@localhost -p 2220` .

# Level 14 to 15
Here first I ran the command  `cat /etc/bandit_pass/bandit14` to get the password of the current level : **fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq**.
Then I ran command `nc localhost 30000`

Where nc stands for netcat it is used to read and write data between 2 computer networks. Submitted the current password and got the password for the next level : **jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt** .

# Level 15 to 16
In this level I used `ncat --ssl localhost 30001` to submit the password of the current level and then received the password for the next level : **JQttfApK4SeyHwDlI9SXGR50qclOAil1**.

# Level 16 to 17
First I ran the code `nmap 127.0.0.1 -sV -p 31000-32000 localhost` to scan all the ports ranging from 31000-32000. The
-sV is flag to tell the versions of the open ports found during the scan. We can see that the port 31960 is open and speaks only ssl, hence it is the server we have to connect to.
Then I ran ` ncat --ssl localhost 31790` command and submitted the password of the current level and got a rsa private key.
Then I stored the key in a file key17 using the following commands and unlocked level 17: 
```
vim key17
ssh -i key17 bandit17@bandit.labs.overthewire.org -p 2220 
```

# Level 17 to 18
First I ran the `diff passwords.new passwords.old` command which lists the differences between files. Here it displayed two passwords. Then I tried both the passwords one by one and the actual password was : **hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg**.

# Level 18 to 19
In this level the user gets logged out as soon as he tries to login, but there is a very small time frame before getting logged out, so I used the command : `ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme` to execute the password as soon as I login. The password for the next level was **awhqfNnAbc1naukrpqDYcF95h7HoMTrC**.

# Level 19 to 20
In this level first I executed the file _bandit20-do_. It said to run a command as another user, hence I used ` ./bandit20-do cat /etc/bandit_pass/bandit20` as the password was stored in /etc/bandit_pass20 and I got the password for the next level : **VxCazJaVykI6W36BkBU0mJTCM8rR95XT**
