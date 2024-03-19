# Lab 6 - Docker Builds in GitHub

Container images can be built by hand or by using automated tools. In this lab you will build on your fork of the FastAPI repository to enable automated container builds and learn how the process works.

> **NOTE**: To complete this lab you must first have forked this repository: https://github.com/nmagee/fastapi-demo. All work you complete in this lab will be using code from your fork of the repository, and pushing your changes there.

## Building Docker Images with a `Dockerfile`

Docker allows you to run a container interactively, add software, edit/configure files and settings, and import code (among many other things). However, this approach takes time and is not always consistent.

The better method for creating container images is to automate it using a `Dockerfile` and a build process.

1. **Review your Dockerfile**
   
    Open the `Dockerfile` in the root of your repository, and read through its contents. It contains only four lines:

    - The first line indicates that your container will be built upon a pre-existing container that someone else created. This means that a developer has pre-loaded all the basic essentials for your FastAPI container -- you simply need to add in your own code and requirements.
    - The second line copies all of your `app/` directory into the container, i.e. the actual Python guts of your application.
    - The third line copies the `requirements.txt` file into the container.
    - The fourth line runs `pip install` to be sure all of your Python dependencies are installed.

## Automating Builds using GitHub Actions

2. **Edit your workflow**
   
    Open the `.github/workflows/build.yml` file and read its contents. There's a lot more to point out here, but these are the essential blocks of logic:

    - The `on:` section indicates when the workflow should be triggered. This code indicates the action should be triggered after a `push` to the `main` branch.
    - The `env:` section establishes some values we will re-use later in the workflow, such as the container registry (the host we will use to store the container image), the container image name and tag.
    - The `jobs:` section has ONE job (called `build`) but that contains SIX steps:

        - The first three steps check out a copy of our repository and perform some other setup tasks.
        - The fourth step logs into the GitHub Container Registry (GHCR) since that is where we are going to store and share our container image.
        - The fifth step is the heart of the logic, which builds the container image itself. Notice that it will be built for two different platforms (computer chips), `amd64` and `arm64`. The ensures the container can run on any modern computer.
        - The final step returns any build output we should know about.

3. **Edit the** `.github/workflows/build.yaml` **file**

    Just below the `on:` line, add `workflow_dispatch:` (with the colon) and indent it to match the `push` line. It should look like this when complete (including indentations)

    ```
    on:
      workflow_dispatch:
      push:
        branches: [ main ]
    ```

    Add this change to your repository, commit it, but do not yet push back to GitHub.

4. **Create a GitHub Personal Access Token (PAT)**

    In order to sign into the GHCR on your behalf, your GitHub Action needs a token with the right permissions. Here are the steps to create and store that:

    A. Using your browser click on your profile icon in the upper-right corner of the page. Go to SETTINGS -> DEVELOPER SETTINGS (bottom left navigation) --> PERSONAL ACCESS TOKENS --> TOKENS (CLASSIC)

    B. From the "Generate New Token" drop-down, select "Generate New Token (Classic)" Add a descriptive note such as "Container builds". Set the expiration for 90 days.

    C. Check the following boxes to grant permissions:

      - `workflow`
      - `write:packages`
      - `delete:packages`
      - `notifications`

    D. Then click "Generate Token" at the bottom of the page. On the next page you will be shown your token. COPY THE TOKEN and store it someplace safe. You will not be able to see it again. DO NOT commit this token to your code.

    E. You will get an email confirming that a new PAT has been created in your account.

5. **Create a Repository Secret using your PAT**

    Return to your forked repository in the GitHub website.

    A. Click on the SETTINGS tab.

    B. Go to the SECRETE AND VARIABLES section. Select ACTIONS.

    C. Create a NEW REPOSITORY SECRET. Give it the name `GHCR_PAT`. For the secret value, paste in the PAT token you created above.

    D. Your GitHub Action is now ready to use this secret.

6. **Enable workflows for your repository**

    Finally, click on the ACTIONS tab of your repository. This is where you can see past runs of your workflow as well as current/pending runs.

    Workflows have been disabled by default on your fork of the repository. Click the button to enable workflows.

## Test your build

You have now created a Personal Access Token and saved it as a Secret into your repository. You have also edited your workflow definition and committed those changes to your fork of the repository.

Now push your changes back to GitHub.

Go to the ACTIONS tab and click to see if you have an entry under the "All Workflows" view. You can click into the name of each workflow run to watch detailed steps as they occur.

Watch your action for the next 1-2 minutes. It should move through stages from "queued" to "in progress" to "complete".

If you experience an error, click into the build to see if you can determine what went wrong. Expand all the arrows to see the log output. Be sure you spelled `GHCR_PAT` correctlyl for your secret name, and be sure your workflow template is formatted correctly. Debug and try another build following one of the steps in the section below.

If your workflow succeeded, proceed to the next step.

## Trigger your builds

You can now trigger your build in two ways:

1. **Manually** - From within the ACTIONS tab for your repository, click on the `container-build` workflow on the left. You should see a blue bar with "Run Workflow" as an optional drop-down. Trigger builds manually from there.

2. **Automatically** - Anytime you add/modify code, then commit and push it back to GitHub, your workflow will be triggered.

## Final Setup

Your GitHub Action is now building container images automatically. Let's connect those images with the repository:

1. Click into your GitHub account profile by clicking your username in the upper-left before your repository name. The URL should be something like `https://github.com/USERNAME`

2. Click into the PACKAGES tab and find your `fastapi-demo` container image. (Container images are one type of package, meaning that it's one way to distribute software.) Click into your package. 

3. Scroll down and click on CONNECT REPOSITORY. Select your `fastapi-demo` repository and connect it to your package.

4. Finally, click into the PACKAGE SETTINGS on the right-hand side. Scroll down and click "CHANGE VISIBILITY" - since we want this container image to be public. Select "Public" and type your container image name to confirm. Then select "I understand ..."

## Make Changes, Push, and Test

Now edit the `app/main.py` file. Add an additional endpoint to return data of some kind. Add, commit, and change your changes.

Verify that your changes trigger a build, and wait for the build to complete.

Go to the home page of your forked repository in GitHub. Find the PACKAGES section lower on the right side. Click into it.

Under the INSTALLATION section you will see a line something like

```
docker pull ghcr.io/USERNAME/fastapi-demo:1.X
```

Within GitPod or your own local environment, copy and run this line from your command-line terminal. (This requires Docker be installed.)

Now run the container in detached mode, mapping the host port 8000 to the container port 80. Be sure to update the `USERNAME` to match your GitHub username, and match the `X` to the right version number of your container image:

```
docker run -d -p 8000:80 ghcr.io/USERNAME/fastapi-demo:1.X
```

If you are using GitPod, a new browser tab should open automatically.

If you are developing locally, open a browser tab to http://127.0.0.1:8000/

## Submit your work

Submit two screenshots for this lab:

1. Show the GitHub Actions tab for your repository showing at least THREE successful builds.

2. Show a browser tab open to your running container either in Gitpod or locally. Be sure to include the address bar of the browser.