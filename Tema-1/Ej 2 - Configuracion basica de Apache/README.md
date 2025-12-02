*  Actividad 2 - Configuracion basica de apache

1. Apache utilizará el puerto 81 además del 80

Para ello, modificamos el archivo ports.conf con el siguiente comando "nano /etc/apache2/ports.conf" y añadimos la Directiva "Listen 81"

<img width="690" height="175" alt="image" src="https://github.com/user-attachments/assets/e61c1477-fa39-4851-afd0-7e5ee2a205dc" />

Probamos a entrar a localhost desde el puerto 81 que hemos configurado

<img width="826" height="226" alt="image" src="https://github.com/user-attachments/assets/a8f9d7de-f5a3-4b7b-84a3-49940d3d5c51" />

2. Añadir el dominio “marisma.intranet” en el fichero “hosts”

Para ello, modificamos el archivos hosts, con el siguiente comando "nano /etc/hosts"

<img width="905" height="238" alt="image" src="https://github.com/user-attachments/assets/65e539cd-7535-467a-906b-2835f7b2e97c" />

3. Cambia la directiva “ServerTokens” para mostrar el nombre del producto.

Nos vamos a la ruta "/etc/apache2/conf-enabled/" y modificamos el archivo "security.conf", modificamos el ServerTokens OS a ServerTokens Prod

<img width="715" height="311" alt="image" src="https://github.com/user-attachments/assets/a9810b46-f2f2-4e8b-aabd-03121f20613e" />

4. Comprueba si se visualiza el pie de página en las páginas generadas por Apache (por ejemplo, en las páginas de error). Cambia el valor de la directiva “ServerSignature” y comprueba que funciona correctamente. 

Nos vamos a la ruta "/etc/apache2/conf-enabled/" y modificamos el archivo "security.conf", modificamos el "ServerSignature On" a "ServerSignature Off"

<img width="700" height="383" alt="image" src="https://github.com/user-attachments/assets/0ee27b72-0cf3-45cc-ad21-c574658da727" />

Cmprobamos que funciona

<img width="365" height="221" alt="image" src="https://github.com/user-attachments/assets/1100824c-ba71-4a77-a78b-e414c5a2ef67" />

5. Crea un directorio “prueba” y otro directorio “prueba2”. Incluye un par de páginas en cada una de ellas.

Creamos las carpetas dentro de "cd /var/www/" y creamos las dos carpetas "mkdir prueba" y "mkdir prueba2"

<img width="562" height="237" alt="image" src="https://github.com/user-attachments/assets/410e1877-9a5e-4864-9200-9e30d7c681a0" />

Creamos las paginas index.html  en ambas

-PRUEBA

<img width="521" height="134" alt="image" src="https://github.com/user-attachments/assets/17acddbb-f7a3-4854-ae70-eb7a3839e40b" />

-PRUEBA2

<img width="540" height="143" alt="image" src="https://github.com/user-attachments/assets/ce3d74f0-572e-4a40-959b-81c00c0f6de5" />

Ahora, en "/etc/apache2/sites-availables" le creamos un archivo de configuracion para añadir las 2 paginas como VirtualHosts

<img width="711" height="326" alt="image" src="https://github.com/user-attachments/assets/9a09f255-a9d3-4960-a38d-309a37711285" />

Modificamos el archivo hosts para poder acceder a ambas paginas desde localhost


