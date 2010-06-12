#!/bin/sh
#
# Example init.d script with LSB support.
#
# Please read this init.d carefully and modify the sections to
# adjust it to the program you want to run.
#
# Copyright (c) 2007 Javier Fernandez-Sanguino <jfs@debian.org>
#
# This is free software; you may redistribute it and/or modify
# it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2,
# or (at your option) any later version.
#
# This is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License with
# the Debian operating system, in /usr/share/common-licenses/GPL;  if
# not, write to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA 02111-1307 USA
#
### BEGIN INIT INFO
# Provides:          flint
# Required-Start:    $local_fs $remote_fs
# Required-Stop:	 $remote_fs
# Should-Start:      
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: <Enter a short description of the sortware>
# Description:       <Enter a long description of the software>
#                    <...>
#                    <...>
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

DAEMON=/usr/sbin/flint # Introduce the server's location here
NAME=flint             # Introduce the short server's name here
DESC="Django FastCGI instance starter"

test -x $DAEMON || exit 0

. /lib/lsb/init-functions

set -e

start_server() {
	$DAEMON start_all
	errcode=$?
	return $errcode
}

stop_server() {
	$DAEMON stop_all
	errcode=$?
	return $errcode
}

case "$1" in
  start)
        log_daemon_msg "Starting $DESC" "$NAME"
        if start_server ; then
                log_end_msg 0
        else
            log_end_msg 1
        fi
        ;;
  stop|force-stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
		errcode=0
		stop_server || errcode=$?
		log_end_msg $errcode
  restart|force-reload)
        log_daemon_msg "Restarting $DESC" "$NAME"
		$DAEMON restart_all
        log_end_msg 0
        ;;
  status)
        log_daemon_msg "Checking status of $DESC" "$NAME"
		log_progress_msg "unsupported"
		log_end_msg 0
  		exit 0
        ;;
  # Use this if the daemon cannot reload
  reload)
        log_warning_msg "Reloading $NAME daemon: not implemented, as the daemon"
        log_warning_msg "cannot re-read the config file (use restart)."
        ;;
  *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|force-stop|restart|force-reload|status}" >&2
        exit 1
        ;;
esac

exit 0
