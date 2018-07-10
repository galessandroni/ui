#!/bin/bash
#
# Run this script in PeaceLink installation directory to create the necessary symlinks
# Backup target directories somewhere else before running this script
#

CURRENTDIR=`dirname $0`
source $CURRENTDIR/config.sh

cd $PCKDIR
ln -s $PCKUIDIR/xsl xsl
ln -s $PCKUIDIR/js pub/js/custom
ln -s $PCKUIDIR/css pub/css
ln -s $PCKUIDIR/custom uploads/custom
ln -s $PCKUIDIR/graphics/orig uploads/graphics/orig
ln -s $PCKUIDIR/graphics/favicon uploads/graphics/favicon
ln -s $PCKUIDIR/custom/admin.css admin/include/css/custom.css
ln -s $PCKUIDIR/custom/admin.js uploads/custom/admin.js
