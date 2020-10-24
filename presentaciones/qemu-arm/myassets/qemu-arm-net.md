## QEMU-System-ARM Networking

* QEMU puede emular varios dispositivos de red (PCI, ISA, etc)
* Puede conectarlos con otras instancias emuladas.
* Puede conectarse a la red real del anfitrión.

* Se usan dos sentencias "-device" y "-netdev"


## Dispositivos disponibles

```text
qemu-system-arm -M virt -devices help
```

<pre data-cc="false">
<code class="text"> 
...
Network devices:
name "e1000", bus PCI, alias "e1000-82540em", desc "Intel Gigabit Ethernet"
name "e1000-82544gc", bus PCI, desc "Intel Gigabit Ethernet"
name "e1000-82545em", bus PCI, desc "Intel Gigabit Ethernet"
name "e1000e", bus PCI, desc "Intel 82574L GbE Controller"
name "i82550", bus PCI, desc "Intel i82550 Ethernet"
name "i82551", bus PCI, desc "Intel i82551 Ethernet"
name "i82557a", bus PCI, desc "Intel i82557A Ethernet"
name "i82557b", bus PCI, desc "Intel i82557B Ethernet"
name "i82557c", bus PCI, desc "Intel i82557C Ethernet"
name "i82558a", bus PCI, desc "Intel i82558A Ethernet"
name "i82558b", bus PCI, desc "Intel i82558B Ethernet"
name "i82559a", bus PCI, desc "Intel i82559A Ethernet"
name "i82559b", bus PCI, desc "Intel i82559B Ethernet"
name "i82559c", bus PCI, desc "Intel i82559C Ethernet"
name "i82559er", bus PCI, desc "Intel i82559ER Ethernet"
name "i82562", bus PCI, desc "Intel i82562 Ethernet"
name "i82801", bus PCI, desc "Intel i82801 Ethernet"
name "ne2k_pci", bus PCI
name "pcnet", bus PCI
name "pvrdma", bus PCI, desc "RDMA Device"
name "rocker", bus PCI, desc "Rocker Switch"
name "rtl8139", bus PCI
name "usb-bt-dongle", bus usb-bus
name "usb-net", bus usb-bus
name "virtio-net-device", bus virtio-bus
name "virtio-net-pci", bus PCI, alias "virtio-net"
name "virtio-net-pci-non-transitional", bus PCI
name "virtio-net-pci-transitional", bus PCI
name "vmxnet3", bus PCI, desc "VMWare Paravirtualized Ethernet v3"
...
</code>
</pre>


## Modalidades disponibles

* Tap: Permite conectar una interfaz "virtual" tipo TAP en el anfitrion a una interfaz virtual en el huesped.

* User: Instancia un DHCP/DNS virtual.

* Hub: Se simula uno o mas "hubs" en donde las maquinas huespedes sepueden conectar entre si, incluso con una interfaz TAP.

Notes: La primera es la preferida para obtener conexión al exterior.


## Configuración de anfitrión

![i1](myassets/qemu-arm-net-diagram.png)
```text
modprobe dummy
ip tuntap add name tap0 mode tap
ip link set dev tap0 master br-lan
ip link set up dev tap0
```

Notes: br-lan existe en el anfitrion armando un puente (bridge) entre eth0 y tap0.


## Primer ejecución

```text
qemu-system-arm -M virt,highmem=off \
    -kernel linux/arch/arm/boot/zImage \
    -append "root=/dev/vda rw" \
    -drive file=root.ext2,if=virtio,format=raw \
    -device virtio-net-device,netdev=net0 \
    -netdev tap,ifname=tap0,id=net0,script= \
    -nographic
```


## Configuracion manual de red

Configuramos interfaz e ip (capa 2 y 3)
```text
ip link set up dev eth0
ip addr add 192.168.12.101/24 dev eth0
```

Probamos conectividad con router
```text
ping -c 2 192.168.12.1
```

Configuramos ruta default
```text
ip route add default via 192.168.12.1
```

Probamos conectividad con DNS de google
```text
ping -c 2 8.8.8.8
```