## Bonus OpenWRT

```console
wget -c https://downloads.openwrt.org/releases/19.07.4/targets/armvirt/32/openwrt-19.07.4-armvirt-32-zImage-initramfs -O openwrt/zImage-initramfs
qemu-system-arm -M virt \
    -kernel openwrt/zImage-initramfs \
    -device virtio-net-device,netdev=net0 \
    -netdev tap,ifname=tap0,id=net0,script= \
    -nographic
```


## Conclusión

* Este trabajo permite al lector disponer en poco tiempo de un laboratorio de SE basados en ARM utilizando QEMU.

¡Muchas gracias!
¿Preguntas?
