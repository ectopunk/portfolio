/bin/date >> /home/multiverse/logs/rsync.log
/usr/bin/rsync -e ssh -auv --exclude-from=/home/multiverse/bin/rsync_exclusions.txt multiverse@multiverse.org:~/ /home/multiverse/website/ >> /home/multiverse/logs/rsync.log 2>&1
/bin/date >> /home/multiverse/logs/rsync.log




[stutter]$ cat backupMysql.sh
mysqldump -u multiverse_guy --password=Mu7$^eRs3 -h mysql.multiverse.org multiverse_six > /home/multiverse/sql/multiverse.org.sql
cd /home/multiverse/sql
tar zcf multiverse.org.sql.tar.gz multiverse.org.sql
mysqldump -u multiverse_guy --password=Mu7$^eRs3 -h mysql.multiverse.org themap3 > /home/multiverse/sql/themap.multiverse.org.sql
tar zcf themap.multiverse.org.sql.tar.gz themap.multiverse.org.sql



0 1 * * * 	/home/multiverse/bin/backupMysql.sh	/home/multiverse/sql
