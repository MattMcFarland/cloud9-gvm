#!bin/bash
#
# Debian / Wheezy essential setup
# Made for Google Cloud Compute Engine
# backports-debian-7-wheezy-v20141108
#
#
echo This script requires root access
# Install build tools (make/compilers/etc)
apt-get install build-essential git wget curl -y

# Add src repo to latest stable nodejs
# https://github.com/joyent/node/wiki/installing-node.js-via-package-manager
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs


# Install tmux
curl -fsSL https://gist.github.com/shime/5706655/raw/install.sh | sudo bash -e

# Install Cloud9-IDE:
apt-get install libxml2-dev
git clone https://github.com/ajaxorg/cloud9.git /usr/bin/cloud9
cd /usr/bin/cloud9
npm install

cd ~

# Install Ruby
curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.gz > ruby-2.1.4.tar.gz && tar -xzvf ruby-2.1.4.tar.gz && cd ruby-2.1.4
./configure && make && make install

# Setup Cloud 9 Service:
curl -o /etc/init.d/c9ide https://raw.githubusercontent.com/MattMcFarland/cloud9-gvm/master/c9ide
chmod 755 /etc/init.d/c9ide
sudo update-rc.d c9ide defaults

echo "We are not done yet"
echo "run the following to set up your user:"
echo "/usr/bin/cloud9/bin/cloud9.sh --username leuser --password c9isawesome"
echo "use service c9ide start to fire it up"

