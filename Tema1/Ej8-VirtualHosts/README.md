1. Creacion de 2 VirtualHosts -> pruebas.com | ejemplo.conf

- Creamos las carpetas donde se almacenaran 

<img width="585" height="75" alt="image" src="https://github.com/user-attachments/assets/0971ad71-2264-416e-ad0e-f31376fba844" />

- Ahora, nos vamos a /etc/apache2/sites-available y creamos los dos archivos .conf -> "pruebas.conf" ; "ejemplo.conf"

*pruebas.com

<img width="599" height="123" alt="image" src="https://github.com/user-attachments/assets/d3ed8e85-9e3a-4527-9cb5-11fe03349a75" />

 *ejemplo.com

<img width="599" height="142" alt="image" src="https://github.com/user-attachments/assets/71527741-11fa-4491-a027-3b7cc9ccead1" />

- A continuacion, habilitamos los sitios con los comandos "a2ensite pruebas.conf" ; "a2nsite ejemplo.conf"

<img width="790" height="196" alt="image" src="https://github.com/user-attachments/assets/96a83faf-b71e-4a19-a080-fe6b1173afc6" />

- Recargamos apache con "systemctl reload apache2"

<img width="784" height="73" alt="image" src="https://github.com/user-attachments/assets/daab2a50-244b-4b62-a2a3-a343120a4f52" />

Añadimos al archivo hosts los VirtualHost que hemos creado

<img width="560" height="207" alt="image" src="https://github.com/user-attachments/assets/0ad6c412-0d75-4f19-adf1-368373f2d8f0" />

- Por ultimo probamos que las paginas funcionen correctamente

<img width="1079" height="218" alt="image" src="https://github.com/user-attachments/assets/276cab71-f1ed-4f05-9995-93838485e516" />

<img width="877" height="174" alt="image" src="https://github.com/user-attachments/assets/f48b9ed2-a55d-487c-b2b9-afb7e9bf264b" />
