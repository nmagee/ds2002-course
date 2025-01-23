# Lab 2: GitHub

Follow all the steps below for practice using GitHub. You an use your web browser to complete these steps, or the terminal if you like.

Create a single GitHub Gist to submit the URLs you create in these steps, and submit it for grading.

## 1. Git/GitHub Basics

Go to https://uvads.github.io/git-basics/ and work through pages 0, 1, and 2. When setting up `git` CLI authentication, I strongly suggest SSH key authentication. However, if you already have this set up, you do not need to change.

To test your understanding, be sure you understand how to do the following well:

- Install the `git` command-line and authenticate to GitHub using SSH key authentication
- Create a new repository in GitHub and clone it to your local machine.
- Use `git add`, `git commit`, and `git push/pull` your changes to your GitHub repository.
- Check the status of your local repository using `git status`.
- Display the commit log for a repository using `git log`.
- See changes made to a file using `git diff`.

Put the URL of the repository you created into the Gist.

## 2. Practice With GitHub Skills

1. Go to **GitHub Skills** https://skills.github.com/
2. Find the first lesson, "Introduction to GitHub" and right-click on the link to open it in a new browser tab.
3. Read the page closely, paying attention to what you will do in this lesson.
4. Right-click on the "Start course" button (as instructed) to open it in a new brower tab.
5. Follow the instructions closely to copy their lesson into your own account.
6. Once that is complete, wait about 20 seconds and refresh the page in your copy of the lesson.
7. Follow the instructions to complete the lesson.

Add the URL to the new repository you created in this step to the GitHub Gist.

**EXTRA** GitHub Skills has many other lessons you can complete. Give some more a try!

## 3. Set up your GitHub Profile README Page

You can use GitHub to showcase your own work, interests, and projects. [Follow these instructions](https://docs.github.com/en/get-started/start-your-journey/setting-up-your-profile#adding-a-profile-readme) to set up yours. [Here](https://github.com/schacon/) is a good example from Scott Chacon. Remember that your code and projects are some of the most important evidence of your work, so highlighting that is a part of obtaining internships and interviews. Even if you don't feel you have much to showcase now, this will give you one place to display your technical work.

Add the URL to your GitHub Profile page to the GitHub Gist.

## 4. Fork a Repository and Submit a Pull Request

1. Go to https://github.com/uvasds-systems/ds2002-directory/ and fork the repository by clicking on the FORK button in the upper-right of the page. Create the fork in your own GitHub account.
2. Clone your fork to your local computer, or open it in a GitHub Codespace.
3. Within the `people` directory create a subdirectory named with your computing ID, i.e. `nem2p` or `mst3k`, etc.
4. Inside of that subdirectory, create a `README.md` file.
5. Paste the code below into that file, and fill out the appropriate fields. If you'd like to include an image of yourself (jpg, png, gif, etc.) add it to your subdirectory as well. Introduce yourselves! If you need an example for reference, see [this page](../people/nem2p/README.md). Here is a Markdown [reference](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) for formatting your page.

    Be sure the first line uses the `#` character followed by your name.

    ```
    # Your Name
    
    ![Path to an image](myphoto.jpg)

    - Hometown: 
    - Hobbies: 
    - First Computer I Ever Touched: 
    - My GitHub Profile: <Insert the full URL to the README page you set up in Step 3>
    ```
    
7. `git add` your file(s), then commit them, and push them back to **your fork** in GitHub.
8. From your forked repo in the GitHub website, submit a Pull Request for your changes to be incorporated back upstream into the original repository. You can submit a PR by clicking on the "Contribute" drop-down and selecting "Open Pull Request". That will open up a form which you will submit to trigger the PR. Give your PR an informative title then submit.
9. Wait for a notification email that your Pull Request has been accepted. Merged Pull Requests will display your name and a link to your profile on the home page of the main repository.

## BONUS: Create a GitHub Pages website

Follow [these instructions](https://pages.github.com/) and create a "user" site. A few examples:

- https://schacon.github.io/
- https://nmagee.github.io/
- https://mk.gg/
