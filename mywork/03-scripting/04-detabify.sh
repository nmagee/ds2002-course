#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo "This is script converts a TSV into a CSV";
fi

/usr/bin/tr '\t' ',' < $1 > $2


