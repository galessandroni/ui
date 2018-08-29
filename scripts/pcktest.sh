#!/bin/bash
#
# Update test installation from live backup
# Pass some string as an argument to run the sanitisation script
#
# Run as ubuntu user


CURRENTDIR=`dirname $0`
source $CURRENTDIR/config.sh || exit

# sync images
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'custom' $PCKDIR/uploads/ $TESTDIR/uploads/
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'css' --exclude 'robots.txt' $PCKDIR/pub/ $TESTDIR/pub/

# block search engines
sudo cp /data/phpeace/disallow.txt $TESTDIR/pub/robots.txt
sudo cp $PCKUIDIR/test/custom/peacetest.gif $TESTDIR/uploads/graphics/orig/1.gif

# set perms
sudo chown -R www-data.www-data $TESTDIR

# sanitise db
if [ ! -z "$1" ]; then
    pcksan.sh
fi

# update script
sudo -u www-data mkdir -p $TESTDIR/scripts/custom
sudo -u www-data cp $CURRENTDIR/pcktest.php $TESTDIR/scripts/custom
cd $TESTDIR
php $TESTDIR/scripts/custom/pcktest.php

# slack
