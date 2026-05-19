# Ej 3 - Docker

# 1. Descarga la imagen de ubuntu
````
docker pull ubuntu
````

<img width="820" height="202" alt="image" src="https://github.com/user-attachments/assets/0477e9a1-c3af-40fa-b7be-30f742481086" />

# 2. Descarga la imagen de hello-world
````
docker pull hello-world
````

<img width="797" height="162" alt="image" src="https://github.com/user-attachments/assets/a469e843-5f2b-414b-b3a9-8d1ddbf1d3f9" />

# 3. Descarga la imagen nginx
````
docker pull nginx
````

<img width="803" height="342" alt="image" src="https://github.com/user-attachments/assets/a92e0163-db0b-4bbb-8e89-2a0085f359ca" />

# 4. Muestra un listado de todas la imágenes
````
docker images
````

<img width="715" height="167" alt="image" src="https://github.com/user-attachments/assets/8a950438-53a2-4684-b6b6-d5b9c2485784" />

# 5. Ejecuta un contenedor hello-world y dale nombre “myhello1”
````
docker run --name myhello1 hello-world
````

<img width="772" height="102" alt="image" src="https://github.com/user-attachments/assets/7fad1c8a-d70e-4f01-8896-aba37664f5d3" />

# 6. Ejecuta un contenedor hello-world y dale nombre “myhello2
````
docker run --name myhello2 hello-world
````

<img width="755" height="100" alt="image" src="https://github.com/user-attachments/assets/60245553-7809-43b0-9f92-32866478522a" />

# 7. Ejecuta un contenedor hello-world y dale nombre “myhello3”
````
docker run --name myhello3 hello-world
````

<img width="756" height="106" alt="image" src="https://github.com/user-attachments/assets/34df0465-be95-4f15-81f3-bf7a091ab116" />

# 8. Muestra los contenedores que se están ejecutando
````
docker ps -a
````

<img width="1187" height="172" alt="image" src="https://github.com/user-attachments/assets/544ce06b-db13-43ed-aac8-b0c389a0f17c" />

# 9. Para el contenedor "myhello1" 
# (Puede lanzar un aviso si ya se detuvo automáticamente, pero el comando es correcto)
````
docker stop myhello1
````

<img width="377" height="65" alt="image" src="https://github.com/user-attachments/assets/e83d80fd-3421-46ac-91df-d2d23e5b4a89" />

# 10. Para el contenedor "myhello2"
````
docker stop myhello2
````

<img width="380" height="80" alt="image" src="https://github.com/user-attachments/assets/9b98d3fb-c368-4e7d-b79c-a01ca9ce6681" />

# 11. Borra el contenedor “myhello1”
````
docker rm myhello1
````

<img width="363" height="78" alt="image" src="https://github.com/user-attachments/assets/eec4e32c-fedc-404f-82a1-3f18a2c317eb" />

# 12. Muestra los contenedores que se están ejecutando
````
docker ps -a
````

<img width="1107" height="147" alt="image" src="https://github.com/user-attachments/assets/2679347c-51a7-4d1b-9402-ba9d56b74701" />

# 13. Borra todos los contenedores 
# (-f fuerza el borrado, y $(docker ps -aq) le pasa los IDs de todos los contenedores que existan)
````
docker rm -f $(docker ps -aq)
````

<img width="473" height="121" alt="image" src="https://github.com/user-attachments/assets/30ca75d0-1788-4b27-ad95-4a391d9fa9ac" />

