#Frequent checks
#0 * * * * 	/home/user/bin/file_move.sh

/usr/bin/rsync -a /incoming /home/[USER]/temp/ >> /home/[USER]/logs/rsync.log 2>&1
tar zxvf /home/[USER]/temp/DATA_*.csv.gz /data | rm /home/[USER]/temp/DATA_*.csv.gz
