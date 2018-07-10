#!/bin/bash
#
# Auto-deploy latest updates from github repo

WORKDIR="/data/pckui/test"
LOCKFILE="/tmp/autodeploy.lock"
REPO="peacelink/ui.git"

if [ ! -e $LOCKFILE ]; then
   trap "rm -f $LOCKFILE; exit" INT TERM EXIT
   touch $LOCKFILE

   cd $WORKDIR

   sudo git fetch --all
   sudo git remote update

   LOCAL=$(git rev-parse @)
   REMOTE=$(git rev-parse @{u})
   BASE=$(git merge-base @ @{u})

   if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
   elif [ $LOCAL = $BASE ]; then
    pckui_deploy.sh
    { echo "Auto-deployment on https://test.peacelink.org"; cat $WORKDIR/css/version.txt; echo; echo "New commits:"; git log @{1}.. --pretty=format:"%h - %cd - %cn - %s"; } | slacktee.sh
   elif [ $REMOTE = $BASE ]; then
    echo "Need to push!!"
   else
    echo "Diverged!!"
   fi

   rm $LOCKFILE
   trap - INT TERM EXIT
else
   echo "Previous autodeploy still running"
fi


