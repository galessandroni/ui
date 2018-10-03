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

# sync db
if [ ! -z "$1" ]; then
    pcksan.sh
    # update data
    sudo mkdir -p $TESTDIR/scripts/custom
    sudo cp $CURRENTDIR/pcktest.php $TESTDIR/scripts/custom
    cd $TESTDIR
    sudo php $TESTDIR/scripts/custom/pcktest.php
fi

# publish
cd $TESTDIR
sudo cp $CURRENTDIR/pcktest_publish.php $TESTDIR/scripts/custom
sudo php $TESTDIR/scripts/custom/pcktest_publish.php

# set perms
sudo chown -R www-data.www-data $TESTDIR

# slack
