## MQTT

MQTT esta sobre la capa de transporte TCP
Problemas:
* Confidencialidad: Preservación al acceso a información.
* Integridad: Manipulación de la información, destrucción, no repudio, autenticidad.

Notes:
* Confidentiality: Preserving authorized restrictions on information access and
disclosure, including means for protecting personal privacy and proprietary information. A loss of confidentiality is the unauthorized disclosure of information. * Integrity: Guarding against improper information modification or destruction,
including ensuring information nonrepudiation and authenticity. A los


## Captura publicación

<img src="myassets/mqtt-wireshark.png" height="500">

Notes:
* MQTT prevee un paquete de respuesta de connect, Si no lo recibe, el cliente no debe publicar. Debería cerrar el socket, esperar un tiempo "prudente" y volver a reintentar.


## Autenticación

MQTT prevee en el protocolo un esquema de autenticación. [1]

<img src="myassets/mqtt-header.png" height="350">

<small>[1]: http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718028</small>

Notes:
El protocolo prevee una cabecera de tamaño fijo y otra de tamaño variable.
Dentro de la cabecera de tamaño fijo se preveen flags para variables opcionales "User Name" y "Password" entre otras.
Dentro del tamaño de variable, se definen con dos bytes el tamaño de datos y luego los datos.


## Implementación mosquitto

/etc/mosquitto/mosquitto.conf
```text
pwfile /etc/mosquitto/pwfile
```
```text
mosquitto_passwd -c -b /etc/mosquitto/pwfile miusuario miclave
cat /etc/mosquitto/pwfile
miusuario:$6$O5LONSpwu6eMPXkK$zXydpNKK+9V8 ...
```
```text
mosquitto_pub -h mine.sguarin.com.ar -t test -u miusuario -P miclave -m hola
```

Notes:
Adicionalmente tiene otras sentencias para poder limitar el acceso por topicos, teniendo en cuenta si el acceso es de lectura, escritura o ambos.
También soporta comodines en el nombre de topico el acceso de forma jerarquica.


## Captura conexión autenticada

<img src="myassets/mqtt-header-wireshark.png" height="500">

