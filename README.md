# Kickstart your very own cloud9 IDE
In the cloud!

Using Google Cloud Compute Engine, you can easily jumpstart a linux-based virtual machine.  To make things interesting, I decided to make one that hosts my own private IDE with a simple script.

> This is running on backports-debian-7-wheezy-v20141108 - the default VM as of the time this was written.
c9 ide is going to need quite a few things to run, so let's make sure we get them.

## Rapid Install

If you don't feel like doing all of this yourself, you can run the following commandbelow: (as sudo) 

`curl -L https://raw.githubusercontent.com/MattMcFarland/cloud9-gvm/master/kickstart.sh | sudo sh`

## Guide

The rest of this guide assumes **sudo**

### Essentials

Install compiling tools (and other essentials):
```
sudo apt-get install build-essential git wget curl -y
```
### NodeJS

Grab [NodeJS](https://github.com/joyent/node/wiki/installing-node.js-via-package-manager) (and install as root)
```
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs
```

### tmux 1.9

Cloud9 requires tmux version 1.9 - and at this time it is not available via package managers.  The optimal way is to run this awesome script by shime (as root)
```
curl -fsSL https://gist.github.com/shime/5706655/raw/install.sh | sudo bash -e
```

### Ruby 2.1.4

**Optional** - Should you want the latest version of ruby, the following commands will do it (note, this will take a while)

```
curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.gz > ruby-2.1.4.tar.gz && tar -xzvf ruby-2.1.4.tar.gz && cd ruby-2.1.4
./configure && make && make install
```

### Cloud 9

Now it's time to finalize this by installing [cloud9](https://github.com/ajaxorg/cloud9/) itself(as root):

```
apt-get install libxml2-dev
git clone https://github.com/ajaxorg/cloud9.git /usr/bin/cloud9
cd /usr/bin/cloud9
npm install
```

To configure your new IDE server, continue reading [here](https://github.com/ajaxorg/cloud9/).

#### Setup User Authentication

For this project, I decided to use the simple command line below:
```
/usr/bin/cloud9/bin/cloud9.sh --username leuser --password c9isawesome
```
> You can find out more info about setting up auth for c9 at their github page here: https://github.com/ajaxorg/cloud9/


#### Setup cloud9 as a service

If you want cloud9 to start when your machine boots up, as well as operate it by using `service cloud9 start/stop` then run the following commands (as root)

```
curl -o /etc/init.d/cloud9 https://raw.githubusercontent.com/MattMcFarland/cloud9-gvm/master/cloud9
```

The next thing to do is make sure the service is executable so it can run:

```
chmod 755 /etc/init.d/cloud9
```

Now make sure it starts when you boot the machine up:

```
sudo update-rc.d cloud9 defaults  
```

Now you need to configure login settings, the default settings will be added by the kickstart.sh from the file (startc9.sh) in /etc/startc9.sh - if you didnt use kickstart, use the following command:

```
curl -o /etc/c9start.sh https://raw.githubusercontent.com/MattMcFarland/cloud9-gvm/master/c9start.sh
chmod +x /etc/c9start.sh
```

the `c9start.sh` file contains configuration settings for the server, including user authentication.  the default is as follows:

```bash
#!bin/bash
# /etc/c9start.sh
sh /usr/bin/cloud9/bin/cloud9.sh -l 0.0.0.0 -p 80 --username admin --password admin -w /home/c9
```

The first set of arguments -l 0.0.0.0 and -p 80 instruct cloud9 to run publicly on port 80 and accept any incoming ip address. 
Be sure to **change** the username, password and the workspace folder (in option -w)


Then start it up like so:
```
sudo service cloud9 start
```

You should now be able to login directly with browser (localhost:80, or wherever you isntalled it!)





