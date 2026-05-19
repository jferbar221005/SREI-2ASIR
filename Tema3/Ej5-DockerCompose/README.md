# Actividad 5 - Docker

#  1. Pila Básica Monoservicio (Servidor Web Declarativo)

- Creamos un directorio específico para este ejemplo y nos situamos en el:

````
mkdir -p ~/practica5/ejemplo1 && cd ~/practica5/ejemplo1
````

<img width="755" height="52" alt="image" src="https://github.com/user-attachments/assets/14f4b037-0bba-4e75-8607-054e136b8e0e" />

- Creamos el archivo de configuración con el nombre exacto docker-compose.yml y añadimos el siguiente codigo:
````
nano docker-compose.yml
````
````
version: '3.8'

services:
  servidor_web:
    image: nginx:alpine
    container_name: compose_nginx_simple
    ports:
      - "8085:80"
````

<img width="1178" height="222" alt="image" src="https://github.com/user-attachments/assets/a93561f6-f2de-42da-b035-e16e5b9c1055" />

- Levantamos el entorno en segundo plano (-d)
````
docker compose up -d
````

<img width="1591" height="172" alt="image" src="https://github.com/user-attachments/assets/1230c673-91c6-43c1-9510-3ec22f984efe" />

Por ultimo comprobamos dentro del directorio que el contenedor se esta ejecutando y con el redireccionamiento del puerto
````
docker compose ps
````

<img width="1591" height="125" alt="image" src="https://github.com/user-attachments/assets/274e8573-b701-4c4e-90d1-42c74a3703df" />


# 2. Infraestructura Multi-contenedor con Persistencia y Dependencias (WordPress + MariaDB)

En escenarios de producción, los servicios dependen de otros. Aquí enlazamos un CMS web con un motor de base de datos relacional aislándolos dentro de la misma red implícita creada por Compose, y garantizando que los datos sobrevivan usando un volumen gestionado.

- Preparamos el entorno aislado:
````
mkdir -p ~/practica5/ejemplo2 && cd ~/practica5/ejemplo2
````
<img width="926" height="50" alt="image" src="https://github.com/user-attachments/assets/703dea9d-5d0f-44cf-89b4-edec5e28a0b2" />

- Creamos el docker-compose.yml

````
nano docker-compose.yml
````

- Diseñamos el archivo yml

````
version: '3.8'

services:
  base_datos:
    image: mariadb:10.6
    container_name: compose_mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: password_maestra_asir
      MYSQL_DATABASE: wp_infraestructura
      MYSQL_USER: usuario_wp
      MYSQL_PASSWORD: password_segura_wp
    volumes:
      - datos_mariadb:/var/lib/mysql

  sitio_web:
    image: wordpress:latest
    container_name: compose_wordpress
    restart: always
    depends_on:
      - base_datos
    ports:
      - "8086:80"
    environment:
      WORDPRESS_DB_HOST: base_datos:3306
      WORDPRESS_DB_USER: usuario_wp
      WORDPRESS_DB_PASSWORD: password_segura_wp
      WORDPRESS_DB_NAME: wp_infraestructura

volumes:
  datos_mariadb:
````

<img width="1162" height="755" alt="image" src="https://github.com/user-attachments/assets/5ea25c42-4783-4395-8b3b-ca258e2f4394" />


- Desplegamos la aplicacion
````
docker compose up -d
````
<img width="557" height="232" alt="image" src="https://github.com/user-attachments/assets/d4f83cb8-b43e-4ab7-8402-14b7ddd3877e" />

- Accedemos desde un navegador a la IP:8086 de la maquina y como podemos observar, Wordpress se ha montado correctamente

<img width="906" height="996" alt="image" src="https://github.com/user-attachments/assets/8e349678-e9c6-471e-976c-feaf98f5843f" />


# 3. Interfaz Gráfica para Docker (Portainer)

- Preparamos el entorno aislado:
````
mkdir -p ~/practica5/ejemplo3 && cd ~/practica5/ejemplo3
````

<img width="923" height="52" alt="image" src="https://github.com/user-attachments/assets/5e33a1b7-a350-481e-b6c8-508e01c6fac5" />

- Creamos el docker-compose.yml

````
nano docker-compose.yml
````

- Diseñamos el archivo yml

````
version: '3.8'

services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: mi_portainer
    restart: always
    ports:
      - "9000:9000"
    volumes:
      # Esto permite a Portainer leer la configuración de tu Docker local
      - /var/run/docker.sock:/var/run/docker.sock
      # Esto guarda tus configuraciones de Portainer para no perderlas
      - datos_portainer:/data

volumes:
  datos_portainer:
````
<img width="1137" height="396" alt="image" src="https://github.com/user-attachments/assets/7bcad309-3dee-4a45-ac52-898ca4f97715" />


- Desplegamos la aplicacion
````
docker compose up -d
````

<img width="557" height="186" alt="image" src="https://github.com/user-attachments/assets/a82b1175-89c4-4902-a1be-2499347887cb" />

- Accedemos desde un navegador a la IP:9000 de la maquina y como podemos observar, Portainer se ha montado correctamente

<img width="888" height="863" alt="image" src="https://github.com/user-attachments/assets/e46b26a3-fd46-4a86-a2bd-fbdd81ca7810" />
