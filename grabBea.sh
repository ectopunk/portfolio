#! /bin/sh -f

#License:  https://www.gnu.org/licenses/gpl-2.0.txt

#To successfully run this script, you need to know the following before you use it
#Example:
#SOFTWAREVERSION: server815_linux32.bin
#SOFTWARELOCATION: ftp://callisto//WebLogic/8.1%20SP5/Linux/

#Create hostname root variable
HOSTROOT=projectA

#Create featureX build home
featureXHOME=/export/home/featureX

#Create software version variable from command line
echo -n "Enter the software version and press [ENTER]: "
read SOFTWAREVERSION

#Create software location variable from command line
echo -n "Enter the location of the software and press [ENTER]: "
read SOFTWARELOCATION

SOFTWAREDOWNLOAD=$SOFTWARELOCATION/$SOFTWAREVERSION

#Grab target software from ftp server
wget $SOFTWAREDOWNLOAD

#Send software to other servers in the group
scp $SOFTWAREVERSION featureX@$HOSTROOT-a2:$featureXHOME
scp $SOFTWAREVERSION featureX@$HOSTROOT-p1:$featureXHOME
scp $SOFTWAREVERSION featureX@$HOSTROOT-p2:$featureXHOME

#Make server bin executable
chmod 775 $featureXHOME/server815_linux32.bin
ssh featureX@$HOSTROOT-a2 "chmod 775 $featureXHOME/server815_linux32.bin"
ssh featureX@$HOSTROOT-p1 "chmod 775 $featureXHOME/server815_linux32.bin"
ssh featureX@$HOSTROOT-p2 "chmod 775 $featureXHOME/server815_linux32.bin"

#Create filesystem
mkdir $featureXHOME/bea_815
ssh featureX@$HOSTROOT-a2 "mkdir $featureXHOME/bea_815"
ssh featureX@$HOSTROOT-p1 "mkdir $featureXHOME/bea_815"
ssh featureX@$HOSTROOT-p2 "mkdir $featureXHOME/bea_815"

#create BEA install configuraiton
touch  $featureXHOME/silent.xml
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >> $featureXHOME/silent.xml
echo "<domain-template-descriptor>" >> $featureXHOME/silent.xml
echo "<input-fields>" >> $featureXHOME/silent.xml
echo "   <data-value name=\"BEAHOME\" value=\"$featureXHOME/bea_815\" />" >> $featureXHOME/silent.xml
echo "   <data-value name=\"USER_INSTALL_DIR\" value=\"$featureXHOME/bea_815/weblogic81\" />" >> $featureXHOME/silent.xml
echo "   <data-value name=\"INSTALL_NODE_MANAGER_SERVICE\" value=\"no\" />" >> $featureXHOME/silent.xml
echo "   <data-value name=\"COMPONENT_PATHS\" value=\"WebLogic Server|WebLogic Workshop|WebLogic Integration|WebLogic Portal\" />" >> $featureXHOME/silent.xml
echo "</input-fields>" >> $featureXHOME/silent.xml
echo "</domain-template-descriptor>" >> $featureXHOME/silent.xml

#Distribute silent.xml to other servers in the group
scp $featureXHOME/silent.xml $HOSTROOT-a2:~
scp $featureXHOME/silent.xml $HOSTROOT-p1:~
scp $featureXHOME/silent.xml $HOSTROOT-p2:~

#Install BEA
$featureXHOME/$SOFTWAREVERSION -mode=silent -silent_xml=$featureXHOME/silent.xml
ssh featureX@$HOSTROOT-a2 "$featureXHOME/$SOFTWAREVERSION -mode=silent -silent_xml=$featureXHOME/silent.xml"
ssh featureX@$HOSTROOT-p1 "$featureXHOME/$SOFTWAREVERSION -mode=silent -silent_xml=$featureXHOME/silent.xml"
ssh featureX@$HOSTROOT-p2 "$featureXHOME/$SOFTWAREVERSION -mode=silent -silent_xml=$featureXHOME/silent.xml"

#Import license

cp $featureXHOME/bea_license_repository/*lic*.bea $featureXHOME/bea_815/
ssh featureX@$HOSTROOT-a2 "cp $featureXHOME/bea_license_repository/*lic*.bea $featureXHOME/bea_815/"
ssh featureX@$HOSTROOT-p1 "cp $featureXHOME/bea_license_repository/*lic*.bea $featureXHOME/bea_815/"
ssh featureX@$HOSTROOT-p2 "cp $featureXHOME/bea_license_repository/*lic*.bea $featureXHOME/bea_815/“