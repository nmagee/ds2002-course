#!/bin/bash

read -p "Please enter an integer: " FIRNUM
read -p "Please enter a second integer: " SECNUM

ADDTHEM=$(($FIRNUM+$SECNUM))

echo "The sum of $FIRNUM and $SECNUM is $ADDTHEM"
