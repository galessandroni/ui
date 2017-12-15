#!/bin/bash
#
# Run this script in PeaceLink installation directory to create the necessary symlinks
# Backup target directories somewhere else before running this script
# 

PCKUIDIR="/var/www/pckui"

ln -s $PCKUIDIR/xsl xsl
ln -s $PCKUIDIR/js pub/jsc
ln -s $PCKUIDIR/css pub/css
ln -s $PCKUIDIR/custom uploads/custom
ln -s $PCKUIDIR/graphics/orig graphics/orig
ln -s $PCKUIDIR/graphics/favicon graphics/favicon
