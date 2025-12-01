*  Actividad 2 - Configuracion basica de apache

1. Apache utilizará el puerto 81 además del 80

Para ello, modificamos el archivo ports.conf con el siguiente comando "nano /etc/apache2/ports.conf"

<img width="690" height="175" alt="image" src="https://github.com/user-attachments/assets/e61c1477-fa39-4851-afd0-7e5ee2a205dc" />

Probamos a entrar a localhost desde el puerto 81 que hemos configurado

<img width="826" height="226" alt="image" src="https://github.com/user-attachments/assets/a8f9d7de-f5a3-4b7b-84a3-49940d3d5c51" />

2. Añadir el dominio “marisma.intranet” en el fichero “hosts”

Para ello, modificamos el archivos hosts, con el siguiente comando "nano /etc/hosts"

<img width="646" height="247" alt="image" src="https://github.com/user-attachments/assets/8acead33-901b-48ed-ae1b-208f53f73b08" />

3. Cambia la directiva “ServerTokens” para mostrar el nombre del producto.







