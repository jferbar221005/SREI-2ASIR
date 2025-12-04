1. Crea cinco usuarios: usuario1, usuario2, usuario3, usuario4, usuario5.

- Usamos los siguientes comandos para añadir los usuario a un archivo htpasswd

<img width="756" height="344" alt="image" src="https://github.com/user-attachments/assets/a68075eb-00da-4b9c-844c-7ecbf17a52ca" />

2. Crea dos grupos de usuarios, el primero formado por usuario1 y usuario2; y el segundo por el resto de usuarios.

- Creamos el archivo de grupos "sudo nano /etc/apache2/.htgroups" y dentro, definimos a que grupo pertenece cada usuario

<img width="670" height="124" alt="image" src="https://github.com/user-attachments/assets/c4c74d02-f8b3-428f-9151-21dde2e768d6" />

3. Crea un directorio llamado privado1 que permita el acceso a todos los usuarios.

- Primero, creamos las carpetas en /var/www

<img width="593" height="70" alt="image" src="https://github.com/user-attachments/assets/da5b09b9-3d3c-4009-836c-12a80147cae7" />







