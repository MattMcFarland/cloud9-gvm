# Kickstart your very own cloud9 IDE
In the cloud!

Using Google Cloud Compute Engine, you can easily jumpstart a linux-based virtual machine.  To make things interesting, I decided to make one that hosts my own private IDE with a simple script.

This is running on backports-debian-7-wheezy-v20141108 - the default VM as of the time this was written.
c9 ide is going to need quite a few things to run, so let's make sure we get them.

## Rapid Install

If you don't feel like doing all of this yourself, you can run the following commandbelow: (as sudo) 

`curl -L https://raw.githubusercontent.com/MattMcFarland/cloud9-gvm/master/kickstart.sh | sudo sh`

## Guide

The rest of this guide assumes **sudo**

Install compiling tools (and other essentials):
```
apt-get install build-essential git wget curl -y
```

Grab [NodeJS](https://github.com/joyent/node/wiki/installing-node.js-via-package-manager)
```
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs
```

Cloud9 requires tmux version 1.9 - and at this time it is not available via package managers.  The optimal way is to run script(special thanks to shime):

```
curl -fsSL https://gist.github.com/shime/5706655/raw/install.sh | sudo bash -e
```

**Optional** - Should you want the latest version of ruby, the following commands will do it (note, this will take a while)

```
curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.gz > ruby-2.1.4.tar.gz && tar -xzvf ruby-2.1.4.tar.gz && cd ruby-2.1.4
./configure && make && make install
```

Now it's time to finalize this by installing [cloud9](https://github.com/ajaxorg/cloud9/) itself:

```
apt-get install libxml2-dev
git clone https://github.com/ajaxorg/cloud9.git /usr/bin/cloud9
cd cloud9
npm install
```

To configure your new IDE server, continue reading [here](https://github.com/ajaxorg/cloud9/).


Now let's make cloud9 a service that starts when you boot up:

create a file called c9ide and put it in /etc/init.d:

```
#! /bin/sh

### BEGIN INIT INFO
# Provides:          c9ide
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Cloud 9 IDE
# Description:       Manage Cloud 9 IDE
### END INIT INFO

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting c9ide "
    
    sh /usr/bin/cloud9/bin/cloud9.sh

    ;;
  stop)
    echo "Stopping c9ide"
    
    echo "Unable to stop cloud9"
    
    ;;
  *)
    echo "Usage: /etc/init.d/foobar {start|stop}"
    exit 1
    ;;
esac

exit 0
```

Now I'm not sure how to stop the cloud9 ide, I think there is a way to do it by finding the process. If anyone knows how please let me know.

The next thing to do is make sure the service is executable so it can run:

```
chmod 700 /etc/init.d/c9ide
```

Then start it up like so:
```
service c9ide start
```

You should see this:
```
IDE server initialized. Listening on localhost:3131
```








