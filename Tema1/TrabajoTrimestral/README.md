- Fase 1: Preparación del Entorno y DNS Local

1ero editamos el archivo hosts con "sudo nano /etc/hosts" y añadimos los dominios que queremos montar

<img width="646" height="133" alt="image" src="https://github.com/user-attachments/assets/0d63d706-fa9e-4a7a-91ca-c8d8ae1cdd85" />

- Fase 2: Instalación de Apache y LAMP Stack

Instalamos Apache, la base de datos y PHP con los módulos necesarios. "sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc"
**Antes de realizar este paso, hacemos un "sudo apt update"**

<img width="1108" height="234" alt="image" src="https://github.com/user-attachments/assets/5401b5bf-d0ae-4803-98ea-92572f18ab54" />
<img width="721" height="89" alt="image" src="https://github.com/user-attachments/assets/397185bf-cdf4-40e5-8470-4261282fac67" />

Ahora, configuramos la BD con el comando "sudo mysql_secure_installation"

-Seleccionamos que si queremos camboar a unix_socket authentication y que no queremos cambiar las contrasña de root

<img width="711" height="508" alt="image" src="https://github.com/user-attachments/assets/26e8542c-66be-4847-85a5-d6c0e36504c5" />

-Terminamos de configurar los siguientes parametros:

<img width="696" height="621" alt="image" src="https://github.com/user-attachments/assets/f37de9fa-b1a2-418f-b306-4a4ca92af101" />

