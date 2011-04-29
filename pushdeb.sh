#!/bin/bash

if [[ "$1" = "" ]]; then
	echo "Usage: pushdeb.sh"
	echo "pushdeb.sh debs_dir"
	exit 1;
fi

DEBS_DIR="$1"

scp -r $DEBS_DIR roc@people.canonical.com:/home/roc/public_html/kernel/

