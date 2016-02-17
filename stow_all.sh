#!/bin/bash
for folder in */
do
    stow "${folder::-1}"
    echo "stowed ${folder::-1}"
done
