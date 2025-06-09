# Introduction to Bash Scripting

This lecture will cover: 

## Introduction to the Shell and Bash

* What is a shell? 

A shell is a program that provides a command-line interface allowing users to interact with their operating system. It interprets the commands you type and translates them into actions the computer can perform. Essentially, you are communicating with you computer in a language you and your computer both understand. There are many types of shells available, each wth its own syntax and features. Some popular ones include sh (Bourne shell), csh (C shell), ksh (Korn shell), and bash (Bourne Again SHell). 

* What is Bash?

As stated above Bash stands for Bourne Again SHell. It is one of the most commonly used Unix shells today, especially on Linux and macOS systems. 

Bash is a command language interpreter that allows you to: 

- Run commands interactively at a prompt.
- Write scripts that automate sequences of commands.
- Manage variables, control flow, and input/output redirection in scripts. 

It combines features from earlier shells, offering a powerful and flexible environment for seamlessly moving around your local machine and HPC systems as well as scripting. 

In another life, I would have been a history professor. As such, we will delve into a bit of the history surrounding the origin of bash scripting. 

* Shell Scripting Historical Background

The Bourne Shell (sh) was developed by Stephen Bourne at AT&T Bell Labs in 1977. The Bourne shell became the standard Unix shell for many years because of its scripting capabilities, allowing user to automate tasks in Unix environments. 

In the 1980s, other shells emerged  with new features and improvements. The C shell (csh), for example, provided a syntax resembling the C programming language, and the Korn shell (ksh) introduced advanced scripting features that appealed to developers. 

By the late 1980s, with the rise of the GNU Project, there was a need for a free, open-source shell that combined the power of Bourne shell with enhancements fom Korn and C shells. This led to the invention of bash by Brian Fox in 1989. 

Bash was designed as a replacement for the Bourne, compatible with its syntax but incorporating many modern features such as command line editing, improvided scripting syntax, and better user interactivity. It became the default shell on most Linux machines and later on macOS. 

* Why should we be using bash scripting in data science?

As budding data scientists, much of our work relvolves around managing files, running analyses, and automating repetitive tasks across different computing environments. Bash scripting is a powerful tool to help us do all this efficiently. Bash scripting is particualrly useful for a number of tasks you will encounter in your workplaces:

* Efficient File and Directory Management

Using bash scripting we can quickly navigate directories and organize files. We can also rename, move, or delete files in bulk. One other thing I have found particularly use file is extracting or combining parts of files using tools like grep, awk, and cut. 

* Automation and Reproducibility

Bash scripts allow us to automate sequences of commands, reducing manual effort. If your scripts are well commented and automated, you can pass them along to your friends and collegues to use on their machines as well. This enhances reproducibility, which is what we strive for in science. 

* Interfacing with High Performance Computing

In your positions you might find yourself working on internal HPC systems. HPC systems usually require jobs to be submitted via command-lin job schedulers such as SLURM (Dartmouth). Bash scripts provide a way to write job submission scripts that define job resources, load software modules, and run your code or pipeline. This is a great way to prevent human error and not use all the RAM on your local machine to process your data!

* Integration with Other Tools and Languages

We can use bash scripting to call to Python, R, or other data analysis tools. We can also use command line utilities for data processing (sed, awk, sort, etc.)

## Basic Commands

Before we jump into bash commands, you need to access a terminal (command-line) environment where you can type and run these commands. 

* Mac Folks

Open Finder. Navigate to Applications > Utilities. Click on Terminal to launch it.

If you can't find the Terminal that way, you can use Spotlight Search (command + space), type Terminal, and press Enter. A terminal window will open, showing a prompt where you can enter commands. 

* Windows Folks

Windows does not natively include a Unix-style shell, but you can use Windows Subsystem for Linux (WSL). WSL allows us to run a genuine Linux environment, including Bash and most command-line tools, directly on Windows 10 or 11. This menas that Windows users can run bash scripts, use Unix commands, and nstall Linus software alongside their Windows apps. 

The Microsoft documentation you need to install this can be found (here)["https://learn.microsoft.com/en-us/windows/wsl/about"]. This link provides step-by-step installation instructions and guidance on using your favorite Linux distributions (Ubuntum Debian, Kali, openSUSE, etc.) on Windows.

## Basic Commands and How to Use Them
There are a few sets of commands I would like to cover in today's lecture: navigating filesystems, viewing file contents, and file and directory manipulation. We will begin with navigating filesystems.

* Navigating Filesystems

1) pwd
Once you have your terminal open on your computer, go ahead and enter this command: 

```bash
pwd
```

What does this return? It should be something like:

```bash
/Users/noellekosarek/Desktop/
```

The `pwd` command returns our current directory. This is the location that we are at in our computer. The equivalent of this would be us opening up our finder and selecting our Desktop. This means that our computer can see all of the files we have on our Desktop. 

Let's say we want to store our current directory as variable so that we can access it easily:

```bash
current_dir=$(pwd)
echo "You are currently in: $current_dir"
```

In the above directory we have stored the path of our current directory in a variable called "current_dir". The `$` is used to reference the value of a variable. When we set the `current_dir` we are referencing the output of `pwd`. When we are using the value stored in the `current_dir` later, we use the `$` to access the stored value. 

2) ls

`pwd` gave us the power to se where we are in our machine. `ls` gives us the power to list the files in our current directory. 

Go ahead and type in the following command:

```bash
ls
```

This command should return a list of all the files in your current directory. For me, it lists all of the files on my Desktop. 

Now, computers do some funky things, including creating hidden files that we typically do not see in our Finder. If we want to see what hidden files are in our current directory we can type the following command: 

```bash
ls -lah
```
`-lah` is a series of flags that mean the following:

`-a` - shows hidden files (`.` prefix)
`-l` - uses long listing format
`-h` - formats sizes human-readably

3) cd

We can't stay in our current directory forever! What if we want to take a look at the file in our Documents directory or perhaps in a particular project directory, we can do this with the `cd` command.

The following command can be usd to get to my home directory from anywhere:

```bash
cd ~
```

We can also move up one directory with the following command:

```bash
cd ..
```

We can also use absolute paths in order to jump from one location using `cd` to another. You can simply insert the path to which you woul dlike to navigate like this: 

```bash
cd /Users/noellekosarek/Desktop/project1/scripts
```

4) mkdir

`mkdir` creates a new directory.

```bash
mkdir my_new_project
```

We can leverage flags once more to create nested directories in one command:

```bash
mkdir -p my_new_project/scripts/preprocessing
```

5) cp

The `cp` command is usedt o copy files from one directory to another. To test out this command, let's go into a text editor and make a text file containing a bit of our own data. I've added a .txt file to my Desktop called "test.txt". In this file I've just added a sentence. Now I can use the `cp` command to copy this file from my Desktop to my Documents I can implement the following command:

```bash
cp /Users/noellekosarek/Desktop/test.txt /Users/noellekosarek/Documents/test2.txt
```

We can also copy entire directories from location to another location using the `cp` command along with the `-r` flag which stand for "recursive". To do this we run the following command: 

```bash
cp -r source_folder destination_folder
```

You can se the source directory here to, perhaps, the directory for this class that you have on your local machine and you can copy it over to your GitHub directory or some other location. 

6) mv

`mv` moves or renames files or directories.

If this command is implemented on a file in the same directory it will rename this file. Run this line on that file we previously created (MAKE SURE YOU ARE IN THE CORRECT DIRECTORY!):

```bash
mv test.txt test_new_name.txt
```

7) cat

This command prints the contents of a file in our current directory. It can also print the contents of a file in a different directory if we provide the command an absolutely path to that file:

```bash
cat test_new_name.txt
```

This should print out the contents of our file. 

8) rm

The last command we will discuss in this section is the `rm` command. This command deletes files or directories. To delete the test file we created, we can run this command:

```bash
rm test_new_name.txt
```

If we were hoping to delete an entire directory we can do so using the `-r` flag. This flag removes everything in the directory recursively.

```bash
rm -r folder_to_delete
```

Here is a summary of the commands we used in this section:

| Command | Purpose                              | Brief Description                      |
| --------| ---------------------------------- | ------------------------------------ |
| pwd     | Print Working Directory             | Shows your current directory path    |
| ls      | List files and directories          | Lists contents of a directory        |
| cd      | Change Directory                   | Moves through the directory tree     |
| mkdir   | Make Directory                     | Creates new directory/folder         |
| cp      | Copy files or directories          | Copies files or folders              |
| mv      | Move or rename files or directories | Moves or renames files/folders       |
| rm      | Remove files or directories         | Deletes files or folders permanently |
| cat     | Display file contents              | Prints text file content to terminal |

* Viewing file contents
* File and directory manipulation