#Script for updating individual ISO image at cdimage.ubuntu.com (daily/current versions).
#Orginal script written by Henrik Omma, slightly adjusted by Bert Verhaeghe, then a bit by Victor Van Hee
#Jeremy Yoder made it try to automatically pick an ISOPATH, adapted to karmic by Christian Bangerter

# Change this next line to the directory where your previously downloaded iso image sits.
DIR="/data/Software/karmic"

# Choose only one of the iso files below and uncomment it
# ISO="karmic-desktop-amd64.iso"
ISO="karmic-desktop-i386.iso"
# ISO="karmic-alternate-amd64.iso"
# ISO="karmic-alternate-i386.iso"

# Uncomment the line below if you want a different image not listed below
# ISOPATH="cdimage.ubuntu.com/cdimage/LOCATION/current"

# Default ISO to the first command-line parameter
if [ "$1" != "" ]; then
  ISO=$1
fi

if [ "$ISOPATH" = "" ]; then
  if [[ "$ISO" =~ "-desktop-" ]]; then
    ISOPATH="cdimage.ubuntu.com/cdimage/daily-live/current"
  elif [[ "$ISO" =~ "-alternate-" ]]; then
    ISOPATH="cdimage.ubuntu.com/cdimage/daily/current"
  elif [[ "$ISO" =~ "-dvd-" ]]; then
    ISOPATH="cdimage.ubuntu.com/cdimage/dvd/current"
  elif [[ "$ISO" =~ "-netbook-remix-" ]]; then
    ISOPATH="cdimage.ubuntu.com/cdimage/ubuntu-netbook-remix/daily-live/current"
  elif [[ "$ISO" =~ "-server-" ]]; then
    ISOPATH="cdimage.ubuntu.com/cdimage/ubuntu-server/daily/current"
  else
    echo "Unrecognized distribution, set ISOPATH manually"
    exit 1
  fi
fi

if [ ! -d $DIR ]; then
  echo "Sorry, $DIR does not exist"
  exit
fi

cd $DIR

md5sum $ISO | sed -e "s/  / */" > $ISO.md5.local 
# ^ create identical formatted md5sum file from local copy
echo ""
echo "########################################"
echo "# diff'ing MD5SUMs : local <-> server  #"
echo "########################################"

wget -q http://$ISOPATH/MD5SUMS 
grep $ISO MD5SUMS > $ISO.md5.server
rm MD5SUMS
diff -q $ISO.md5.local $ISO.md5.server

if [ ! $? -eq "0" ]; then
        echo ""
        echo "!!! MD5SUMs differ !!!"
        echo "...Performing rsync..."
        echo "###################"
        echo "# rsync iso image #"
        echo "###################"
        rsync -avzhhP rsync://$ISOPATH/$ISO .
else
        echo ""
        echo "MD5SUMs identical -- no need to Rsync"
        echo ""
        exit 0
fi
echo ""
echo "########################################"
echo "# diff'ing MD5SUMs : local <-> server  #"
echo "########################################"

md5sum $ISO | sed -e "s/  / */" > $ISO.md5.local
diff -q $ISO.md5.local $ISO.md5.server

if [ ! $? -eq "0" ]; then
        echo ""
        echo "!!! MD5SUMs differ !!!"
        echo "!!! Rsync failed!  !!!"
else
        echo ""
        echo "MD5SUMs identical"
        echo "SUCCESS!"
fi
echo ""
