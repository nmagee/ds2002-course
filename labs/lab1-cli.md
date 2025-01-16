# Lab 1: The Command Line

Follow all the steps below for practice with the command line. At the bottom are instructions for commands you should write for each prompt, saved to a text file you create using the command line. Upload that file to the Lab assignment page for grading.

You can use the <a href="https://github.com/codespaces/" target="_new"><b>GitHub Codespaces</b></a> for these exercises. Open that page and click on "New Codespace" and select a repository.

> **Advanced Users** - For an additional challenge, complete these exercises on your local laptop using either the MacOS Terminal (Mac) or WSL Terminal (Windows).

## Getting Oriented to your Home Directory

1. Change directories to your home directory by issuing the `cd ~` command. `cd` is short for "change directory". This is a shortcut to your home directory.

```
cd ~
```

Another way to get there is to use the environment variable `$HOME`:

```
cd $HOME
```

2. Learn the location of your home directory by issuing the `pwd` command. `pwd` is short for "present working directory". 

```
pwd
```

3. List all the contents in your home directory by using the `ls` command.

```
ls
```

Next list the contents in a more detailed view

```
ls -l
```

Next try listing all contents, including hidden files and directories

```
ls -al
```

Hidden files and directories start with a `.` such as `.ssh` or `.bashrc`.

Note that the `-al` flags (or options) do not have to be in any particular order. So you could also issue this command:

```
ls -la
```

4. Create two empty files by using the `touch` command

```
touch file1
touch file2
```

List the directory contents again to see the files listed.

Next, try creating two more files within the same command:

```
touch file3 file4
```

5. You can create multiple files with a single command in `bash`. This command will create 10 new files with unique numeric names:

```
touch file-{11..20}.txt
```

You can even create numerous files based on a specific interval. This command creates files from 2 to 20 using only even numbers in the filenames:

```
for i in {02..20..2}; do touch file$i; done
```

6. Add text contents to a file. You can use `echo` to pass some data into a file like this:

```
echo "Hi there everybody, my name is <YOUR NAME>" > file1
```

This command uses a "redirect" to take the `echo` command and push it into `file1`. You could acually just `echo` out anything you want, at any time, but it only prints to the screen and isn't recorded anywhere. Try it for yourself:

```
echo "Today is Friday"
echo "A man a plan a canal Panama"
```

7. View the contents of your file using `cat`. `cat` is short for concatenate, since it can easily join files together, but it's often used simply for reading out the contents of a single
file.

```
cat file1
```

Should result in you seeing the command you echoed into it earlier. You can `cat` out other
files as well:

```
cat .bashrc
```

```
cat README-cloudshell.txt
```

8. Whenever you are in a directory you can read, edit, or list a file easily using its short
name, like this:

```
cat .bashrc
```

But every file or folder can be referred to by its full path within the file structure.
For example, your home directory in the Google Shell might look like `/home/mst3k`, so you can also cat
things using their "full path":

```
cat /home/mst3k/.bashrc
cat /home/mst3k/file1
```

This is extremely useful since it means *you do not have to change into a directory just to
work with its contents*.

9. Move Up and Down Directories

Try changing to the "parent" directory with the `cd` command and the parent directory shortcut `..`:

```
cd ..
```

From your home directory you are now in the `/home` directory. Verify that by issuing the `pwd` command.

You can change back to your home directory in at least three ways. Assuming the home directory is
named `mst3k` and you are in `/home` then:

```
cd mst3k
cd /home/mst3k
cd ~
```

## Working with Folders (Directories)

1. Create a subdirectory

From within your home directory create a new directory using the `mkdir` (make directory) command:

```
mkdir mynewdir
```

List the contents of your home directory and you should see the new subdirectory appear:

```
ls -al
```

2. Can you already guess the full path of the new subdirectory you created? If not, `cd` into
it and then issue the `pwd` command to find out.

3. What if you want to rename a directory? Use the `mv` command:

```
mv mynewdir another-newdir
```

4. To delete a directory, use the `rm` command with the `-r` (Recursive) option. Recursive means you want to delete the directory AND anything within it.

```
rm -r another-newdir
```

5. You can delete multiple objects with a filter in your command. For instance, run this command in a directory:
```
touch z{81..90}.txt
```

You could delete ALL text files in the directory with:

```
rm *.txt
```

You could delete all `.txt` files that contain the number `8` in them with this:

```
rm *8*.txt
```

You could delete all files that begin with `z` with this:

```
rm z*
```


## Working with Text Files

1. A simple, built-in text editor is called `nano`. To open `nano` with an empty, blank document
simply invoke the `nano` program:

```
nano
```

Within the page you see blank space where you will write contents, and a series of possible commands at the bottom marked with the `^` character. This stands for the CONTROL key. If you open a blank document, try writing several lines of text, complete with paragraph breaks and punctuation. When you're done, press `^X` to exit. Upper/lower case does not matter.

This will give you the following prompt:

```
Save modified buffer (ANSWERING "No" WILL DESTROY CHANGES) ? 
```

To save your buffer (your open document) just press the `Y` key. This will give you a final prompt:

```
File Name to write : 
```

Here you can name your file anything you want. It will be saved to the directory you were in
when you opened up `nano`.

2. `cat` out the contents of the file you just edited.

3. Now rename the file you just created by using the `mv` command. The syntax is:

```
mv <ORIGINAL-NAME> <NEW-NAME>
```

So if I just created `hello.txt` in `nano` earlier, I could rename it by moving it:

```
mv hello.txt hello
```
You can always move a file to a completely different location by using a full path reference.

```
mv hello.txt /another/directory/hello.txt
```

4. Pipe one command into another using the `|` character.

Above you saw how a `cat` command could be redirected into a file. There is also the `|` "pipe"
command when you want to couple the text output of one command and process it using a second (or more)
command. 

Since you know `cat` prints out the contents of a file, let's join it with the `wc` (word count)
command:

```
cat hello | wc
```

This will print out three numbers:

```
  171   812   4522
```
This means the file is 171 lines long, contains 812 words, and is 4522 characters long.

You can always request one of these values at a time by using option flags with the `wc` command. If you would like a line count only, use `-l`:

```
cat hello | wc -l
```
For a word count only, use `-w`

```
cat hello | wc -w
```

5. Copy a file or directory. If you have a file or folder you would like to copy, use the `cp` command like this:

For a file:
```
cp file1 file2
```

For a directory we need the `-r` flag to indicate a recursive copy:
```
cp -r dir1 dir2
```

Notice it is a good practice to leave the trailing `/` off of directory names.

## Finding Things

One of the simplest search tools is called `grep` which prints out results based on
"regular expressions" - these are filters, in a way, to help you find things.

1. Let's fetch a large text from a remote source so that we can search through it:

```
curl https://gist.githubusercontent.com/StevenClontz/4445774/raw/1722a289b665d940495645a5eaaad4da8e3ad4c7/mobydick.txt > mobydick.txt
```
You should now have a local file named `mobydick.txt`. Let's search through it using
`grep`, which we will pipe after a `cat` command. `cat` will echo out the text contents into
`grep` which will filter and print ONLY lines where the search term appears.

```
cat mobydick.txt | grep "Captain"
```

2. This prints out a lot of results. What if we wanted to count how many lines the word
"Captain" appears? We can pipe on another command to count lines, like this:

```
cat mobydick.txt | grep "Captain" | wc -l
```

How many lines contain "Captain" in this text?

3. What if we wanted to search across many files for a word? `grep` is still useful here. Issue this command from within your home directory:

```
grep -r "Captain"
```

The output will contain both the file name where the search term appears and the relevant line itself

```
./mobydick.txt:person, yet for Captain Ahab to have a boat actually 
./mobydick.txt:above all, for Captain Ahab to be supplied with five extra 
./mobydick.txt:about to be narrated, never reached the ears of Captain 
./mobydick.txt:handspikes, my hearties. Captain, by God, look to 
./mobydick.txt:Captain Colnett, a post-captain in the English navy, 
```

(Notice that `grep` is case-sensitive, so searching for `captain` will give different results.)

4. Find files by file name. Use the `find` command for this. The syntax is:

```
find . -name "mobydick.txt"
```

This issues the find command, searching the present directory (signified by the `.`)
with the name `"mobydick.txt"`. Note that the filename must be an exact match.

To search across all home directories, for example, you would change the path option

```
find /home -name "filename.txt"
```

5. Find files matching a pattern

Use the wildcard `*` character at the beginning, middle, or end of a term to extend
matching. For example, if you only knew that `moby` was in the name of the file and
nothing more, this command would work:

```
find . -name '*moby*'
```

Or if you wanted to file all text files by suffix in a directory

```
find . -name '*.txt'
```

6. Wildcard matching

The wildcard `*` is useful in many contexts:

List all files ending with `.pdf`

```
ls -al *.pdf
```

Delete all files containing "zero" in the name:

```
rm -R '*zero*'
```

## File Permissions

1. Touch a file named `permission_test` and echo some content into it. 

2. Next use `ls -al` to see it listed in your directory.

3. Now change its permissions to `000` like this:

```
chmod 000 permission_test
```

Try to `cat` the contents of the file. You should get a permission denied message.

4. Now change its permissions so that only you can read and write the file:

```
chmod 600 permission_test
```

Again, `ls` the directory so you can see the permission bits for the file.

5. Finally, let's grant other members of your group read access, along with the access
we already gave you:

```
chmod 640 permission_test
```

List the directory contents once more and notice the permission bits for the file.

Notice the full set of characters in the far left column:

```
-rw-r-----   1 nmagee  staff     0B Jan 16 09:27 permission_test
```

The first character represents what type of object it is, i.e. file (`-`), directory (`d`), link (`s`), etc.

The next 9 characters represent permissions for the USER (i.e. the owner), GROUP, and OTHER machine users.

Each of those entities can have any combination of `rwx` permissions, which stands for READ, WRITE, and EXECUTE. This applies both to files and directories.

So to see `rwxrwxrwx` means the user, group, and other users all have full permissions to read, write, and execute the file/folder. [**Read more here**](https://www.redhat.com/en/blog/linux-file-permissions-explained) about POSIX permissions.

As practice, you should now determine what command is required to allow the USER and GROUP read/write permissions to a file, but no access to OTHER users.


## Utility Commands

These commands are used a bit less frequently but can help with basic tasks.

### `top`

`top` or `htop` shows you current processes, memory and CPU usage. They allow you
to see the `pid` (process ID) for any process, so that you can monitor it or stop (kill) it.

### `w`

`w` (who) shows you current users of your system. Typically if you are on a laptop
or desktop computer you own, you will be the only user. But large HPC computers may
have hundreds of users logged in concurrently.

### `which`

`which` shows you the path to a specific application. For instance, let's find Python3
on the local system:

```
$ which python3
/usr/bin/python3
```

The binary code for Python3 lives within `/usr/bin` - a very normal place for it to be.

You may want to list the contents of the `/usr/bin` directory to get a sense for all the 
built-in commands within the Linux kernel and `bash` shell.

```
ls -al /usr/bin
```

### `zip` and `tar`

- - -

**NOTE**: Windows users with `git-bash` have `unzip` available but not `zip`. I suggest you work
with `tar` instead.

- - -

Compressing or decompressing archives like zips or tarballs is not too difficult:

To create a zip bundle, assuming we are in a directory with `file1` and `file2` we want to zip up:


```
zip archive.zip file1 file2
```

This creates a zip file named `archive.zip` containing the two files. To unzip, the command is
quite simple:

```
unzip archive.zip
```

To create a tarball (the common nickname for a tar compressed archive) we often use it in conjunction with the `gzip` and `gunzip` options to keep the archive as small as possible. Again assuming we have two files in the current directory named `file1` and `file2` we want to put in the bundle:

```
tar -czvf archive.tar.gz file1 file2
```

The `-czvf` options mean: `-c` for CREATE an archive, `-z` for `gzip` the archive,
`-v` for verbose output, and `-f` for write the archive to a file.

To decompress the same archive:

```
tar -xzvf archive.tar.gz
```
The only difference in options is the use of `-x` which means "expand"

NOTE: It's extremely useful to know that in the world of the command line you can always
add or remove files from archives without re-creating them! They are editable objects
using when using either the `zip` or `tar` commands.

### `history`

Displays your history of commands in `bash`. Often this is limited to 1000 but that can
be changed in your `.bashrc` file.

### `!999`

When viewing your history, notice the line number with each command. To repeat an item
in your history, prefix that number with `!`.

## Environment `env` variables

To view your system `env` variables, issue that command:

```
env
```

Take a moment to look through them. These are set by the system for each interactive user session. Some variables are common no matter what system you are on, such as: `HOME`, `USER` (or `USERNAME`), `EDITOR`, `PWD`, or `SHELL`.

Each environment variable is made of a `KEY` and a `VALUE`. You can fetch any value by calling it by key name:

```
echo $HOME
```

You can also set your own `env` variables. To do this temporarily within your current session:

```
FNAME="Waldo"
```

You can now retrieve that value interactively from your current `bash` session. However, if you had software running it would be unable to find this variable.

To make an `env` variable available to other processes, it must be exported. This is how you export:

```
export FNAME="Waldo"
```

This way some code or a script that is running outside of your current session can fetch `$FNAME`.

However, if you were to restart the computer, this `env` variable would not persist. It would be erased upon reboot.

To make an environment variable persist in your account, you can store it in a text file.

For your user account, assuming that `bash` is your default shell, you can edit a hidden file in your home directory, `.bashrc` and insert the same export command:

```
export FNAME="Waldo"
```
Upon your next login, that variable will be available.

If you can become `root` or use the `sudo` command, there is also a system-wide file for these exports. Simply insert your KEY=VALUE environment variable there (no `export` needed). That file can be found at:

```
/etc/environment
```

## Networking / Internet

The Linux OS has several built-in tools for helping check networking, or interacting with remote resources on the Internet.

### `ping`

`ping` is a simple tool that, like its submarine counterpart, simply bounces a message off of a remote host and tells you if it is reachable:

```
$ ping google.com
PING google.com (142.251.167.138): 56 data bytes
64 bytes from 142.251.167.138: icmp_seq=0 ttl=57 time=6.479 ms
64 bytes from 142.251.167.138: icmp_seq=1 ttl=57 time=4.430 ms
64 bytes from 142.251.167.138: icmp_seq=2 ttl=57 time=4.407 ms
64 bytes from 142.251.167.138: icmp_seq=3 ttl=57 time=4.518 ms
```

Press Ctrl+C to stop the `ping`s. Be aware that `ping` just verified two things for us:

1. The host `google.com` is alive and well; and
2. Our current host has an active Internet connection.

### `curl`

`curl` is a basic tool for fetching something from the Internet - a file, web page, zip or tar bundle, CSV or JSON datafile, etc. You used `curl` above to fetch the Moby Dick text. Try it yourself with this list of songs:

```
curl http://nem2p-dp1-api.pods.uvarc.io/songs
```

By default, `curl` displays the contents of what was retrieved. In the case above, you can see the JSON values of a song list. If you wanted to "capture" the data file, you could redirect this command to a file, or use the `-O` flag (Oh, not zero) to save the file.

Note that you cannot use `curl` to fetch password-restricted resources (i.e. from Canvas, or Gmail, etc.)

Another useful trick with `curl` is to find your public IP address:

```
$ curl ifconfig.me
199.111.240.7
```

### `ssh`

`ssh` is the Secure Shell, a method for making secure connections into the terminal of another computer. This might be a computing instance running in the cloud, a supercomputer, or another machine.

SSH connections look very similar to email addresses, in the form of USER @ HOST. (This is no coincidence since email and shell connections are very early Internet tools.)

Try a connection using a password:

```
ssh ds2002@34.201.203.207
```
Connect using the password given to you in the Canvas instructions for this lab.

1. Within the home directory of this shared user account, create a subdirectory named from your UVA computing ID, i.e. `mst3k`. Create a `REAMDE.md` file within that folder that includes your full name.
2. Check the login status of other users with the command `last -i`.
3. View the `history` of this account. Since all students are sharing a single account name, you'll see the history of other students included.
4. To leave the SSH session, type `exit`.

## Your Turn

Now complete the following steps on your own. Save the commands necessary to complete these steps in a single text file as you do your work. This should contain 10 lines of commands (based on these 10 prompts). BE SURE TO NUMBER each command, or use comments in the code. Copy and paste those lines to a [**GitHub Gist**](https://gist.github.com/) and save it as a private gist. Paste your GitHub Gist URL in the Lab 1 assignment in Canvas.

1. Using the terminal change directories to your home directory. 

2. Create a "development" subdirectory within your home directory.

3. Touch a file within that directory named "README.md".

4. Echo the name "DS2002" and redirect it into that file.

5. Now append your name to an additional line in that file by using the `echo` command.

6. Touch 25 files whose names contain the numbers 101 to 200 counting by 4. (i.e. `file101.txt`, `file105.txt`, `file109.txt`, etc. as you choose.)

7. Touch another file within that directory named `bash_history`.

8. Use the redirect character to pass your bash history into the `bash_history` file.

9. Show the command to either tar or zip the "development" subdirectory with all files inside of it, *including* the directory itself.

10. Write a line of code that exports a `FAVORITE_FLAVOR` environment variable, with a corresponding value (vanilla, caramel, salty, chocolate, etc.) into your `~/.bashrc` file.