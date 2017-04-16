#!/bin/bash

# Changed the date to YYYY instead of YYY which made no sense, so YY could have worked too, but decided for the YYYY.
# 
# Original format
#DATA_YYYMMDD_hhmm.csv.gz
# DATA_0170416_1246.csv.gz
#
# Modified format
#DATA_YYYYMMDD_hhmm.csv.gz
# DATA_20170416_1246.csv.gz

# make a variable of the directory where incoming files are located in case it changes, and for outgoing data
INCOMING=/incoming
DATA=/data
LOGFILES=/tmp/incoming.log
MAILTO="user@wehaveanerror.com"
MAILX="/bin/mailx"

# Get the date format for the file when this cron job or script is run.

DATE=$(date +%Y%m%d_%l%M)

# This assumes all files don't have spaces in them.  As a precaution for the last file being written, we make sure
# that we do not grab the last named file, even if it is zipped up, just in case the file is not done zipping up but there
# is a .gz file being created that minute.
# The reason we do a list of files in /incoming is so that if this script hasn't been run for some 
# unknown reason, we get all files that have been written and are .csv.gz with the DATA prefix, 
# then run those in a  loop to uncompress and move them.
# Although we don't need to do the 1tr for time, doing this may allow a later time to just remove the last entry using a tail command.

for files in $(ls -1tr ${INCOMING}/DATA_*csv.gz | grep -v ${DATE} > /tmp/incoming.$$) ; do

   # Move the file to the new location then unzip it, if it does not exist in the $DATA directory, if it does we should spit
   # out an error.   This way we will not do an indescrimate delete an just 
   # gunzip which will remove the original file.

   if [ -f ${DATA}/${files} ] ; then
      gunzip -v ${DATA}/${file}
      # $$ is the PID of the current running process, for something sort of random, not perfect.
      mv ${INCOMING}/${files} ${DATA}/${files}_$$
      $MAILX -r noreply@${HOSTNAME} -s "ERROR: ${files} oddity, renamed to ${files}_$$" $MAILTO
      exit 1
   fi

   # Move file to data directory
   mv ${INCOMING}/${files} ${DATA}

   # gunzip data file which deletes the original
   gunzip -v ${DATA}/${file} > ${LOGFILE}

done

#### end script
