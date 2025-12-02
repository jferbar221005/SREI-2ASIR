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

Realizamos un a2ensite del archivo de configuracion que hemos creado, para habilitar las paginas y sus virtualhosts. El comanda "a2ensite josefb.conf" y reiniciamos apache

<img width="798" height="108" alt="image" src="https://github.com/user-attachments/assets/89f9ae22-f1b0-4448-9662-5bc7a8092155" />

<img width="828" height="46" alt="image" src="https://github.com/user-attachments/assets/9b765cd1-0026-403a-9994-f5bff127b37d" />

Modificamos el archivo hosts para poder acceder a ambas paginas desde localhost

<img width="785" height="175" alt="image" src="https://github.com/user-attachments/assets/14fdf009-266e-46cf-9bfd-01ec119b099d" />

6. Redirecciona el contenido de la carpeta "prueba" hacia "prueba2"

Hacemos un Redirect desde el VirtualHost de prueba a prueba2, para ello, modificamos el archivo de configuracion creado anteriormente "/etc/apache2/sites-available/josefb.conf"

<img width="773" height="209" alt="image" src="https://github.com/user-attachments/assets/fa22ff5d-34ee-44e0-9ed8-7621d8c4d1ac" />

Ahora, probamos a entrar desde http://prueba.intranet, y como podemos ver, nos redirige a http://prueba2.intranet

<img width="463" height="148" alt="image" src="https://github.com/user-attachments/assets/4b00d58f-d18d-4c86-9f69-952d22d43c18" />

7. Es posible redireccionar tan solo una página en lugar de toda la carpeta. Pruébalo.

Si que es posible

Para ello, usamos la siguiente directiva en el archivo .conf de los VirtualHost

<img width="757" height="219" alt="image" src="https://github.com/user-attachments/assets/576d64b5-df5d-492a-95fb-cac41f856ae6" />

8. Usa la directiva userdir

Primero habilitamos el modulo userdir "a2enmod userdir" y reiniciamos apache

<img width="833" height="119" alt="image" src="https://github.com/user-attachments/assets/0c13e471-f2aa-4f18-b0ce-86e5cecfba63" />

9. Usa la directiva alias para redireccionar a una carpeta dentro del directorio de usuario.

Añadimos la siguiente directiva al archivo userdir.conf y ya tendremoa habilitados los alias

<img width="795" height="291" alt="image" src="https://github.com/user-attachments/assets/7304937a-2896-417a-bf17-6fbe413b4ecc" />

10. ¿Para qué sirve la directiva Options y dónde aparece. Comprueba si apache indexa los directorios. Si es así, ¿cómo lo desactivamos?

La directiva Options controla qué características del servidor están disponibles en un directorio específico (por ej. seguir enlaces simbólicos, ejecutar CGI, listar archivos).

Su ubicación se define generalmente dentro del bloque <Directory> en el archivo de configuración del sitio (/etc/apache2/sites-available/tu-sitio.conf).

*Para evitar la exposición de archivos sensibles se debe utilizar el parámetro -Indexes

<Directory /var/www/prueba>
    # -Indexes: Desactiva el listado de archivos
    # +FollowSymLinks: Permite seguir enlaces simbólicos (recomendado)
    Options -Indexes +FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

*Crea un script que añada un puerto de escucha en el fichero de configuración de Apache. El puerto se recibirá como parámetro en la llamada y se comprobará que no esté ya presente en el fichero de configuración.



*Crea un script que añada un nombre de dominio y una ip al fichero hosts. Debemos comprobar que no existe dicho dominio en el fichero hosts



*Crea un script que nos permita crear una página web con un título, una cabecera y un mensaje


