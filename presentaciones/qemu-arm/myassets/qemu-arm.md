## Qemu-System-ARM

```text
qemu-system-arm -M help
```

<pre data-cc="false">
<code class="text"> 
Supported machines are:
akita                Sharp SL-C1000 (Akita) PDA (PXA270)
ast2500-evb          Aspeed AST2500 EVB (ARM1176)
borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
canon-a1100          Canon PowerShot A1100 IS
cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
collie               Sharp SL-5500 (Collie) PDA (SA-1110)
connex               Gumstix Connex (PXA255)
cubieboard           cubietech cubieboard
emcraft-sf2          SmartFusion2 SOM kit from Emcraft (M2S010)
highbank             Calxeda Highbank (ECX-1000)
imx25-pdk            ARM i.MX25 PDK board (ARM926)

...

virt-3.1             QEMU 3.1 ARM Virtual Machine
virt-4.0             QEMU 4.0 ARM Virtual Machine
virt                 QEMU 4.1 ARM Virtual Machine (alias of virt-4.1)
virt-4.1             QEMU 4.1 ARM Virtual Machine
witherspoon-bmc      OpenPOWER Witherspoon BMC (ARM1176)
xilinx-zynq-a9       Xilinx Zynq Platform Baseboard for Cortex-A9
z2                   Zipit Z2 (PXA27x)
</code>
</pre>


## Maquina "virt"

* Esta diseñada para ser utilizada en entornos virtuales.
* Soporta PCI
* Soporta gran cantidad de memoria RAM (255GB)

Configuración de kernel minima tener en cuenta adicional a la configuracion por defecto de ARM ([link](scripts/my_defconfig)):
```texts
CONFIG_PCI=y
CONFIG_VIRTIO_PCI=y
CONFIG_PCI_HOST_GENERIC=y
```


## Compilando kernel

Editar env ([link](scripts/env))
```bash
# Set architecture
ARCH=arm
# Set Toolchain PATH
TOOLCHAIN="/home/sguarin/usr/linux-embedded-labs/x-tools/arm-sguarin-linux-gnueabihf"
# Kernel branch
KERNEL_VERSION="linux-5.4.y"
# Kernel defconfig to use
KERNEL_DEFCONFIG="defconfig"
# Local defconfig to add
KERNEL_MYCONFIG="my_defconfig"
```
Correr script ([link](scripts/bootstrap_kernel.sh))
```console
./bootstrap_kernel.sh
```


## Primer Boot

```text
qemu-system-arm -M virt,highmem=off \
    -kernel linux/arch/arm/boot/zImage \
    -nographic
```

<pre data-cc="false">
<code class="text"> 
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.4.68 (sguarin@mine.sguarin.com.ar) (gcc version 8.3.0 (crosstool-NG 1.24.0 - ISO2 Sguarin)) #8 SMP Sun Oct 4 00:27:27 -03 2020
[    0.000000] CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache

...

[    0.782264] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    0.782550] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.68 #8
[    0.782675] Hardware name: Generic DT based system
[    0.783387] [<c031275c>] (unwind_backtrace) from [<c030c948>] (show_stack+0x10/0x14)
[    0.783593] [<c030c948>] (show_stack) from [<c0ea0210>] (dump_stack+0xc0/0xd4)
[    0.783737] [<c0ea0210>] (dump_stack) from [<c03476b8>] (panic+0x110/0x328)
[    0.783932] [<c03476b8>] (panic) from [<c15014a4>] (mount_block_root+0x1cc/0x274)
[    0.784149] [<c15014a4>] (mount_block_root) from [<c15017b0>] (mount_root+0x120/0x13c)
[    0.784319] [<c15017b0>] (mount_root) from [<c1501948>] (prepare_namespace+0x17c/0x1c4)
[    0.784486] [<c1501948>] (prepare_namespace) from [<c0eb7484>] (kernel_init+0x8/0x110)
[    0.784640] [<c0eb7484>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    0.784824] Exception stack(0xc7089fb0 to 0xc7089ff8)
[    0.785018] 9fa0:                                     00000000 00000000 00000000 00000000
[    0.785256] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.785468] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.786028] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---
</code>
</pre>

Notes:
Ver version de kernel y cross tool.
ARMv7 procesor
