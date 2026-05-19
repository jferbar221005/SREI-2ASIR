# Actividad 4 - Docker

1. Almacenamiento con "Bind Mounts" (Mapeo local)

Un bind mount vincula una carpeta exacta de tu máquina anfitriona con una carpeta dentro del contenedor. Es muy útil para entornos de desarrollo, ya que cualquier cambio que hagas en tu equipo se refleja inmediatamente en el servicio.

- Vamos a crear una web personalizada sirviéndola con Nginx:

-  Creamos una carpeta local y un archivo HTML básico

````
mkdir -p ~/docker_practica4/web
````
```
echo "<h1>Practica 4 - Bind Mount Funciona</h1>" > ~/docker_practica4/web/index.html
```

# 2. Lanzamos el contenedor montando (-v) la ruta local en la ruta por defecto de Nginx
sudo docker run -d --name nginx_bind -p 8081:80 -v ~/docker_practica4/web:/usr/share/nginx/html nginx
