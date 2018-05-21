#!/bin/bash
#
# Deploy current dev release of PhPeace into PeaceLink dev
#

if [ "$(whoami)" != "www-data" ]; then
  echo "Script must be run as Apache user: www-data"
  exit 0
fi

CURRENTDIR=`dirname $0`
source $CURRENTDIR/config.sh

CURRENTBUILD=$($PHPEACEDIR/dev/scripts/phbuild.sh)

# Run build script locally
$PHPEACEDIR/dev/scripts/phdistrib.sh test

# Get build package filename
source $PHPEACEDIR/custom/buildconfig.sh
UPDATE=$DESTDIR/testing/updates/update_$CURRENTBUILD.tar.gz

# deploy package
if [ ! -d "$PCKDIR/temp" ]; then 
    mkdir "$PCKDIR/temp";
    chmod 775 $PCKDIR/temp
fi
cp -r $UPDATE $PCKDIR/temp/
$PCKDIR/scripts/phpeace/phpeace_manual_update.sh $CURRENTBUILD
