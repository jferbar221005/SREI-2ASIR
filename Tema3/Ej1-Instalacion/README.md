# Instalacion de Docker

Ya que la instalacion la realizare sobre una nueva maquina, actualizamos el repositorio APT e instalamos los certificados para que el sistema confie en los parquetes descargadosy verifique su autenticidad

````
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
````
- 

````
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
````
