#!/usr/bin/env bash

# determine full path of user's home directory
HOME_DIR=$(cd && pwd)

# get newest version
git pull origin master;


cd links

# create missing dirs
find . -type d -exec mkdir --parent $HOME_DIR/{} \;

# create links
find . -type f -exec ln -fsv $(pwd)/{} $HOME_DIR/{} \;

read -p "Would you like to sync git? (y|n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	git add *
	git commit -a
	git push origin master
fi

exit 0