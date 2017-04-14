/bin/date >> /home/multiverse/logs/rsync.log
/usr/bin/rsync -e ssh -auv --exclude-from=/home/multiverse/bin/rsync_exclusions.txt multiverse@multiverse.org:~/ /home/multiverse/website/ >> /home/multiverse/logs/rsync.log 2>&1
/bin/date >> /home/multiverse/logs/rsync.log
