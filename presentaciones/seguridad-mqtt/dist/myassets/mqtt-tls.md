## TLS

<img src="myassets/mqtt-tls-layer.jpeg">

Puerto 8883

<small>http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=mqtt</small>

Notes:


## TLS

<img src="myassets/tls.png">

Notes:
Para que el TLS funcione de forma escalable existen tres figuras importantes:
* Los navegadores o clientes
* Los servidores.
* Las autoridades certificantes.
Utiliza las tecnologias:
* Criptografia asimetrica
* Criptografia simetrica
* Certificados digitales. X.509 es un estándar UIT-T. Documentos firmados con vencimiento, titular, certificante, etc.


## TLS comunicacion

<img src="myassets/mqtt-tls-handshake.png" height="600">

Notes:
* Fase 1: Ambos hello message ofrecen protocolos (versiones, algoritmos de encripcion, compresion), numeros aleatorios, bautiza el ID de sesion. 
* Fase 2: Ya es dependiente de la versión de TLS y de los algoritmos de encripción utilizados, se intercambian certificados. Eventualmente el servidor puede requerir autenticación de cliente por certificado. El server_key_exchange es opcional y es requerido cuando la información del certificado servidor no alcanza para que el cliente genere una clave maestra 1 (Diffie Hellman)
* Fase 3: Es la parte mas importante y es donde el cliente establece la clave maestra 1 encriptandola con la publica del certificado.
* Fase 4: 


## Generacion de certificados

### Creación de Autoridad certificante raiz
```text
openssl genrsa -out ca.key 2048
openssl req -new -x509 -key ca.key -out ca.crt -subj "/C=AR/ST=CABA/L=CABA/O=MSE/OU=SED/CN=MSE-SED AC Raiz"
```

### Creación de certificado para servicio
```text
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/C=AR/ST=CABA/L=CABA/O=MSE/OU=SED/CN=broker.sguarin.com.ar"
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 730
```

Notes:
* En el primer caso se genera un certificado autofirmado de AC
* En el segundo se genera un CSR. Flujo CSR. AC devuelve un certificado firmando el CSR con su privada. 


## Configuración de servicio Mosquitto

/etc/mosquitto/mosquitto.conf
```text
listener 8883

[...]

cafile /etc/mosquitto/ca.crt

# Path to the PEM encoded server certificate.
certfile /etc/mosquitto/server.crt

# Path to the PEM encoded keyfile.
keyfile /etc/mosquitto/server.key
```

Notes:
* port 8883 iana


## Prueba de servicio

```text
mosquitto_pub -d -h broker.sguarin.com.ar -t smmrtest --cafile ca.crt -m "hola"
```

```text
Client mosq-kL5hJxUdOE0FPUeuoF sending CONNECT
Client mosq-kL5hJxUdOE0FPUeuoF received CONNACK (0)
Client mosq-kL5hJxUdOE0FPUeuoF sending PUBLISH (d0, q0, r0, m1, 'smmrtest', ... (4 bytes))
Client mosq-kL5hJxUdOE0FPUeuoF sending DISCONNECT
```


## Captura conexion TLS

<img src="myassets/mqtt-tls-wireshark.png" height="500" width="1000">