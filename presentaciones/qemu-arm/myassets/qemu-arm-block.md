## QEMU-System-ARM Block Device

Qemu permite implementar un dispositivo tipo block a la virtual.

Acepta distintos formatos:

* Desde archivos: raw, qcow2, qed, qcow, luks, vdi, vmdk, vpc, VHDX
* Desde dispositivos: Block devices, CD, Floppy, SCSI
* Desde red: iSCSI, GlusterFS

Notes:
En las primeras versiones era necesario mapear una imagen como dispositivo tipo "raw".
Ademas desde imagenes remotas via ssh, NVMe


## Dispositivos disponibles

* ide
* scsi
* sd
* mtd
* floppy
* pflash
* virtio
* none


## Busybox

* Configuración por + CONFIG_STATIC=y ([link](scripts/bootstrap_busybox.sh)):

```text
./bootstrap_busybox.sh
```


## Construcción de disco

Creación de un disco de 10 Mb.

```text
dd if=/dev/zero of=root.ext2 bs=1M count=10
mkfs.ext2 root.ext2
mkdir -p root
```
Montado y carga de busybox (como root)
```text
mount -o loop root.ext2 root
cp -rp busybox/_install/* root/
umount root
```


## Primer ejecución

```text
qemu-system-arm -M virt,highmem=off \
    -kernel linux/arch/arm/boot/zImage \
    -append "root=/dev/vda rw" \
    -drive file=root.ext2,if=virtio,format=raw \
    -nographic
```

<pre data-cc="false">
<code class="text"> 
...
[    0.791198] EXT4-fs (vda): mounting ext2 file system using the ext4 subsystem
[    0.799567] EXT4-fs (vda): mounted filesystem without journal. Opts: (null)
[    0.800165] ext2 filesystem being mounted at /root supports timestamps until 2038 (0x7fffffff)
[    0.801117] VFS: Mounted root (ext2 filesystem) on device 254:0.
[    0.803208] devtmpfs: mounted
[    0.891859] Freeing unused kernel memory: 2048K
[    0.900565] Run /sbin/init as init process

Please press Enter to activate this console. 
/ # uname -a
Linux (none) 5.4.68 #8 SMP Sun Oct 4 00:27:27 -03 2020 armv7l GNU/Linux
/ # 
</code>
</pre>
