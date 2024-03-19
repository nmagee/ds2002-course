# Lab 5: Bootstrapping an EC2 Instance

Bootstrapping is the process of bringing a resource onlne pre-loaded with OS updates, packages, and any software required to run without human intervention or further configuration. You can bootstrap a "barebones" instance of a particular OS distribution, or further bootstrap an already-customized AMI. Bootstrapping only occurs upon instance creation.

This lab introduces the basics of updating your EC2 instance upon creation.

**BEFORE** you start this lab, be sure to watch the How To: Create an EC2 Instance video if you are not familiar with the basics of creating an instance in EC2.

<a href="https://www.youtube.com/embed/n8XRNstKY6M?si=6-Sel4HujDR0QhX5" target="_new"><img src="https://s3.amazonaws.com/ds2002-resources/images/ec2-yutube.png"></a> 

1. Establish what you need to bootstrap upon instance creation. In this example you will be working with an Ubuntu Linux distribution. This means you will be using the `apt` package manager as a start, and loading other resources as necessary.

- Use `apt` to update the OS.
- Use `apt` to install specific packages.
- Use `apt` to install tools that install other supporting libraries or resources.

1. For OS updates to the instance, a bootstrapping script might look something like this:

```
#!/bin/bash

apt update -y
apt upgrade -y
```

![User Data](https://nmagee.github.io/ds2002/images/ec2-user-data.png)

A few notes:

- First, notice the #!/bin/bash shebang at the start. The instance needs some interpreter or shell to parse the following commands, so this is required. This script updates the `apt` directory of packages, and then upgrades any packages that have updates available.
- This bash script will be executed with full sudo privileges, so you do not need a sudo or sudo su command within the script to escalate permissions.
- Take note that the -y flag has been included, since bootstrapping scripts are non-interactive. That is, you will not be present to answer "Y" or "N" when asked if you want to install new packages.
- To "inject" your bootstrap script into an instance upon launch, find the User data field in the "Configure Instance" pane of the launch wizard, at the very bottom of the page under "Additional Details."

1. To install specific packages, a bootstrapping script might look something like this:

```
#!/bin/bash

/usr/bin/apt update -y
/usr/bin/apt upgrade -y
/usr/bin/apt install -y git 
/usr/bin/python3 -m pip install pandas
```

A few notes:

- The first command updates the `apt` cache, since it comes empty in a fresh installation.
- The second command upgrades all packages that can be upgraded.
- Not all binaries are automatically in the $PATH of a bootstrap script. Therefore it is often useful to define the full path for every command. (This is the same for cron jobs.)
- From there, `apt` is used to install specific packages non-interactively.
- Remember that some commands, such as `pip` are not available by default and must be installed themselves.

4. Another strategy for bootstrapping is to publish a `bash` or `cloud-init` script to a remote location, such as S3 or GitHub. This allows for centralized management of the script and a relatively "dumb" bootstrapping script to retrieve the remote file and execute it. In the example below, a pre-published GitHub gist is available in raw form.

```
#!/bin/bash
      
/bin/curl -O https://gist.githubusercontent.com/nmagee/acb6249ba451c03fd921f0d6d0f442d5/raw/5816fb54963826f953da166bd623a9ba0cd9fa76/bootstrap.sh
/bin/bash bootstrap.sh
```

A few notes:

- `curl` is already available on the instance and does not need to be installed.
- Using the `-O` flag for `curl` means the script is downloaded as named.
- At this point the script could be `chmod` to 755 and then executed `./bootstrap.sh` or executed against `bash`.
- A security consideration is that a GitHub gist must either be public or hidden, though hidden does not mean secure. A more secure option would be to fetch the script from a private Amazon S3 bucket, and grant the EC2 instance role explicit READ privileges for the bucket.

5. **Debugging**: If you are familiar with Docker (or after the Microservices portion of this course) you can use basic OS distribution containers (Ubuntu, Amazon Linux, CentOS, Debian, etc.) as a way to test bootstrapping scripts, determine software availability and path, and debug your bootstrapping process.

6. To bootstrap programmatically, you can echo in user data, or pass it as a file:

```
aws ec2 run-instances --image-id ami-abcd1234 --count 1 --instance-type m3.medium \
  --key-name my-key-pair --subnet-id subnet-abcd1234 --security-group-ids sg-abcd1234 \
  --user-data file://my_script.txt
```

7. Your assignment in this lab is to bootstrap an EC2 instance yourself. Select 3 of the following packages or tools to install. To evaluate succcess, simply shell into the instance after the instance has been created (give the instance enough time to complete your setup) and verify. For more advanced bootstrapping of a service or daemon, open up the relevant port in your security group and test remotely. For instance, the nginx web server is a fairly simple daemon to bootstrap, and you can then use http://your-instance-ip-address/ to verify (if you open port 80 to the Internet).

Refer to Running commands on your Linux instance at Launch for more detail.

- `python3`
- `boto3`
- `git`
- `nginx`
- `apache2`
- `redis`
- `awscli`
- `jq`
- `mysql-server` (advanced)
- `docker.io` (advanced)

8. After you have shelled into your instance to verify all expected packages got installed, you should terminate your instance to clean up resources and stop incurring all costs. To stop your instance, select it from the list of instances, and from the ACTIONS menu select the INSTANCE STATE submenu, and then click on TERMINATE INSTANCE.

![EC2](https://nmagee.github.io/ds2002/images/terminate-instance.png)

1.  Final notes:

- At some point boostrapping becomes too large, too long, and too unwieldy. When you get to that point, consider creating your own AMI based upon a customized instance that has the tools and software you need.
- Bootstrapping should be seen as prepping a "bare" instance for production.
- In environments where instances are being destroyed frequently, bootstrapping can take care of basic OS/package updates, and a change management tool (such as Ansible) can be used for updates, if needed.
- Some organizatins never update instances after creation. Therefore, bootstrapping is the last point for refreshing and upgrading.
- It is possible, though not common, for a bootstrapping action to hang. If this occurs, shell into the instance and try to debug. Or terminate the instance and try again.

## WHAT TO SUBMIT

Save your bootstrapping script as a file in your GitHub account. Submit the URL to the file in Canvas for review.