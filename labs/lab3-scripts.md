# Lab 3: Scripting

Follow all the steps below for practice with writing scripts. There are two scripts you will develop in this lab. Commit both to your forked copy of the course repository, and paste both URLs into the answer for submission.


## `bash` Mad-Lib

1. Create a new file `madlib.sh` and edit it using `nano`:

2. Add a "shebang" line to the first line of your file.

3. Two lines lower, clear the screen and add an introduction to the user:

```bash
clear
echo "Let's build a mad-lib!"
```

4. Next, start the logic of your script. Use the format below for collecting at least eight (8) variables. Each should have a different prompt and a different variable name. You may want to use ALL CAPS for variables simply for visibility while programming:

```bash
read -p "1. Please give me an adjective: " ADJ1
```
5. Repeat the `read` lines to gather nouns, verbs, adjectives, adverbs totaling at least eight. (More are fine!)

6. Next, use one or more `echo` commands to tell a story using all the words you have collected. Think of this as a "Once upon a time ..." story, or a "And then ..." story. There are plenty of examples online. Your code should gather user input and then tell the story using those inputs.

7. Save your file. `chmod` it appropriately and test it. Debug as needed.

8. The file you add, commit, and push should execute flawlessly. We will run your script and test it for accuracy.

## Python3 and `env` variables

For this script you will need Python3 installed on your local system. See [these directions](https://realpython.com/installing-python/) to get started. If you cannot get Python3 installed, use a code block of [Google Colab](https://colab.research.google.com) for this assignment then save your code to a local file and submit via GitHub.

Python3 should be available in your path. Use `which python3` to find the path. It should be something like `/usr/bin/python3`

1. Create a new script called `env-vars.py` and open it in an editor.

2. Put your Python3 path in a shebang line.

3. For this script you will be working with reading user input and setting and fetching `env` variables. To work with `env` variables you need one import:

```python3
import os
```

To set a variable, declare the `var` name and assign it a value. NOTE that `env` variables MUST be `string` data only. Here are some examples:
```python3
import os

os.environ["FAV_FLAVOR"] = "Vanilla"
os.environ["AGE"] = "34"
os.environ["UVA_FIRST_YEAR"] = "True"
```

4. For this script you will also be using the python3 `input` functionality. This is much like the `read -p "Prompt statement" VARNAME` in bash. The point is to prompt the user for input, and store it programmatically in a variable for later use.

Here are some examples of `input` in Python:
```python3
FAV_FLAVOR = input('What is your favorite flavor? ')
AGE = input('What is your age? ')
UVA_FIRST_YEAR = input('Are you a first-year student at UVA?' )
```

Remember that all of these prompts will be stored as strings.

5. Using at least three prompts of your own making, which populate three variables that go with them, use those input values to populate three environment variables.

6. Finally, build a series of print statements that ONLY print out those environment variables (not the initial variables themselves).

To fetch and print an environment variable in Python3:
```python3
import os

# set the var
os.environ["ZIP"] = "22903"

# fetch the var
ZIP_ENV = os.getenv("ZIP")

# print the var
print(ZIP_ENV)

# or skip setting an intermediary variable and:
print(os.getenv("ZIP"))
```

7. Your script when run should prompt for three values, store three values as `env` variables, and print out those three `env` variables without errors.

## Submitting your work

This lab has you create two scripts. They should be put into a folder `ds2002-course/mywork/lab3` within your fork of the course repository, added, committed, and pushed. Then send the two (2) URLs - one for each file - in the text box within Canvas.
