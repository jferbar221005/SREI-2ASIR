# Actividad 6 - Docker

# 1. Empaquetar una web en Nginx (Instruccion COPY)
En lugar de montar un volumen (como hicimos en la práctica 4), vamos a meter la página web directamente dentro de la imagen. Asi, la imagen se podrá llevar a cualquier servidor y siempre tendra esa web.

- Preparamos el entorno aislado:
````
mkdir -p ~/practica6/ejemplo1 && cd ~/practica6/ejemplo1
````
<img width="925" height="66" alt="image" src="https://github.com/user-attachments/assets/0071d938-973d-402b-9bbd-2e6fa95b69ef" />

- Creamos una web basica
````
echo "<h1>Mi primera imagen Docker personalizada para ASIR</h1>" > index.html
````
<img width="1132" height="47" alt="image" src="https://github.com/user-attachments/assets/50042152-e35d-4570-8031-44536057e489" />

- Creamos el DockerFile

<img width="1118" height="87" alt="image" src="https://github.com/user-attachments/assets/582f139b-cd62-4e6a-b62e-bb23afbdad37" />

- Construimos la imagen (el punto final indica que busque el Dockerfile en la carpeta actual)

````
docker build -t mi-nginx-asir .
````

<img width="2045" height="486" alt="image" src="https://github.com/user-attachments/assets/4ead8538-575c-4bde-82d4-56f950225106" />

- Levantamos el contenedor
````
docker run -d -p 8090:80 mi-nginx-asir
````
<img width="752" height="72" alt="image" src="https://github.com/user-attachments/assets/94fad235-5ab1-4eed-885f-85e355f8e95c" />

- Accedemos desde el navegador a la IP:8090 de nuestra maquina, como podemos ver, la imagen se ha contruido y ejecutado correctamente.

<img width="961" height="185" alt="image" src="https://github.com/user-attachments/assets/a43cc575-e150-40e0-8484-a7d6dff4599a" />

#  2. Instalar servicios desde cero (Instruccion RUN)

Vamos a partir de un sistema operativo base (Debian) y le vamos a instalar el servidor web Apache. Esto es útil cuando no existe una imagen prefabricada con todo lo que necesitas.

- Preparamos el entorno aislado:
````
mkdir -p ~/practica6/ejemplo2 && cd ~/practica6/ejemplo2
````

<img width="921" height="47" alt="image" src="https://github.com/user-attachments/assets/5672aa54-c505-467f-83d7-6ba03659fbf1" />

- Creamos el DockerFile

````
FROM debian:12-slim
   RUN apt-get update && apt-get install -y apache2
   RUN echo "Web servida desde mi propio Apache en Debian" > /var/www/html/index.html
   EXPOSE 80
   CMD ["apache2ctl", "-D", "FOREGROUND"]
````

<img width="1128" height="157" alt="image" src="https://github.com/user-attachments/assets/92a020d5-d52c-443b-a7c1-30d48a3785b2" />

- Construimos la imagen (el punto final indica que busque el Dockerfile en la carpeta actual)

````
docker build -t mi-apache-debian .
````

<img width="1207" height="503" alt="image" src="https://github.com/user-attachments/assets/23a6f646-81f1-47a8-a0a2-c720b04e5ca2" />

- Levantamos el contenedor
````
docker run -d -p 8091:80 mi-apache-debian
````

<img width="773" height="61" alt="image" src="https://github.com/user-attachments/assets/4739aa4b-895f-49d5-99c3-5592c23daeb6" />

- Comprobamos su coorrecta implantacion con ````curl localhost:8091````

  <img width="557" height="67" alt="image" src="https://github.com/user-attachments/assets/71552331-9695-4cc3-9147-c13ad2311a10" />

# 3. Contenedor con un script utilitario (Instrucción CMD)

A veces no queremos un servidor web, sino un contenedor que ejecute una tarea en bucle (por ejemplo, monitorizar algo o hacer copias de seguridad). Vamos a crear una imagen ligerísima que ejecute un script.

- Preparamos el entorno aislado:
````
mkdir -p ~/practica6/ejemplo3 && cd ~/practica6/ejemplo3
````
<img width="913" height="47" alt="image" src="https://github.com/user-attachments/assets/92ce04c3-82aa-4a36-9cc6-aeb7ef643d4d" />

- Creamos el script de bash

````
#!/bin/sh
   while true; do
       echo "Ejecutando mi script personalizado dentro de un contenedor..."
       sleep 3
   done
````

<img width="1123" height="158" alt="image" src="https://github.com/user-attachments/assets/f1da6cb8-b9b3-4b65-938b-51b11af62b75" />

- Creamos el DockerFile

````
FROM alpine:latest
   COPY script.sh /script.sh
   RUN chmod +x /script.sh
   CMD ["/script.sh"]
````
<img width="1133" height="120" alt="image" src="https://github.com/user-attachments/assets/31fa9d1e-95ea-443e-a87c-1b463a9ec7e6" />

- Construimos la imagen y la ejecutamos

````
docker build -t mi-script-asir .
````

<img width="1190" height="512" alt="image" src="https://github.com/user-attachments/assets/7a7a86e7-eed2-4c57-878d-97d0901a57b2" />

````
docker run -d --name contenedor_script mi-script-asir
````

- Para comprobar que el script esta leyendo los registros del contenedor:

````
docker logs contenedor_script
````

<img width="647" height="366" alt="image" src="https://github.com/user-attachments/assets/feff0661-720a-4bd7-b77f-d5afcaf59a15" />
