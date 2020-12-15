## MQTT/TLS en ESP32

* Arduino-mqtt [1]
* Light Weight MQTT: MQTT 3.1.1 [2]

* WiFiClientSecure [3]
* Mbed TLS [4]

<small>[1]: https://github.com/256dpi/arduino-mqtt</small>

<small>[2]: https://github.com/256dpi/lwmqtt</small>

<small>[3]: https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFiClientSecure</small>

<small>[4]: https://github.com/ARMmbed/mbedtls</small>
Notes:
lwmqtt derivado de Paho MQTT Embedded C, gomqtt, mosquitto
Arduino-mqtt 
WifiClientSecure framework de arduino
Mbed TLS: forma parte del sdk de Espressif


## Validaciones

* Sin validación
* Validación por fingerprint: Se verifica un digesto del certificado de servidor
* Validación por CA: Se verifica la validez del certificado de servidor a partir del certificado del emisor

Notes:


## Validacion por fingerprint

<small>Obtención de certificado</small>
```text
openssl s_client -host broker.sguarin.com.ar -port 8883
```
<small>Obtención de fingerprint</small>
```text
openssl x509 -in server.crt -sha256 -noout -fingerprint
SHA256 Fingerprint=41:C3:FE:9E:C5:C6:36:04:02:8F:FC:5A:BF:4E:3F:98:A9:73:F5:F5:6A:D4:3B:23:4A:1D:6D:82:1E:06:31:E4
```


## Validacion por fingerprint

```c

const char *server_fingerprint = "B8:9C:7D:12:B3:A0:19:D3:DF:9A:34:89:0B:62:2A:C3:DF:D5:83:43:F5:07:B3:9E:10:0F:C5:DC:D5:DD:2D:AC";

WiFiClientSecure client;
MQTTClient mqttclient;

mqttclient.begin("broker.sguarin.com.ar", 8883, client);
mqttclient.connect("esp32", "miusuario", "miclave");
if (netclient.verify(server_fingerprint, "broker.sguarin.com.ar"))
	printf("Certification validated by fingerprint");
else
	return -1;
...
```

DEMO


## Validacion por CA

```c
const char* root_ca= \
        "-----BEGIN CERTIFICATE-----\n" \
        "MIIDozCCAougAwIBAgIUD5jKSc9puKfmTYMbZ392NcGh8kEwDQYJKoZIhvcNAQEL\n" \
        ...
        "2QADjHEsGmcxKwG2wENSFsAjbPtrwuM=\n" \
        "-----END CERTIFICATE-----\n";
WiFiClientSecure client;
MQTTClient mqttclient;
netssl.setCACert(caCert);

mqttclient.begin("broker.sguarin.com.ar", 8883, client);
mqttclient.connect("esp32", "miusuario", "miclave");
...
```


## Validación por CA (verificación)

```text
NFO TEST: Connecting to WIFI...
test/test_MyMQTT-tls-ca/test_MyMQTT-tls-ca.cpp:116:test_wifi_connect:PASS
[E][ssl_client.cpp:33] _handle_error(): [start_ssl_client():199]: (-9984) X509 - Certificate verification failed, e.g. CRL, CA or signature check failed
```

DEMO


## TLS-PSK

```c
const char *psk_id = "esp32";
const char *psk_key = "aabb1122";

WiFiClientSecure client;
MQTTClient mqttclient;
netclient.setPreSharedKey(psk_id, psk_key);

mqttclient.begin("broker.sguarin.com.ar", 8883, client);
mqttclient.connect("esp32", "miusuario", "miclave");
...
```


## Comparación

| Esquema | Beneficios | Problematicas |
| ------- | ---------- | ------------- |
| TLS sin validación | No requiere config en firmware | Inseguro |
| TLS con finger | Verificación liviana | Mantenibilidad |
| TLS con CA | Baja mantenibilidad | Requiere mas recursos |
| TLS PSK | Verificación liviana | Configuración inicial particular |


## Demo

Sistema de monitoreo de material rodante [1]

<small>[1]: https://www.youtube.com/watch?v=4Cko0op-1u8</small>


## Fin

¿Preguntas?
