#!/bin/bash
#
# Deploy
#
# Run as ubuntu user
if [ "$(whoami)" != "ubuntu" ]; then
  echo "Script must be run as ubuntu"
  exit 0
fi

# test or live?
ENV=$1

PCKUIDIR="/data/pckui"
REPO="peacelink/ui.git"

if [ "$ENV" == "live" ]; then
  DEPLOYDIR="$PCKUIDIR/$ENV"
  BRANCH="master"
else
  DEPLOYDIR="$PCKUIDIR/test"
  BRANCH="dev"
fi

# fix permissions
sudo chown -R ubuntu.ubuntu $DEPLOYDIR

cd $DEPLOYDIR

# make sure we use ssl remote
# git remote set-url origin https://github.com/$REPO

# checkout local changes
git reset --hard

# git pull using deployment key
git pull origin $BRANCH

# fix permissions
sudo chown -R www-data.www-data $DEPLOYDIR

# Gather version info
PCKUI_VERSION=$(cat $DEPLOYDIR/version.txt)
GIT_REF=$(git log --pretty=%H -1)
GIT_REF_SHORT=${GIT_REF:0:7}
GIT_BRANCH="$(git symbolic-ref HEAD 2>/dev/null)" ||
GIT_BRANCH="(unnamed branch)"     # detached HEAD
GIT_BRANCH=${GIT_BRANCH##refs/heads/}
DEPLOY_TS=$(date +"%d/%m/%Y %H:%M:%S")
VERSION_INFO="pckui $PCKUI_VERSION - $GIT_BRANCH $GIT_REF_SHORT - $DEPLOY_TS"

echo "$VERSION_INFO" | sudo tee $DEPLOYDIR/css/version.txt
