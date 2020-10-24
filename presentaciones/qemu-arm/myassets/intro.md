## ¿Que es QEMU?

QEMU es un emulador y virtualizador generico y de codigo abierto. [1]

* Genérico
* Emulador
* Virtualizador

<small>[1]: http://qemu.org</small>

Notes:
En la pagina se autodefine.

Generico: Porque admite varias arquitecturas

Emulador: Se emula el comportamiento del hardware a través del software.

Virtualizador: La maquina virtual utiliza gran parte del hardware de forma directa.


## Plataformas

<table>
<tr>
<td>
<img src="myassets/intro-qemu-platforms.png">
</td>
<td>

<img src="myassets/intro-qemu-platforms2.png">
</td>

</tr>
</table>

<small>[1]: https://wiki.qemu.org/Documentation/Platforms</small>

Notes:
TCG (Tiny Code Generator) began as a generic backend for a C
compiler.
It was simplified to be used in QEMU. Fuertemente tipado.
Transforma instrucciones del procesador emulado via the TCG frontend en TCG ops y luego estas son transformadas en intruscciones del procesador anfitrion.


## Instalación

Fedora
```bash
sudo dnf install qemu-system-arm
```

Centos/RedHat
```console
sudo yum install qemu-system-arm
```

Debian/Ubuntu
```bash
sudo apt-get install qemu-system-arm
```

