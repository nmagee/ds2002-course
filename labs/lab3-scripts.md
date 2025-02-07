# Lab 3: Basic Scripting

Follow the steps below for practice with writing scripts. There are two scripts you will develop in this lab - one in `bash` and one in `python3`. Commit both to your `ds2002-scripts` repository and submit the URL to your repo for grading.

## 3. Use Python to fetch remote data

For this script you will need Python3 installed on your local system.

Python3 should be available in your path. Use `which python3` to find the path. That path should be something like `/usr/bin/python3`

You will also need to install the `requests` library for Python. To do this, run this command:

```
python3 -m pip install requests

# or

pip install requests
```

1. Create a new script called `github-events.py` and open it in an editor.

2. Put your Python3 path in a shebang line. Use the command below to find your `PATH` to python:

    ```
    which python3
    ```

3. For this script you will need to set an environment variable in your `bash` shell. Edit your `~/.bashrc` file and export a new `var` named `GITHUB_USER`. Give it the value of your own GitHub username.

    ```
    export GITHUB_USER="nmagee"
    ```

    After you add this line, run the command `source ~/.bashrc` to load this new value into your environment.
   
4.  Back to your Python script. In order to work with `env` variables and remote APIs you need three imports:

    ```python3
    import os
    import json
    import requests
    ```
    To retrieve the value of an environment variable in Python, use this syntax:

    ```
    GHUSER = os.getenv('GITHUB_USER')
    ```

    You can test that this works by using Python interactively. Load your imports and execute that line, and you should be able to `print(GHUSER)` to get your username.

5. Next, we will use this variable to fetch the recent activity for this user account (you!) in GitHub. First let's configure the remote endpoint to get that information. The format for that API address is:

    ```
    https://api.github.com/users/USERNAME/events
    ```

    To dynamically insert your GITHUB_USER name into this URL, define a `url` variable like this:

    ```
    url = 'https://api.github.com/users/{0}/events'.format(GHUSER)
    ```

    You will know if this is formatted correctly if you `print(url)` within Python and see a well-formed address.

6. Use this address to fetch your recent GitHub activity with the `requests` library. We will load the response back from the API into a variable, and loop through the first five responses:

    ```
    r = json.loads(requests.get(url).text)

    for x in r[:5]:
      event = x['type'] + ' :: ' + x['repo']['name']
      print(event)
    ```

    Take a moment to `print(r)` and view all the results. You can also do this by opening the fully-formatted URL above in a web browser. Note the variety of data available around your work in GitHub. 

    Much more information on the [**GitHub API is available**](https://docs.github.com/en/rest?apiVersion=2022-11-28). 

7. Use `chmod` to make your script executable, and run it. Make sure no errors occur.
   

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

## Submit your work

You created three separate scripts for this lab. Add/commit/push them to your fork of the DS2022 repository, in a folder `my-work/lab3`. Submit the GitHub URL to that directory within Canvas.


This lab has you create two scripts. They should be put into a folder `ds2002-course/mywork/lab3` within your fork of the course repository, added, committed, and pushed. Then send the two (2) URLs - one for each file - in the text box within Canvas.
