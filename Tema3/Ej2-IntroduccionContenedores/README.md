# Actividad 2 - Docker

- 2. El "Hola Mundo" de Docker
Este es el paso fundamental para comprobar que el demonio de Docker puede descargar imágenes del registro público y ejecutarlas correctamente.

````
docker run hello-world
````

<img width="805" height="562" alt="image" src="https://github.com/user-attachments/assets/8258b03e-89b6-4252-9c46-f13053cd99d1" />

- Como podemos observar, al finalizar su ejecucion, se para.

<img width="1127" height="98" alt="image" src="https://github.com/user-attachments/assets/72d7e29c-f1c7-4538-87a1-ec1b86ab5c7e" />

2. Ejecución simple de contenedores

- En este ejemplo, el contenedor nace, ejecuta un único comando (hacer un echo por pantalla) y se detiene automáticamente al terminar su proceso principal.

````
docker run ubuntu /bin/echo 'Practica 2 - ASIR'
````

<img width="1198" height="147" alt="image" src="https://github.com/user-attachments/assets/5e048268-b113-4348-9035-205503e57b59" />

3. Ejecutando un contenedor interactivo

- Muchas veces necesitamos entrar al contenedor para revisar configuraciones o depurar. Aquí usamos las opciones -i (interactivo) y -t (tty) para abrir una terminal vinculada.

````
docker run -it --name test_interactivo ubuntu /bin/bash
````

<img width="835" height="366" alt="image" src="https://github.com/user-attachments/assets/0e55a6f6-cb32-4f12-b6a7-673d81815f4a" />


4. Creando un contenedor demonio (en segundo plano)

 -En el día a día, lo normal es que los servicios corran en segundo plano. Utilizamos el flag -d (detach).

````
docker run -d --name mi_demonio ubuntu /bin/sh -c "while true; do echo Ejecutando servicio...; sleep 2; done"
````

<img width="1255" height="72" alt="image" src="https://github.com/user-attachments/assets/3d35b14c-2914-4bfc-93d9-e70a99becd74" />

- Para comprobar que efectivamente está corriendo en background y ver su salida estándar:

````
docker logs my_daemon
````

<img width="377" height="153" alt="image" src="https://github.com/user-attachments/assets/ec8e5491-da1b-4225-81a5-aac7b2bf84db" />


5. Creando un contenedor con un servidor web

- Vamos a exponer un servicio hacia el exterior mapeando los puertos con la opción -p puerto_host:puerto_contenedor.

````
docker run -d --name mi_nginx -p 8080:80 nginx
````

<img width="647" height="72" alt="image" src="https://github.com/user-attachments/assets/6abfc549-1ae9-437f-bc07-29f344ea21a5" />

- Como podemos ver, al acceder a la IP de la maquina y al puerto mapeado en la configuracion, ya tenemos acceso a nginx

<img width="852" height="436" alt="image" src="https://github.com/user-attachments/assets/88072079-66ba-4d67-b119-f731301ca74e" />

6. Configuración de contenedores con variables de entorno

- Al desplegar bases de datos, CMS u otras aplicaciones complejas, se necesitan inyectar parámetros iniciales. Para ello usamos el parámetro -e

````
docker run -d --name mi_mariadb -e MYSQL_ROOT_PASSWORD=root_pass_segura -p 3306:3306 mariadb
````

<img width="1091" height="397" alt="image" src="https://github.com/user-attachments/assets/27bffe0a-7dfe-4115-9f07-fb41781d18b0" />

- Para ver que la variable de entorno se ha introducido correctamente dentro del contenedor en ejecución:

````
docker exec mi_mariadb env | grep MYSQL
````

<img width="557" height="72" alt="image" src="https://github.com/user-attachments/assets/2fd437b0-53eb-4ea8-b884-a2c1b831131c" />
