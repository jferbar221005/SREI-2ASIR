*  Actividad 2 - Configuracion basica de apache

1. Apache utilizará el puerto 81 además del 80

Para ello, modificamos el archivo ports.conf con el siguiente comando "nano /etc/apache2/ports.conf" y añadimos la Directiva "Listen 81"

<img width="690" height="175" alt="image" src="https://github.com/user-attachments/assets/e61c1477-fa39-4851-afd0-7e5ee2a205dc" />

Probamos a entrar a localhost desde el puerto 81 que hemos configurado

<img width="826" height="226" alt="image" src="https://github.com/user-attachments/assets/a8f9d7de-f5a3-4b7b-84a3-49940d3d5c51" />

2. Añadir el dominio “marisma.intranet” en el fichero “hosts”

Para ello, modificamos el archivos hosts, con el siguiente comando "nano /etc/hosts"

<img width="646" height="247" alt="image" src="https://github.com/user-attachments/assets/8acead33-901b-48ed-ae1b-208f53f73b08" />

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

<img width="547" height="59" alt="image" src="https://github.com/user-attachments/assets/1ff945ea-7a1c-4a08-8a28-7ae5e57c05cf" />

Creamos las paginas index.html y notas.html en ambas

-PRUEBA

<img width="609" height="80" alt="image" src="https://github.com/user-attachments/assets/650a4fd5-9f32-492e-bf33-3ec27f834fba" />

-PRUEBA2

<img width="621" height="80" alt="image" src="https://github.com/user-attachments/assets/b6ba2f4e-740d-45ce-9917-761bf215b1bd" />




