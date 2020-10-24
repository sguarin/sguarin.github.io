#!/bin/bash

BASE=`dirname $0`

. $BASE/env

if [ -e "linux" ] ; then
    cd linux
fi

if [ "$(basename $(pwd))" != "linux" ] ; then
    # Clone kernel repo
    git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    cd linux

    # Add stable branches
    git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
    git fetch stable
else
    #make distclean
    true
fi

# Checkout version
git checkout -f ${KERNEL_VERSION}

make ${KERNEL_DEFCONFIG}

make savedefconfig

cat defconfig ../${BASE}/${KERNEL_MYCONFIG} > arch/${ARCH}/configs/$(basename ${KERNEL_MYCONFIG})

make ${KERNEL_MYCONFIG}

echo "Modifying configuration complete"
read -p "Press ENTER to compile"

make -j8 zImage

echo "Compiling complete"

