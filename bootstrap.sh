#!/usr/bin/env bash

# determine full path of user's home directory
HOME_DIR=$(cd && pwd)
TEMPLATES_DIR=$(xdg-user-dir TEMPLATES)

# get newest version
git pull origin master;


if [[ -d ./links ]]
then
	cd links
	find . -type d -exec mkdir --parent $HOME_DIR/{} \;			# create missing dirs
	find . -type f -exec ln -fsv $(pwd)/{} $HOME_DIR/{} \;		# create links
	cd ..
fi

if [[ -d "./hardlinks" ]]
then
	cd hardlinks
	find . -type d -exec mkdir --parent $HOME_DIR/{} \;			# create missing dirs
	find . -type f -exec ln -fv $(pwd)/{} $HOME_DIR/{} \;		# create links
	cd ..
fi

if [[ -d "./templates" ]]
then
	cd templates
	find . -type d -exec mkdir --parent $TEMPLATES_DIR/{} \;
	find . -type f -exec ln -fsv $(pwd)/{} $TEMPLATES_DIR/{} \;
	cd ..
fi

read -p "Would you like to sync git? (y|n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	git add links/*
	git add hardlinks/*
	git commit -a
	git push origin master
fi

exit 0