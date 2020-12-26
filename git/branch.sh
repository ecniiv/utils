#!/bin/bash

function usage() {
	printf "Utilisation du script :\n"
	printf "\t-c : créer une branche ;\n"
	printf "\t-p : commit, push, checkout, delete ;\n"
	printf "\t-h : affiche ce message.\n"
}

optspec=":-:"
while getopts "$optspec" optchar; do
case "${OPTARG}" in help)
  	usage
		exit 1
		;;
	c)
		git checkout master
		git pull
		proposition="BR-"
		read -e -i  "$proposition" -p "name " input
		mybranch="${input}"
		git checkout -b "$mybranch"
		exec /bin/bash
		;;
	p)
		branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
		proposition2="$branch"":"
		read -e -i  "$proposition2" -p "Objet du commit " input
		git commit -a -s -m "${input}"
		git push --set-upstream origin "$branch"
		git checkout master
		git branch -D "$branch"
		git pull
		exec /bin/bash;;
	h)
  	usage
  	exit 1
		;;
esac
done
