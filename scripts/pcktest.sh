#!/bin/bash
#
# Update test installation from live backup
# Pass some string as an argument to update and sanitise data
#
# Run as ubuntu user


CURRENTDIR=`dirname $0`
source $CURRENTDIR/config.sh || exit

# sync images
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'custom' --exclude graphics $PCKDIR/uploads/ $TESTDIR/uploads/
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'css' --exclude 'robots.txt' $PCKDIR/pub/ $TESTDIR/pub/

# block search engines
sudo cp /data/phpeace/disallow.txt $TESTDIR/pub/robots.txt
# update logo
sudo cp $PCKUIDIR/test/custom/peacetest.gif $TESTDIR/uploads/graphics/orig/1.gif

# set perms
sudo chown -R www-data.www-data $TESTDIR

# sync db
if [ ! -z "$1" ]; then
    pcksan.sh
    # update data
    sudo -u www-data mkdir -p $TESTDIR/scripts/custom
    sudo -u www-data cp $CURRENTDIR/pcktest.php $TESTDIR/scripts/custom
    sudo -u www-data cp $CURRENTDIR/pcktest_publish.php $TESTDIR/scripts/custom
    cd $TESTDIR
    sudo -u www-data php $TESTDIR/scripts/custom/pcktest.php
fi

# publish
sudo -u www-data php $TESTDIR/scripts/custom/pcktest_publish.php

# slack
