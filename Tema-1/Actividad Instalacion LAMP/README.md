# Instalación Pila LAMP

- Primero hacemos “sudo -i” para no tener problemas de permisos

<img width="711" height="168" alt="image" src="https://github.com/user-attachments/assets/372fc4d2-f887-4c44-8977-3ed3ee5955a8" />

- Ahora, realizamos un "apt update"
<img width="699" height="196" alt="image" src="https://github.com/user-attachments/assets/382ac6b3-659e-49f8-a0c6-a7bcbe1f5ff9" />

- y a continuacion "apt upgrade"
<img width="515" height="23" alt="image" src="https://github.com/user-attachments/assets/b3ff9ce5-4554-41d2-97eb-12430fc038d9" />
<img width="687" height="92" alt="image" src="https://github.com/user-attachments/assets/72e072f9-bf7f-40cf-967c-010a8881e75c" />

- INSTALACION APACHE - Lo primero que haremos será instalar “apache2” para ello, usamos el comando “apt install apache2 -y”

<img width="1029" height="276" alt="image" src="https://github.com/user-attachments/assets/d728c635-47b8-4a24-99c6-6dc6963f7c5b" />

- Para configurar el firewall, primero debemos ver si esta bien instalado apache, para ello, usamos el “ufw app list”

<img width="511" height="144" alt="image" src="https://github.com/user-attachments/assets/42c822e0-d6d5-4ff6-8228-8ad08a57df73" />

- Para configurar el firewall, permitimos las conexiones de apache2 " ufw allow in "Apache" "

<img width="589" height="81" alt="image" src="https://github.com/user-attachments/assets/8685247f-58a2-4004-a479-c8873645834b" />

- Comprobamos que este configurado ufw con " ufw status"

<img width="485" height="176" alt="image" src="https://github.com/user-attachments/assets/2e1124f5-c42a-4294-9238-6d9f162d7d29" />

- INSTALACION MYSQL - Hacemos un " apt install mysql-server "

<img width="1043" height="409" alt="image" src="https://github.com/user-attachments/assets/1b6347ae-caa7-4879-b508-284af41c8274" />

- En este caso como es un server privado, dejamos la contraseña con 0 de strong

<img width="657" height="137" alt="image" src="https://github.com/user-attachments/assets/6859b5c9-1276-489c-a17d-3b43f75fd1e1" />

- Le indicamos que si queremos eliminar los usuarios anonimos

<img width="669" height="170" alt="image" src="https://github.com/user-attachments/assets/c827fc37-35cc-4ea9-810e-4b4c755b29bb" />

- Le indicamos que si queremos logearnos con el root en remoto, para evitar problemas futuros con conexiones

<img width="670" height="115" alt="image" src="https://github.com/user-attachments/assets/1a211a22-6ee5-4210-98a2-212c5e85a6c4" />

- Indicamos que 

<img width="745" height="146" alt="image" src="https://github.com/user-attachments/assets/fdbea41f-4ef2-42d8-824c-66dc42f878e1" />

-




