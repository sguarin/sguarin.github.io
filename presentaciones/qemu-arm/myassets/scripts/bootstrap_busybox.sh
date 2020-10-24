#!/bin/bash
set -x
BASE=`dirname $0`

. $BASE/env

if [ -e "busybox" ] ; then
    cd busybox
fi

if [ "$(basename $(pwd))" != "busybox" ] ; then
    # clone inicial
    git clone git://busybox.net/busybox.git
    cd busybox
else
    make distclean
    true
fi

BUSYBOX_ROOT="_install"

# Checkout version
git checkout ${BUSYBOX_VERSION}

make defconfig

sed -i -e "s:.*CONFIG_STATIC[= ].*:CONFIG_STATIC=y:" .config

make

echo "Compiling complete"

make install

mkdir -p ${BUSYBOX_ROOT}/{dev,proc,sys,etc}
cp examples/inittab ${BUSYBOX_ROOT}/etc/

mkdir -p ${BUSYBOX_ROOT}/etc/init.d
echo '#!/bin/sh' > ${BUSYBOX_ROOT}/etc/init.d/rcS
echo "mount -t proc none /proc" >> ${BUSYBOX_ROOT}/etc/init.d/rcS
echo "mount -t sysfs none /sys" >> ${BUSYBOX_ROOT}/etc/init.d/rcS
chmod +x ${BUSYBOX_ROOT}/etc/init.d/rcS

cd ..

#dd if=/dev/zero of=root.ext2 bs=1M count=10
#mkfs.ext2 root.ext2
#mkdir -p root
#sudo mount -o loop root.ext2 root
#sudo cp -rp busybox/_install/* root/
#sudo umount root

