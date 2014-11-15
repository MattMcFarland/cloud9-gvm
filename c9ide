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
