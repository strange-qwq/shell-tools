#!/bin/bash
echo "Hello QWQ"
if [ $1 == "update" ]
then
    echo "Upgrading..."
    sudo apt full-upgrade -y
else
    echo "apt $*"
    sudo apt $*
fi
