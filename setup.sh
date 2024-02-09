#!/bin/bash

print_info()
{
    echo -e "\033[1;33m$1\033[0m"
}
print_error()
{
    echo -e "\033[1;31m$1\033[0m" 1>&2
}

RAMDISK=/ramdisk
RDSIZE=32M

# does the mount point exist? if not, report an error
if [ ! -e $RAMDISK ] ; then
    print_error "Missing mount point $RAMDISK"
    exit 1
fi

# if it's not mounted, then mount it
mountpoint -q $RAMDISK
if [ $? != 0 ] ; then
    print_info "Creating ramdisk (size=$RDSIZE) at $RAMDISK"
    sudo mount -t tmpfs -o size=$RDSIZE tmpfs "$RAMDISK"
else
    # something's mounted there; check it's a ramdisk
    #mount |grep $RAMDISK |grep -q 'type tmpfs'
    #if [ $? != 0 ] ; then
    #    print_error "Something other than ramdisk mounted at ${RAMDISK}"
    #    exit 1
    #else
    #    print_info "Ramdisk already mounted; proceeding"
    #fi
    print_error "Mountpoint ${RAMDISK} in use"
    exit 1
fi


#
# get stuff from github

print_info "Cloning github repo"
cd $RAMDISK
git clone git@github.com:k8461781/test2.git
