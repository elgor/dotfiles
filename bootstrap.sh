#!/usr/bin/env bash

# determine full path of user's home directory
HOME_DIR=$(cd && pwd)

# get newest version
git pull origin master;


cd links

# create missing dirs
find . -type d -exec mkdir --parent $HOME_DIR/{} \;

# create links
find . -type f -exec ln -f -s $(pwd)/{} $HOME_DIR/{} \;

exit 0