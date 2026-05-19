# Instalacion de Docker

- Ya que la instalacion la realizare sobre una nueva maquina, actualizamos el repositorio APT e instalamos los certificados para que el sistema confie en los parquetes descargadosy verifique su autenticidad

````
sudo apt-get update
````
<img width="595" height="147" alt="image" src="https://github.com/user-attachments/assets/ab9f61ba-5a1a-48c1-9116-a04b33930fef" />

````
sudo apt-get install ca-certificates curl gnupg
````
<img width="2051" height="397" alt="image" src="https://github.com/user-attachments/assets/e0e63f93-eaf2-4c41-98c4-d1f862ff3eb0" />

- Actualiza el índice de paquetes e instala las herramientas necesarias para permitir que 'apt' use repositorios a través de HTTPS::

````
sudo install -m 0755 -d /etc/apt/keyrings
````
<img width="536" height="46" alt="image" src="https://github.com/user-attachments/assets/6eb363fd-c50a-4276-81c3-28934a1e3c5a" />

````
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
````
<img width="1206" height="50" alt="image" src="https://github.com/user-attachments/assets/d4461387-6522-476d-ab41-247ce4471ccd" />

- Añade el repositorio estable de Docker a tus fuentes de 'apt' (este comando detecta automáticamente la arquitectura y versión del OS):

````
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
````
<img width="1480" height="88" alt="image" src="https://github.com/user-attachments/assets/cc137ef0-1176-4ed2-a087-7909f40ffcc2" />

- Vuelvemos a actualizar la lista de paquetes (ahora incluirá los de Docker) y ejecuta la instalación:
  
````
sudo apt-get update
````
<img width="892" height="213" alt="image" src="https://github.com/user-attachments/assets/4f8063fc-a815-4cc0-9756-1980bd209c8e" />

````
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
````
<img width="2017" height="373" alt="image" src="https://github.com/user-attachments/assets/bb401309-2c79-4045-84cb-341c247bee7b" />

- Para asegurarnos de que todo funciona correctamente, descargamos y ejecutamos la imagen de prueba oficial:

````
docker run hello-world
````
<img width="816" height="243" alt="image" src="https://github.com/user-attachments/assets/640a9fda-29d5-4c8b-a90c-2ef3e5f7c924" />

