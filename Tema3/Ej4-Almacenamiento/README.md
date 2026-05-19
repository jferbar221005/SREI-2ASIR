# Actividad 4 - Docker

# 1. Almacenamiento con "Bind Mounts" (Mapeo local)

Un bind mount vincula una carpeta exacta de tu máquina anfitriona con una carpeta dentro del contenedor. Es muy útil para entornos de desarrollo, ya que cualquier cambio que hagas en tu equipo se refleja inmediatamente en el servicio.

. Vamos a crear una web personalizada sirviéndola con Nginx:

-  Creamos una carpeta local y un archivo HTML básico

````
mkdir -p ~/docker_practica4/web
````
<img width="507" height="48" alt="image" src="https://github.com/user-attachments/assets/2c586b52-dd77-4952-a8e7-780e1cac2685" />

````
echo "<h1>Practica 4 - Bind Mount Funciona</h1>" > ~/docker_practica4/web/index.html
````
<img width="1016" height="47" alt="image" src="https://github.com/user-attachments/assets/f20e8456-7302-449c-ba24-26e0ec25ed2f" />


- Lanzamos el contenedor montando (-v) la ruta local en la ruta por defecto de Nginx

````
docker run -d --name nginx_bind -p 8081:80 -v ~/docker_practica4/web:/usr/share/nginx/html nginx
````
<img width="1143" height="72" alt="image" src="https://github.com/user-attachments/assets/2e687bc7-2f54-4653-bc36-534fd622a606" />

- Para comprobar que funciona, usamos ````curl localhost:8081````

<img width="422" height="73" alt="image" src="https://github.com/user-attachments/assets/3448114b-0261-46f6-8b00-e1c13d65747f" />


# 2. Almacenamiento con Volúmenes de Docker

A diferencia de los bind mounts, los volúmenes son gestionados íntegramente por Docker (están ocultos en /var/lib/docker/volumes/). Son la forma recomendada para guardar datos de bases de datos de manera segura y persistent
Vamos a desplegar una base de datos MariaDB con un volumen persistente:

- Creamos el volumen explícitamente
````
docker volume create datos_mariadb
````

<img width="521" height="66" alt="image" src="https://github.com/user-attachments/assets/9ff8bcd2-d72f-4e99-845b-2d71acba20e9" />

- Lanzamos la base de datos usando ese volumen
````
docker run -d --name mi_bd_persistente -e MYSQL_ROOT_PASSWORD=asir_pass -v datos_mariadb:/var/lib/mysql mariadb
````

<img width="1272" height="43" alt="image" src="https://github.com/user-attachments/assets/66b0e123-71f1-4c22-a7f8-4bc0705e3d16" />

- Comprobamos que el volumen existe y está en uso
````
docker volume inspect datos_mariadb
````

<img width="727" height="311" alt="image" src="https://github.com/user-attachments/assets/d03a401d-85a6-4c6a-afa6-258f67f3d55d" />

# 3. Redes personalizadas (User-defined Bridge Networks)

Por defecto, los contenedores se conectan a una red llamada bridge, pero esta red no tiene resolución DNS interna. Si creamos nuestra propia red, los contenedores podrán comunicarse entre sí utilizando sus nombres en lugar de sus direcciones IP, lo cual es vital para comunicar un servidor web con su base de datos

- Creamos nuestra red aislada
````
docker network create red_asir
````

<img width="650" height="76" alt="image" src="https://github.com/user-attachments/assets/a7f8fbad-2b3a-49a0-ab68-3c688193a842" />

- Lanzamos un contenedor conectado a esa red (simulando un servidor interno)
````
docker run -d --name servidor_interno --network red_asir nginx
````

<img width="801" height="75" alt="image" src="https://github.com/user-attachments/assets/7608ec95-2e71-4c33-b353-1d10072df4a2" />

- Lanzamos un contenedor interactivo en la misma red para hacerle un ping por su nombre
````
docker run -it --rm --network red_asir alpine /bin/sh
````

<img width="822" height="312" alt="image" src="https://github.com/user-attachments/assets/d73ccd33-cfcc-4747-9044-e8bcd875cf8d" />
