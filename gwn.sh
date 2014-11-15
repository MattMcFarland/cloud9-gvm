#!bin/bash
#
# Debian / Wheezy essential setup
# Made for Google Cloud Compute Engine
# backports-debian-7-wheezy-v20141108
#
#

sudo su

# Add src repo to latest stable nodejs
# https://github.com/joyent/node/wiki/installing-node.js-via-package-manager

curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs

# Install build tools (make/compilers/etc)
apt-get install build-essential git wget curl -y

# Install tmux
curl -fsSL https://gist.github.com/shime/5706655/raw/install.sh | sudo bash -e

# Install Ruby
curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.gz > ruby-2.1.4.tar.gz && tar -xzvf ruby-2.1.4.tar.gz && cd ruby-2.1.4
./configure && make && make install

exit
